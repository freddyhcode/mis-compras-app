import 'dart:math';

import 'package:mis_compras_app/core/constants/constants.dart';
import 'package:mis_compras_app/core/services/local_database/local_database.dart';
import 'package:mis_compras_app/core/services/secure_storage/wrapper_secure_storage.dart';
import 'package:mis_compras_app/core/services/secure_storage/wrapper_secure_storage_impl.dart';
import 'package:path/path.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class LocalDatabaseImpl implements LocalDatabase {
  LocalDatabaseImpl({WrapperSecureStorage? storage})
    : _storage = storage ?? WrapperSecureStorageImpl();

  static const String _keyName = 'mis_compras.db.key.v1';

  final WrapperSecureStorage _storage;
  Database? _db;

  @override
  Future<Database> connection() async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, Constants.db.name);
    final password = await _databaseKey();

    final db = await openDatabase(
      path,
      password: password,
      version: Constants.db.version,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await _createTables(db);
      },
    );

    try {
      final cipher = await db.rawQuery('PRAGMA cipher_version');
      final version = cipher.isEmpty ? null : cipher.first.values.first;

      if (version == null || version.toString().trim().isEmpty) {
        throw StateError('SQLCipher is not available.');
      }
    } catch (_) {
      try {
        await db.close();
      } catch (_) {
        // The database is closed; the original error is preserved.
      }
      rethrow;
    }

    return db;
  }

  Future<String> _databaseKey() async {
    final existing = await _storage.getKeyValue<String>(_keyName);
    if (existing != null && existing.isNotEmpty) return existing;

    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    final key = bytes
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();

    await _storage.setKeyValue<String>(_keyName, key);
    return key;
  }

  @override
  Future<void> initTables() async {
    final db = await connection();
    await _createTables(db);
  }

  @override
  Future<void> reset() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, Constants.db.name);

    if (_db != null) {
      await _db!.close();
      _db = null;
    }

    await deleteDatabase(path);
    await _storage.removeKey(_keyName);
  }

  Future<void> _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${Constants.db.tablePurchases} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        purchased_at TEXT NOT NULL,
        merchant TEXT,
        category TEXT,
        notes TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${Constants.db.tablePurchaseItems} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        purchase_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        quantity_milli INTEGER NOT NULL,
        unit TEXT NOT NULL,
        unit_price_clp INTEGER NOT NULL,
        position INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (purchase_id)
          REFERENCES ${Constants.db.tablePurchases} (id)
          ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${Constants.db.tableSettings} (
        key TEXT PRIMARY KEY NOT NULL,
        value TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_purchases_date
      ON ${Constants.db.tablePurchases} (purchased_at)
    ''');

    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_items_purchase
      ON ${Constants.db.tablePurchaseItems} (purchase_id)
    ''');
  }
}

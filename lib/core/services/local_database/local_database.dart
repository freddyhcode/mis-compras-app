import 'package:sqflite_sqlcipher/sqflite.dart';

abstract class LocalDatabase {
  Future<Database> connection();

  Future<void> initTables();

  Future<void> reset();
}

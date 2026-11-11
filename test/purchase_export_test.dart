import 'package:excel/excel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mis_compras_app/core/l10n/app_localizations_es.dart';
import 'package:mis_compras_app/core/services/files/file_saver.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_entity.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_item_entity.dart';
import 'package:mis_compras_app/features/purchases/presentation/utils/purchase_export.dart';

class _FakeFileSaver implements FileSaver {
  List<int>? bytes;
  String? fileName;

  @override
  Future<void> save({
    required String fileName,
    required List<int> bytes,
    required String mimeType,
    required String title,
  }) async {
    this.fileName = fileName;
    this.bytes = bytes;
  }
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting();
  });

  test('genera un archivo xlsx con compras y productos', () async {
    final now = DateTime(2026, 10, 31);
    final purchase = PurchaseEntity(
      id: 1,
      title: 'compra de prueba',
      purchasedAt: '2026-10-12',
      merchant: 'lider',
      category: 'supermercado',
      notes: 'compra semanal',
      createdAt: now,
      updatedAt: now,
      items: [
        PurchaseItemEntity(
          id: 1,
          purchaseId: 1,
          name: 'leche',
          quantityMilli: 2000,
          unit: 'un',
          unitPriceClp: 1250,
          position: 0,
          createdAt: now,
          updatedAt: now,
        ),
      ],
    );

    final fileSaver = _FakeFileSaver();

    await exportPurchasesToXlsx(
      purchases: [purchase],
      l10n: AppLocalizationsEs(),
      fileSaver: fileSaver,
    );

    expect(fileSaver.bytes, isNotNull);
    expect(fileSaver.bytes!.length, greaterThan(100));
    expect(fileSaver.fileName, endsWith('.xlsx'));

    final workbook = Excel.decodeBytes(fileSaver.bytes!);
    expect(
      workbook.tables.keys,
      containsAll(['Resumen', 'Compras', 'Productos']),
    );
    expect(workbook.tables['Compras']!.rows.length, 2);
    expect(workbook.tables['Productos']!.rows.length, 2);
  });
}

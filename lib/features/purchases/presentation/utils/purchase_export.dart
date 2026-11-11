import 'package:excel/excel.dart';
import 'package:mis_compras_app/core/l10n/app_localizations.dart';
import 'package:mis_compras_app/core/services/files/file_saver.dart';
import 'package:mis_compras_app/core/utils/date.dart';
import 'package:mis_compras_app/core/utils/text.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_entity.dart';
import 'package:mis_compras_app/features/purchases/presentation/utils/purchase_format.dart';
import 'package:mis_compras_app/features/purchases/presentation/utils/purchase_labels.dart';

const String _xlsxMimeType =
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';

String _safeText(String value) {
  return RegExp(r'^[=+\-@]').hasMatch(value) ? "'$value" : value;
}

void _write(
  Sheet sheet,
  int row,
  int column,
  CellValue? value, {
  CellStyle? style,
}) {
  final cell = sheet.cell(
    CellIndex.indexByColumnRow(columnIndex: column, rowIndex: row),
  );
  cell.value = value;
  if (style != null) cell.cellStyle = style;
}

Future<void> exportPurchasesToXlsx({
  required List<PurchaseEntity> purchases,
  required AppLocalizations l10n,
  required FileSaver fileSaver,
}) async {
  final workbook = Excel.createExcel();
  final summaryName = l10n.exportSummary;
  workbook.rename('Sheet1', summaryName);

  final border = Border(
    borderStyle: BorderStyle.Thin,
    borderColorHex: ExcelColor.fromHexString('FFD9CDE8'),
  );
  final headerStyle = CellStyle(
    bold: true,
    backgroundColorHex: ExcelColor.fromHexString('FFF0EAF7'),
    fontColorHex: ExcelColor.fromHexString('FF2F2A36'),
    leftBorder: border,
    rightBorder: border,
    topBorder: border,
    bottomBorder: border,
  );
  final moneyStyle = CellStyle(
    numberFormat: NumFormat.custom(formatCode: r'"$"#,##0'),
  );
  final quantityStyle = CellStyle(
    numberFormat: NumFormat.custom(formatCode: '#,##0.###'),
  );

  final total = purchases.fold(
    0,
    (sum, purchase) => sum + purchaseTotalClp(purchase),
  );
  final productCount = purchases.fold(
    0,
    (sum, purchase) => sum + purchase.items.length,
  );
  final average = purchases.isEmpty ? 0 : (total / purchases.length).round();

  final summary = workbook[summaryName];
  _write(summary, 0, 0, TextCellValue(l10n.exportSummary), style: headerStyle);
  _write(summary, 0, 1, TextCellValue(l10n.exportTotal), style: headerStyle);
  _write(summary, 1, 0, TextCellValue(l10n.exportPurchasesRegistered));
  _write(summary, 1, 1, IntCellValue(purchases.length));
  _write(summary, 2, 0, TextCellValue(l10n.exportProductsRegistered));
  _write(summary, 2, 1, IntCellValue(productCount));
  _write(summary, 3, 0, TextCellValue(l10n.exportTotalSpent));
  _write(summary, 3, 1, DoubleCellValue(total.toDouble()), style: moneyStyle);
  _write(summary, 4, 0, TextCellValue(l10n.exportAverage));
  _write(summary, 4, 1, DoubleCellValue(average.toDouble()), style: moneyStyle);
  _write(summary, 5, 0, TextCellValue(l10n.exportExportedAt));
  _write(
    summary,
    5,
    1,
    TextCellValue(formatIsoDate(todayIsoDate(), l10n.localeName)),
  );
  summary.setColumnWidth(0, 28);
  summary.setColumnWidth(1, 18);

  final purchasesSheet = workbook[l10n.exportPurchases];
  final purchaseHeaders = [
    l10n.exportTitle,
    l10n.exportDate,
    l10n.exportPlace,
    l10n.exportCategory,
    l10n.exportProductsCount,
    l10n.exportTotal,
    l10n.exportNotes,
  ];

  for (var column = 0; column < purchaseHeaders.length; column++) {
    _write(
      purchasesSheet,
      0,
      column,
      TextCellValue(purchaseHeaders[column]),
      style: headerStyle,
    );
  }

  for (var index = 0; index < purchases.length; index++) {
    final purchase = purchases[index];
    final row = index + 1;

    _write(
      purchasesSheet,
      row,
      0,
      TextCellValue(_safeText(capitalizeText(purchase.title))),
    );
    _write(
      purchasesSheet,
      row,
      1,
      TextCellValue(formatIsoDate(purchase.purchasedAt, l10n.localeName)),
    );
    _write(
      purchasesSheet,
      row,
      2,
      TextCellValue(_safeText(capitalizeText(purchase.merchant ?? ''))),
    );
    _write(
      purchasesSheet,
      row,
      3,
      TextCellValue(_safeText(purchaseCategoryLabel(l10n, purchase.category))),
    );
    _write(purchasesSheet, row, 4, IntCellValue(purchase.items.length));
    _write(
      purchasesSheet,
      row,
      5,
      DoubleCellValue(purchaseTotalClp(purchase).toDouble()),
      style: moneyStyle,
    );
    _write(
      purchasesSheet,
      row,
      6,
      TextCellValue(_safeText(capitalizeText(purchase.notes ?? ''))),
    );
  }

  purchasesSheet.setColumnWidth(0, 28);
  purchasesSheet.setColumnWidth(1, 14);
  purchasesSheet.setColumnWidth(2, 22);
  purchasesSheet.setColumnWidth(3, 18);
  purchasesSheet.setColumnWidth(4, 12);
  purchasesSheet.setColumnWidth(5, 16);
  purchasesSheet.setColumnWidth(6, 36);

  final productsSheet = workbook[l10n.exportProducts];
  final productHeaders = [
    l10n.exportPurchases,
    l10n.exportProduct,
    l10n.exportQuantity,
    l10n.exportUnit,
    l10n.exportUnitPrice,
    l10n.exportSubtotal,
  ];

  for (var column = 0; column < productHeaders.length; column++) {
    _write(
      productsSheet,
      0,
      column,
      TextCellValue(productHeaders[column]),
      style: headerStyle,
    );
  }

  var productRow = 1;
  for (final purchase in purchases) {
    for (final item in purchase.items) {
      _write(
        productsSheet,
        productRow,
        0,
        TextCellValue(_safeText(capitalizeText(purchase.title))),
      );
      _write(
        productsSheet,
        productRow,
        1,
        TextCellValue(_safeText(capitalizeText(item.name))),
      );
      _write(
        productsSheet,
        productRow,
        2,
        DoubleCellValue(item.quantityMilli / 1000),
        style: quantityStyle,
      );
      _write(
        productsSheet,
        productRow,
        3,
        TextCellValue(unitName(l10n, item.unit, item.quantityMilli)),
      );
      _write(
        productsSheet,
        productRow,
        4,
        DoubleCellValue(item.unitPriceClp.toDouble()),
        style: moneyStyle,
      );
      _write(
        productsSheet,
        productRow,
        5,
        DoubleCellValue(subtotalClp(item).toDouble()),
        style: moneyStyle,
      );
      productRow++;
    }
  }

  productsSheet.setColumnWidth(0, 28);
  productsSheet.setColumnWidth(1, 28);
  productsSheet.setColumnWidth(2, 12);
  productsSheet.setColumnWidth(3, 10);
  productsSheet.setColumnWidth(4, 22);
  productsSheet.setColumnWidth(5, 18);

  final bytes = workbook.save();
  if (bytes == null) {
    throw StateError('Could not build the Excel file.');
  }

  await fileSaver.save(
    fileName: 'mis-compras-${todayIsoDate()}.xlsx',
    bytes: bytes,
    mimeType: _xlsxMimeType,
    title: l10n.settingsExport,
  );
}

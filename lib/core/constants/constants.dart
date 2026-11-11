class Constants {
  const Constants._();

  static const String appVersion = '0.1.0';
  static const db = _DatabaseConstants();
}

class _DatabaseConstants {
  const _DatabaseConstants();

  final String name = 'mis_compras.db';
  final int version = 1;
  final String tablePurchases = 'purchases';
  final String tablePurchaseItems = 'purchase_items';
  final String tableSettings = 'settings';
}

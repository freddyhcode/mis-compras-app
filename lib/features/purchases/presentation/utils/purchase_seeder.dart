import 'package:mis_compras_app/core/utils/date.dart';

class SeedProduct {
  const SeedProduct({
    required this.name,
    required this.quantityMilli,
    required this.unit,
    required this.unitPriceClp,
  });

  final String name;
  final int quantityMilli;
  final String unit;
  final int unitPriceClp;
}

class SeedPurchase {
  const SeedPurchase({
    required this.title,
    required this.purchasedAt,
    required this.merchant,
    required this.category,
    required this.products,
    this.notes,
  });

  final String title;
  final String purchasedAt;
  final String merchant;
  final String category;
  final String? notes;
  final List<SeedProduct> products;
}

String _dateMonthsAgo(int monthsAgo, int day) {
  final now = DateTime.now();
  return toIsoDate(DateTime(now.year, now.month - monthsAgo, day));
}

List<SeedPurchase> buildSeedPurchases() {
  return [
    SeedPurchase(
      title: 'Súper de la semana',
      purchasedAt: _dateMonthsAgo(0, 12),
      merchant: 'Lider',
      category: 'supermercado',
      notes: 'Compra semanal',
      products: const [
        SeedProduct(
          name: 'Leche',
          quantityMilli: 2000,
          unit: 'un',
          unitPriceClp: 1250,
        ),
        SeedProduct(
          name: 'Arroz',
          quantityMilli: 1000,
          unit: 'kg',
          unitPriceClp: 1890,
        ),
        SeedProduct(
          name: 'Jugo',
          quantityMilli: 750,
          unit: 'L',
          unitPriceClp: 2400,
        ),
        SeedProduct(
          name: 'Pan',
          quantityMilli: 1000,
          unit: 'un',
          unitPriceClp: 2200,
        ),
      ],
    ),
    SeedPurchase(
      title: 'Audífonos Bluetooth',
      purchasedAt: _dateMonthsAgo(0, 4),
      merchant: 'Mercado Libre',
      category: 'online',
      products: const [
        SeedProduct(
          name: 'Audífonos',
          quantityMilli: 1000,
          unit: 'un',
          unitPriceClp: 29990,
        ),
        SeedProduct(
          name: 'Envío',
          quantityMilli: 1000,
          unit: 'un',
          unitPriceClp: 3990,
        ),
      ],
    ),
    SeedPurchase(
      title: 'Aseo del mes',
      purchasedAt: _dateMonthsAgo(1, 20),
      merchant: 'Jumbo',
      category: 'hogar',
      products: const [
        SeedProduct(
          name: 'Detergente',
          quantityMilli: 1000,
          unit: 'un',
          unitPriceClp: 8990,
        ),
        SeedProduct(
          name: 'Papel higiénico',
          quantityMilli: 1000,
          unit: 'un',
          unitPriceClp: 6500,
        ),
        SeedProduct(
          name: 'Bolsas de basura',
          quantityMilli: 1000,
          unit: 'un',
          unitPriceClp: 2500,
        ),
      ],
    ),
    SeedPurchase(
      title: 'Teclado mecánico',
      purchasedAt: _dateMonthsAgo(1, 8),
      merchant: 'AliExpress',
      category: 'tecnologia',
      products: const [
        SeedProduct(
          name: 'Teclado',
          quantityMilli: 1000,
          unit: 'un',
          unitPriceClp: 45990,
        ),
        SeedProduct(
          name: 'Envío',
          quantityMilli: 1000,
          unit: 'un',
          unitPriceClp: 5990,
        ),
      ],
    ),
    SeedPurchase(
      title: 'Feria del sábado',
      purchasedAt: _dateMonthsAgo(2, 17),
      merchant: 'Feria',
      category: 'supermercado',
      products: const [
        SeedProduct(
          name: 'Tomates',
          quantityMilli: 1500,
          unit: 'kg',
          unitPriceClp: 1600,
        ),
        SeedProduct(
          name: 'Palta',
          quantityMilli: 800,
          unit: 'kg',
          unitPriceClp: 3500,
        ),
        SeedProduct(
          name: 'Limones',
          quantityMilli: 1000,
          unit: 'kg',
          unitPriceClp: 1200,
        ),
      ],
    ),
    SeedPurchase(
      title: 'Polera y pantalón',
      purchasedAt: _dateMonthsAgo(3, 9),
      merchant: 'Zara',
      category: 'ropa',
      products: const [
        SeedProduct(
          name: 'Polera',
          quantityMilli: 1000,
          unit: 'un',
          unitPriceClp: 15990,
        ),
        SeedProduct(
          name: 'Pantalón',
          quantityMilli: 1000,
          unit: 'un',
          unitPriceClp: 29990,
        ),
      ],
    ),
    SeedPurchase(
      title: 'Libro de cocina',
      purchasedAt: _dateMonthsAgo(3, 22),
      merchant: 'Buscalibre',
      category: 'online',
      products: const [
        SeedProduct(
          name: 'Libro',
          quantityMilli: 1000,
          unit: 'un',
          unitPriceClp: 18990,
        ),
        SeedProduct(
          name: 'Envío',
          quantityMilli: 1000,
          unit: 'un',
          unitPriceClp: 3500,
        ),
      ],
    ),
    SeedPurchase(
      title: 'Lámpara de escritorio',
      purchasedAt: _dateMonthsAgo(4, 14),
      merchant: 'Sodimac',
      category: 'hogar',
      products: const [
        SeedProduct(
          name: 'Lámpara',
          quantityMilli: 1000,
          unit: 'un',
          unitPriceClp: 12990,
        ),
        SeedProduct(
          name: 'Ampolleta',
          quantityMilli: 1000,
          unit: 'un',
          unitPriceClp: 3990,
        ),
      ],
    ),
    SeedPurchase(
      title: 'Compra rápida',
      purchasedAt: _dateMonthsAgo(5, 6),
      merchant: 'Santa Isabel',
      category: 'supermercado',
      products: const [
        SeedProduct(
          name: 'Café',
          quantityMilli: 1000,
          unit: 'un',
          unitPriceClp: 5990,
        ),
        SeedProduct(
          name: 'Galletas',
          quantityMilli: 2000,
          unit: 'un',
          unitPriceClp: 1290,
        ),
        SeedProduct(
          name: 'Yogur',
          quantityMilli: 4000,
          unit: 'un',
          unitPriceClp: 690,
        ),
      ],
    ),
    SeedPurchase(
      title: 'Cargador USB-C',
      purchasedAt: _dateMonthsAgo(5, 24),
      merchant: 'Mercado Libre',
      category: 'tecnologia',
      products: const [
        SeedProduct(
          name: 'Cargador',
          quantityMilli: 1000,
          unit: 'un',
          unitPriceClp: 9990,
        ),
        SeedProduct(
          name: 'Cable USB-C',
          quantityMilli: 1000,
          unit: 'un',
          unitPriceClp: 4990,
        ),
      ],
    ),
  ];
}

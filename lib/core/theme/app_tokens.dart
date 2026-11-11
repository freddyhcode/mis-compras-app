import 'dart:ui';

class AppSpacing {
  const AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
}

class AppRadius {
  const AppRadius._();

  static const double sm = 10;
  static const double md = 14;
  static const double lg = 20;
  static const double pill = 999;
}

class AppTypeToken {
  const AppTypeToken({
    required this.size,
    required this.lineHeight,
    required this.weight,
  });

  final double size;
  final double lineHeight;
  final FontWeight weight;

  double height() => lineHeight / size;
}

class AppTypography {
  const AppTypography._();

  static const display = AppTypeToken(
    size: 28,
    lineHeight: 36,
    weight: FontWeight.w700,
  );
  static const headline = AppTypeToken(
    size: 22,
    lineHeight: 30,
    weight: FontWeight.w700,
  );
  static const title = AppTypeToken(
    size: 19,
    lineHeight: 27,
    weight: FontWeight.w600,
  );
  static const body = AppTypeToken(
    size: 16,
    lineHeight: 24,
    weight: FontWeight.w400,
  );
  static const small = AppTypeToken(
    size: 14,
    lineHeight: 21,
    weight: FontWeight.w400,
  );
  static const caption = AppTypeToken(
    size: 12,
    lineHeight: 17,
    weight: FontWeight.w400,
  );
  static const label = AppTypeToken(
    size: 15,
    lineHeight: 21,
    weight: FontWeight.w600,
  );
  static const navLabel = AppTypeToken(
    size: 11,
    lineHeight: 14,
    weight: FontWeight.w600,
  );
}

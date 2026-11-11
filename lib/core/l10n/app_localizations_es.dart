// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get loadError => 'No pudimos abrir tus datos.';

  @override
  String get tabsHome => 'Inicio';

  @override
  String get tabsHistory => 'Historial';

  @override
  String get tabsStats => 'Estadísticas';

  @override
  String get tabsSettings => 'Ajustes';

  @override
  String get homeEmptyTitle => 'Aún no hay compras';

  @override
  String get homeEmptyDescription =>
      'Crea tu primera compra para empezar a registrar tus gastos.';

  @override
  String get historyEmptyTitle => 'No hay compras registradas';

  @override
  String get historyEmptyDescription =>
      'Tu historial de compras aparecerá aquí.';

  @override
  String get statsEmptyTitle => 'Todavía no hay datos';

  @override
  String get statsEmptyDescription =>
      'Cuando registres compras, verás tus estadísticas aquí.';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsSpanish => 'Español';

  @override
  String get settingsEnglish => 'English';

  @override
  String get settingsAppearance => 'Apariencia';

  @override
  String get settingsAppearanceDesc => 'Tema y color de acento.';

  @override
  String get settingsData => 'Datos';

  @override
  String get settingsExport => 'Exportar';

  @override
  String get settingsExportDesc =>
      'Descarga o comparte un archivo .xlsx con tus compras.';

  @override
  String get settingsExportSuccess => 'Excel generado';

  @override
  String get settingsExportSuccessBody =>
      'El archivo está listo para descargar o compartir.';

  @override
  String get settingsExportError => 'No pudimos exportar los datos.';

  @override
  String get settingsDeleteAll => 'Eliminar todos los datos';

  @override
  String get settingsDeleteAllDesc =>
      'Elimina compras, productos y ajustes de este dispositivo.';

  @override
  String get settingsDeleteTitle => 'Eliminar todos los datos';

  @override
  String get settingsDeleteBody =>
      'Se eliminarán todas tus compras y no se podrán recuperar. Los archivos Excel ya exportados no se eliminan.';

  @override
  String get settingsDeleteConfirm => 'Eliminar todo';

  @override
  String get settingsDeleteSuccess => 'Datos eliminados.';

  @override
  String get settingsDeleteError => 'No pudimos eliminar los datos.';

  @override
  String get tutorialTitle => 'Bienvenido a Mis Compras';

  @override
  String get tutorialDescription =>
      'Registra tus compras, productos y gastos en pesos chilenos. Todo queda en tu dispositivo.';

  @override
  String get tutorialPurchases => 'Crea compras y agrega productos.';

  @override
  String get tutorialHistory => 'Busca y filtra tu historial.';

  @override
  String get tutorialStats => 'Revisa tus gastos por mes y categoría.';

  @override
  String get tutorialPrivacy =>
      'Sin cuentas, nube ni analítica. Puedes exportar o borrar tus datos desde Ajustes.';

  @override
  String get tutorialStart => 'Empezar';

  @override
  String get settingsLegalSection => 'Legal';

  @override
  String get settingsLegal => 'Privacidad y términos';

  @override
  String get settingsLegalDesc =>
      'Cómo se guardan tus datos y condiciones de uso.';

  @override
  String get legalTitle => 'Privacidad y términos';

  @override
  String get legalDraft =>
      'Texto informativo. La versión legal definitiva se revisará antes de publicar.';

  @override
  String get legalPrivacyTitle => 'Privacidad';

  @override
  String get legalPrivacyBody =>
      'Mis Compras guarda en tu dispositivo los datos que ingresas. No crea cuentas, no envía datos a servidores ni usa analítica. Puedes borrar una compra o todos tus datos desde Ajustes.';

  @override
  String get legalTermsTitle => 'Términos';

  @override
  String get legalTermsBody =>
      'Mis Compras es una herramienta de registro personal. No verifica precios ni reemplaza asesoría financiera, contable o legal. Eres responsable de los datos que ingresas y de los archivos que exportas.';

  @override
  String legalFooter(String appName) {
    return 'Mis Compras · 100% local';
  }

  @override
  String get exportSummary => 'Resumen';

  @override
  String get exportPurchases => 'Compras';

  @override
  String get exportProducts => 'Productos';

  @override
  String get exportTitle => 'Título';

  @override
  String get exportDate => 'Fecha';

  @override
  String get exportPlace => 'Lugar';

  @override
  String get exportCategory => 'Categoría';

  @override
  String get exportProductsCount => 'Productos';

  @override
  String get exportTotal => 'Total (CLP)';

  @override
  String get exportNotes => 'Notas';

  @override
  String get exportProduct => 'Producto';

  @override
  String get exportQuantity => 'Cantidad';

  @override
  String get exportUnit => 'Unidad';

  @override
  String get exportUnitPrice => 'Precio unitario (CLP)';

  @override
  String get exportSubtotal => 'Subtotal (CLP)';

  @override
  String get exportPurchasesRegistered => 'Compras registradas';

  @override
  String get exportProductsRegistered => 'Productos registrados';

  @override
  String get exportTotalSpent => 'Total gastado (CLP)';

  @override
  String get exportAverage => 'Promedio por compra (CLP)';

  @override
  String get exportExportedAt => 'Fecha de exportación';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsLight => 'Claro';

  @override
  String get settingsDark => 'Oscuro';

  @override
  String get settingsColor => 'Color';

  @override
  String get settingsAutoSave => 'Los cambios se guardan automáticamente.';

  @override
  String get settingsAboutSection => 'Acerca de';

  @override
  String get settingsCreator => 'Creador';

  @override
  String get settingsCreatorDesc => 'Quién hizo la app.';

  @override
  String get settingsAppInfo => 'La aplicación';

  @override
  String get settingsAppInfoDesc => 'Versión, privacidad y licencia.';

  @override
  String get settingsPrivacy =>
      'Tus datos viven en tu dispositivo. No hay cuentas, nube ni analítica.';

  @override
  String get settingsVersion => 'Versión';

  @override
  String get aboutWhatIs =>
      'Mis Compras es un registro personal de compras y gastos en pesos chilenos. Guarda qué compraste, cuánto pagaste y cuándo.';

  @override
  String get aboutLocal =>
      'Los datos quedan en tu dispositivo. Puedes borrar una compra o todos tus datos desde Ajustes. Los archivos Excel exportados quedan fuera de la app.';

  @override
  String get aboutLicense => 'Licencia';

  @override
  String get aboutLicenseBody => 'MIT.';

  @override
  String get aboutMadeIn => 'Hecho en Chile.';

  @override
  String get creatorWebsite => 'Sitio web';

  @override
  String get creatorGithub => 'GitHub';

  @override
  String get creatorContact => 'Contacto';

  @override
  String get creatorSupport => 'Apoyo';

  @override
  String get accentsLavanda => 'Lavanda';

  @override
  String get accentsMenta => 'Menta';

  @override
  String get accentsDurazno => 'Durazno';

  @override
  String get accentsRosa => 'Rosa';

  @override
  String get accentsCielo => 'Cielo';

  @override
  String get commonBack => 'Volver';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get commonRequired => 'Obligatorio';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get errorsLoad => 'No pudimos abrir los datos. Intenta de nuevo.';

  @override
  String get errorsSave => 'No pudimos guardar los cambios.';

  @override
  String get errorsDelete => 'No pudimos eliminar.';

  @override
  String get tutorialTheme => 'Tema claro, oscuro y colores.';

  @override
  String get tutorialLocal => 'Tus datos se guardan en el dispositivo.';

  @override
  String get tutorialData => 'Exporta a Excel o borra todo cuando quieras.';

  @override
  String get homeWelcomeTitle => 'Tu base está lista';

  @override
  String get homeWelcomeDescription =>
      'Cambia el nombre, el tema y la feature de ejemplo para empezar.';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsAccent => 'Color';

  @override
  String get settingsDev => 'Desarrollo';

  @override
  String get settingsMode => 'Modo de datos';

  @override
  String get settingsModeDevelopment => 'Desarrollo';

  @override
  String get settingsModeDemo => 'Demo';

  @override
  String get settingsModeProduction => 'Producción';

  @override
  String get settingsSeed => 'Cargar datos de prueba';

  @override
  String get settingsSeedDesc =>
      'Agrega compras de ejemplo para revisar la app.';

  @override
  String get settingsSeedBody =>
      'Se agregarán 10 compras de ejemplo a tus datos actuales. No se borra nada.';

  @override
  String get settingsSeedConfirm => 'Cargar';

  @override
  String settingsSeedSuccess(int count) {
    return '$count compras de prueba cargadas.';
  }

  @override
  String get settingsSeedError => 'No pudimos cargar los datos de prueba.';

  @override
  String get accentLavanda => 'Lavanda';

  @override
  String get accentMenta => 'Menta';

  @override
  String get accentDurazno => 'Durazno';

  @override
  String get accentRosa => 'Rosa';

  @override
  String get accentCielo => 'Cielo';

  @override
  String get categorySupermercado => 'Supermercado';

  @override
  String get categoryOnline => 'Online';

  @override
  String get categoryHogar => 'Hogar';

  @override
  String get categoryTecnologia => 'Tecnología';

  @override
  String get categoryRopa => 'Ropa';

  @override
  String get categoryOtros => 'Otros';

  @override
  String get commonAccept => 'Aceptar';

  @override
  String get historyAll => 'Todas';

  @override
  String get historySearch => 'Buscar';

  @override
  String get historySearchHint => 'Producto, título o lugar';

  @override
  String get homeMonthTotal => 'Este mes';

  @override
  String get homePurchases => 'Compras';

  @override
  String get homeAverage => 'Promedio';

  @override
  String get newPurchase => 'Crear compra';

  @override
  String get homeRecent => 'Compras recientes';

  @override
  String get purchasesTitle => 'Compras';

  @override
  String get purchasesEmptyTitle => 'Aún no hay compras';

  @override
  String get purchasesEmptyDescription =>
      'Crea tu primera compra para empezar a registrar tus gastos.';

  @override
  String get purchaseNewTitle => 'Nueva compra';

  @override
  String get purchaseEditTitle => 'Editar compra';

  @override
  String get purchaseDetailTitle => 'Compra';

  @override
  String get purchaseTitleLabel => 'Título';

  @override
  String get purchaseTitlePlaceholder => 'Ej. Compra online';

  @override
  String get purchaseDate => 'Fecha';

  @override
  String get purchaseDateHelp => 'Formato AAAA-MM-DD';

  @override
  String get purchaseMerchant => 'Lugar o tienda';

  @override
  String get purchaseMerchantPlaceholder => 'Opcional';

  @override
  String get purchaseCategory => 'Categoría';

  @override
  String get purchaseNotes => 'Notas';

  @override
  String get purchaseNotesPlaceholder => 'Opcional';

  @override
  String get purchaseProducts => 'Productos';

  @override
  String purchaseProductCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count productos',
      one: '1 producto',
    );
    return '$_temp0';
  }

  @override
  String get purchaseAddProduct => 'Agregar';

  @override
  String get purchaseNoProducts => 'Todavía no hay productos.';

  @override
  String get purchaseCreatedAt => 'Creada';

  @override
  String get purchaseEdit => 'Editar';

  @override
  String get purchaseTotal => 'Total de la compra';

  @override
  String get purchaseSave => 'Guardar';

  @override
  String get purchaseSaved => 'Compra guardada.';

  @override
  String get purchaseDeleteTitle => 'Eliminar compra';

  @override
  String get purchaseDeleteAction => 'Eliminar';

  @override
  String get purchaseDeleteBody =>
      'Se eliminarán la compra y todos sus productos. No se puede deshacer.';

  @override
  String get purchaseDeleteConfirm => 'Eliminar';

  @override
  String get purchaseDuplicate => 'Duplicar';

  @override
  String get purchaseDuplicateSuffix => ' (copia)';

  @override
  String get purchaseNotFound => 'No encontramos esa compra.';

  @override
  String get purchaseInvalidTitle => 'Escribe un título.';

  @override
  String get purchaseInvalidDate => 'Usa el formato AAAA-MM-DD.';

  @override
  String get productNewTitle => 'Agregar producto';

  @override
  String get productEditTitle => 'Editar producto';

  @override
  String get productFormTitle => 'Datos del producto';

  @override
  String get productName => 'Producto';

  @override
  String get productNamePlaceholder => 'Ej. Audífonos';

  @override
  String get productQuantity => 'Cantidad';

  @override
  String get productUnit => 'Unidad de medida';

  @override
  String get productPrice => 'Precio unitario';

  @override
  String get productSubtotal => 'Subtotal';

  @override
  String get productSave => 'Guardar';

  @override
  String get productSaveAndAdd => 'Guardar y nuevo';

  @override
  String get productDeleteTitle => 'Eliminar producto';

  @override
  String get productDeleteAction => 'Eliminar';

  @override
  String get productDeleteBody => 'Se quitará este producto de la compra.';

  @override
  String get productDeleteConfirm => 'Eliminar';

  @override
  String get productInvalidName => 'Escribe un nombre.';

  @override
  String get productInvalidQuantity => 'La cantidad debe ser mayor que 0.';

  @override
  String get productInvalidInteger => 'Para unidades, usa un número entero.';

  @override
  String get productInvalidPrice => 'El precio no puede ser negativo.';

  @override
  String get productIntegerHelp => 'Número entero';

  @override
  String get productDecimalHelp => 'Puedes usar decimales, por ejemplo 1,5';

  @override
  String get shareAction => 'Compartir';

  @override
  String get shareTitle => 'Compartir compra';

  @override
  String get shareCopied => 'Compra copiada al portapapeles.';

  @override
  String get shareError => 'No pudimos compartir la compra.';

  @override
  String get statisticsTitle => 'Estadísticas';

  @override
  String get statsPeriod3 => '3 meses';

  @override
  String get statsPeriod6 => '6 meses';

  @override
  String get statsPeriod12 => '12 meses';

  @override
  String get statsCount => 'Compras';

  @override
  String get statsProducts => 'Productos';

  @override
  String get statsMonths => 'Gastos por mes';

  @override
  String get statsTopCategories => 'Categorías';

  @override
  String get statsEmptyDesc =>
      'Cuando registres compras, verás tus estadísticas aquí.';

  @override
  String statsPeriodTotal(String period) {
    return 'Total de $period';
  }

  @override
  String statsPurchaseCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count compras',
      one: '1 compra',
    );
    return '$_temp0';
  }

  @override
  String get unitUn => 'Unidad';

  @override
  String get unitKg => 'Kilogramos';

  @override
  String get unitL => 'Litros';

  @override
  String get unitNameUnOne => 'Unidad';

  @override
  String get unitNameUnOther => 'Unidades';

  @override
  String get unitNameKgOne => 'Kilogramo';

  @override
  String get unitNameKgOther => 'Kilogramos';

  @override
  String get unitNameLOne => 'Litro';

  @override
  String get unitNameLOther => 'Litros';

  @override
  String get creatorNotSet => 'No definido';
}

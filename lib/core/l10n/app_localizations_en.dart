// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loadError => 'We could not open your data.';

  @override
  String get tabsHome => 'Home';

  @override
  String get tabsHistory => 'History';

  @override
  String get tabsStats => 'Statistics';

  @override
  String get tabsSettings => 'Settings';

  @override
  String get homeEmptyTitle => 'No purchases yet';

  @override
  String get homeEmptyDescription =>
      'Create your first purchase to start recording your expenses.';

  @override
  String get historyEmptyTitle => 'No purchases recorded';

  @override
  String get historyEmptyDescription =>
      'Your purchase history will appear here.';

  @override
  String get statsEmptyTitle => 'No data yet';

  @override
  String get statsEmptyDescription =>
      'When you record purchases, your statistics will appear here.';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsSpanish => 'Español';

  @override
  String get settingsEnglish => 'English';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsAppearanceDesc => 'Theme and accent color.';

  @override
  String get settingsData => 'Data';

  @override
  String get settingsExport => 'Export';

  @override
  String get settingsExportDesc =>
      'Download or share an .xlsx file with your purchases.';

  @override
  String get settingsExportSuccess => 'Excel generated';

  @override
  String get settingsExportSuccessBody =>
      'The file is ready to download or share.';

  @override
  String get settingsExportError => 'We could not export the data.';

  @override
  String get settingsDeleteAll => 'Delete all data';

  @override
  String get settingsDeleteAllDesc =>
      'Deletes purchases, products and settings from this device.';

  @override
  String get settingsDeleteTitle => 'Delete all data';

  @override
  String get settingsDeleteBody =>
      'All your purchases will be deleted and cannot be recovered. Excel files already exported are not deleted.';

  @override
  String get settingsDeleteConfirm => 'Delete all';

  @override
  String get settingsDeleteSuccess => 'Data deleted.';

  @override
  String get settingsDeleteError => 'We could not delete the data.';

  @override
  String get tutorialTitle => 'Welcome to Mis Compras';

  @override
  String get tutorialDescription =>
      'Record your purchases, products and expenses in Chilean pesos. Everything stays on your device.';

  @override
  String get tutorialPurchases => 'Create purchases and add products.';

  @override
  String get tutorialHistory => 'Search and filter your history.';

  @override
  String get tutorialStats => 'Review your spending by month and category.';

  @override
  String get tutorialPrivacy =>
      'No accounts, cloud or analytics. You can export or delete your data from Settings.';

  @override
  String get tutorialStart => 'Start';

  @override
  String get settingsLegalSection => 'Legal';

  @override
  String get settingsLegal => 'Privacy and terms';

  @override
  String get settingsLegalDesc => 'How your data is stored and terms of use.';

  @override
  String get legalTitle => 'Privacy and terms';

  @override
  String get legalDraft =>
      'Informational text. The final legal version will be reviewed before publishing.';

  @override
  String get legalPrivacyTitle => 'Privacy';

  @override
  String get legalPrivacyBody =>
      'Mis Compras stores the data you enter on your device. It does not create accounts, send data to servers, or use analytics. You can delete a purchase or all your data from Settings.';

  @override
  String get legalTermsTitle => 'Terms';

  @override
  String get legalTermsBody =>
      'Mis Compras is a personal record tool. It does not verify prices or replace financial, accounting or legal advice. You are responsible for the data you enter and for the files you export.';

  @override
  String legalFooter(String appName) {
    return 'Mis Compras · 100% local';
  }

  @override
  String get exportSummary => 'Summary';

  @override
  String get exportPurchases => 'Purchases';

  @override
  String get exportProducts => 'Products';

  @override
  String get exportTitle => 'Title';

  @override
  String get exportDate => 'Date';

  @override
  String get exportPlace => 'Place';

  @override
  String get exportCategory => 'Category';

  @override
  String get exportProductsCount => 'Products';

  @override
  String get exportTotal => 'Total (CLP)';

  @override
  String get exportNotes => 'Notes';

  @override
  String get exportProduct => 'Product';

  @override
  String get exportQuantity => 'Quantity';

  @override
  String get exportUnit => 'Unit';

  @override
  String get exportUnitPrice => 'Unit price (CLP)';

  @override
  String get exportSubtotal => 'Subtotal (CLP)';

  @override
  String get exportPurchasesRegistered => 'Purchases registered';

  @override
  String get exportProductsRegistered => 'Products registered';

  @override
  String get exportTotalSpent => 'Total spent (CLP)';

  @override
  String get exportAverage => 'Average per purchase (CLP)';

  @override
  String get exportExportedAt => 'Export date';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsLight => 'Light';

  @override
  String get settingsDark => 'Dark';

  @override
  String get settingsColor => 'Color';

  @override
  String get settingsAutoSave => 'Changes are saved automatically.';

  @override
  String get settingsAboutSection => 'About';

  @override
  String get settingsCreator => 'Creator';

  @override
  String get settingsCreatorDesc => 'Who made the app.';

  @override
  String get settingsAppInfo => 'The app';

  @override
  String get settingsAppInfoDesc => 'Version, privacy and license.';

  @override
  String get settingsPrivacy =>
      'Your data lives on your device. No accounts, cloud or analytics.';

  @override
  String get settingsVersion => 'Version';

  @override
  String get aboutWhatIs =>
      'Mis Compras is a personal purchase and expense log in Chilean pesos. It stores what you bought, how much you paid and when.';

  @override
  String get aboutLocal =>
      'The data stays on your device. You can delete a purchase or all your data from Settings. Exported Excel files stay outside the app.';

  @override
  String get aboutLicense => 'License';

  @override
  String get aboutLicenseBody => 'MIT.';

  @override
  String get aboutMadeIn => 'Made in Chile.';

  @override
  String get creatorWebsite => 'Website';

  @override
  String get creatorGithub => 'GitHub';

  @override
  String get creatorContact => 'Contact';

  @override
  String get creatorSupport => 'Support';

  @override
  String get accentsLavanda => 'Lavender';

  @override
  String get accentsMenta => 'Mint';

  @override
  String get accentsDurazno => 'Peach';

  @override
  String get accentsRosa => 'Rose';

  @override
  String get accentsCielo => 'Sky';

  @override
  String get commonBack => 'Back';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonClose => 'Close';

  @override
  String get commonRequired => 'Required';

  @override
  String get commonRetry => 'Retry';

  @override
  String get errorsLoad => 'We could not open the data. Try again.';

  @override
  String get errorsSave => 'We could not save the changes.';

  @override
  String get errorsDelete => 'We could not delete.';

  @override
  String get tutorialTheme => 'Light, dark theme and colors.';

  @override
  String get tutorialLocal => 'Your data stays on the device.';

  @override
  String get tutorialData =>
      'Export to Excel or delete everything whenever you want.';

  @override
  String get homeWelcomeTitle => 'Your base is ready';

  @override
  String get homeWelcomeDescription =>
      'Change the name, theme and sample feature to get started.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsAccent => 'Color';

  @override
  String get settingsDev => 'Development';

  @override
  String get settingsMode => 'Data mode';

  @override
  String get settingsModeDevelopment => 'Development';

  @override
  String get settingsModeDemo => 'Demo';

  @override
  String get settingsModeProduction => 'Production';

  @override
  String get settingsSeed => 'Load sample data';

  @override
  String get settingsSeedDesc => 'Adds sample purchases to review the app.';

  @override
  String get settingsSeedBody =>
      '10 sample purchases will be added to your current data. Nothing is deleted.';

  @override
  String get settingsSeedConfirm => 'Load';

  @override
  String settingsSeedSuccess(int count) {
    return '$count sample purchases loaded.';
  }

  @override
  String get settingsSeedError => 'We could not load the sample data.';

  @override
  String get accentLavanda => 'Lavender';

  @override
  String get accentMenta => 'Mint';

  @override
  String get accentDurazno => 'Peach';

  @override
  String get accentRosa => 'Rose';

  @override
  String get accentCielo => 'Sky';

  @override
  String get categorySupermercado => 'Supermarket';

  @override
  String get categoryOnline => 'Online';

  @override
  String get categoryHogar => 'Home';

  @override
  String get categoryTecnologia => 'Technology';

  @override
  String get categoryRopa => 'Clothing';

  @override
  String get categoryOtros => 'Other';

  @override
  String get commonAccept => 'Accept';

  @override
  String get historyAll => 'All';

  @override
  String get historySearch => 'Search';

  @override
  String get historySearchHint => 'Product, title or place';

  @override
  String get homeMonthTotal => 'This month';

  @override
  String get homePurchases => 'Purchases';

  @override
  String get homeAverage => 'Average';

  @override
  String get newPurchase => 'Create purchase';

  @override
  String get homeRecent => 'Recent purchases';

  @override
  String get purchasesTitle => 'Purchases';

  @override
  String get purchasesEmptyTitle => 'No purchases yet';

  @override
  String get purchasesEmptyDescription =>
      'Create your first purchase to start tracking your spending.';

  @override
  String get purchaseNewTitle => 'New purchase';

  @override
  String get purchaseEditTitle => 'Edit purchase';

  @override
  String get purchaseDetailTitle => 'Purchase';

  @override
  String get purchaseTitleLabel => 'Title';

  @override
  String get purchaseTitlePlaceholder => 'e.g. Online purchase';

  @override
  String get purchaseDate => 'Date';

  @override
  String get purchaseDateHelp => 'Format YYYY-MM-DD';

  @override
  String get purchaseMerchant => 'Place or store';

  @override
  String get purchaseMerchantPlaceholder => 'Optional';

  @override
  String get purchaseCategory => 'Category';

  @override
  String get purchaseNotes => 'Notes';

  @override
  String get purchaseNotesPlaceholder => 'Optional';

  @override
  String get purchaseProducts => 'Products';

  @override
  String purchaseProductCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count products',
      one: '1 product',
    );
    return '$_temp0';
  }

  @override
  String get purchaseAddProduct => 'Add';

  @override
  String get purchaseNoProducts => 'No products yet.';

  @override
  String get purchaseCreatedAt => 'Created';

  @override
  String get purchaseEdit => 'Edit';

  @override
  String get purchaseTotal => 'Purchase total';

  @override
  String get purchaseSave => 'Save';

  @override
  String get purchaseSaved => 'Purchase saved.';

  @override
  String get purchaseDeleteTitle => 'Delete purchase';

  @override
  String get purchaseDeleteAction => 'Delete';

  @override
  String get purchaseDeleteBody =>
      'The purchase and all its products will be deleted. This cannot be undone.';

  @override
  String get purchaseDeleteConfirm => 'Delete';

  @override
  String get purchaseDuplicate => 'Duplicate';

  @override
  String get purchaseDuplicateSuffix => ' (copy)';

  @override
  String get purchaseNotFound => 'We could not find that purchase.';

  @override
  String get purchaseInvalidTitle => 'Enter a title.';

  @override
  String get purchaseInvalidDate => 'Use the format YYYY-MM-DD.';

  @override
  String get productNewTitle => 'Add product';

  @override
  String get productEditTitle => 'Edit product';

  @override
  String get productFormTitle => 'Product details';

  @override
  String get productName => 'Product';

  @override
  String get productNamePlaceholder => 'e.g. Headphones';

  @override
  String get productQuantity => 'Quantity';

  @override
  String get productUnit => 'Unit of measure';

  @override
  String get productPrice => 'Unit price';

  @override
  String get productSubtotal => 'Subtotal';

  @override
  String get productSave => 'Save';

  @override
  String get productSaveAndAdd => 'Save & new';

  @override
  String get productDeleteTitle => 'Delete product';

  @override
  String get productDeleteAction => 'Delete';

  @override
  String get productDeleteBody =>
      'This product will be removed from the purchase.';

  @override
  String get productDeleteConfirm => 'Delete';

  @override
  String get productInvalidName => 'Enter a name.';

  @override
  String get productInvalidQuantity => 'Quantity must be greater than 0.';

  @override
  String get productInvalidInteger => 'For units, use a whole number.';

  @override
  String get productInvalidPrice => 'Price cannot be negative.';

  @override
  String get productIntegerHelp => 'Whole number';

  @override
  String get productDecimalHelp => 'You can use decimals, for example 1.5';

  @override
  String get shareAction => 'Share';

  @override
  String get shareTitle => 'Share purchase';

  @override
  String get shareCopied => 'Purchase copied to clipboard.';

  @override
  String get shareError => 'We could not share the purchase.';

  @override
  String get statisticsTitle => 'Stats';

  @override
  String get statsPeriod3 => '3 months';

  @override
  String get statsPeriod6 => '6 months';

  @override
  String get statsPeriod12 => '12 months';

  @override
  String get statsCount => 'Purchases';

  @override
  String get statsProducts => 'Products';

  @override
  String get statsMonths => 'Spending by month';

  @override
  String get statsTopCategories => 'Categories';

  @override
  String get statsEmptyDesc =>
      'When you record purchases, your stats will appear here.';

  @override
  String statsPeriodTotal(String period) {
    return 'Total for $period';
  }

  @override
  String statsPurchaseCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count purchases',
      one: '1 purchase',
    );
    return '$_temp0';
  }

  @override
  String get unitUn => 'Unit';

  @override
  String get unitKg => 'Kilograms';

  @override
  String get unitL => 'Liters';

  @override
  String get unitNameUnOne => 'Unit';

  @override
  String get unitNameUnOther => 'Units';

  @override
  String get unitNameKgOne => 'Kilogram';

  @override
  String get unitNameKgOther => 'Kilograms';

  @override
  String get unitNameLOne => 'Liter';

  @override
  String get unitNameLOther => 'Liters';

  @override
  String get creatorNotSet => 'Not defined';
}

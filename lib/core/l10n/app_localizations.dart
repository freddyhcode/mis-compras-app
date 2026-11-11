import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @loadError.
  ///
  /// In en, this message translates to:
  /// **'We could not open your data.'**
  String get loadError;

  /// No description provided for @tabsHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get tabsHome;

  /// No description provided for @tabsHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get tabsHistory;

  /// No description provided for @tabsStats.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get tabsStats;

  /// No description provided for @tabsSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tabsSettings;

  /// No description provided for @homeEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No purchases yet'**
  String get homeEmptyTitle;

  /// No description provided for @homeEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Create your first purchase to start recording your expenses.'**
  String get homeEmptyDescription;

  /// No description provided for @historyEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No purchases recorded'**
  String get historyEmptyTitle;

  /// No description provided for @historyEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Your purchase history will appear here.'**
  String get historyEmptyDescription;

  /// No description provided for @statsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No data yet'**
  String get statsEmptyTitle;

  /// No description provided for @statsEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'When you record purchases, your statistics will appear here.'**
  String get statsEmptyDescription;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsSpanish.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get settingsSpanish;

  /// No description provided for @settingsEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsEnglish;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsAppearanceDesc.
  ///
  /// In en, this message translates to:
  /// **'Theme and accent color.'**
  String get settingsAppearanceDesc;

  /// No description provided for @settingsData.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get settingsData;

  /// No description provided for @settingsExport.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get settingsExport;

  /// No description provided for @settingsExportDesc.
  ///
  /// In en, this message translates to:
  /// **'Download or share an .xlsx file with your purchases.'**
  String get settingsExportDesc;

  /// No description provided for @settingsExportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Excel generated'**
  String get settingsExportSuccess;

  /// No description provided for @settingsExportSuccessBody.
  ///
  /// In en, this message translates to:
  /// **'The file is ready to download or share.'**
  String get settingsExportSuccessBody;

  /// No description provided for @settingsExportError.
  ///
  /// In en, this message translates to:
  /// **'We could not export the data.'**
  String get settingsExportError;

  /// No description provided for @settingsDeleteAll.
  ///
  /// In en, this message translates to:
  /// **'Delete all data'**
  String get settingsDeleteAll;

  /// No description provided for @settingsDeleteAllDesc.
  ///
  /// In en, this message translates to:
  /// **'Deletes purchases, products and settings from this device.'**
  String get settingsDeleteAllDesc;

  /// No description provided for @settingsDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete all data'**
  String get settingsDeleteTitle;

  /// No description provided for @settingsDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'All your purchases will be deleted and cannot be recovered. Excel files already exported are not deleted.'**
  String get settingsDeleteBody;

  /// No description provided for @settingsDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete all'**
  String get settingsDeleteConfirm;

  /// No description provided for @settingsDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data deleted.'**
  String get settingsDeleteSuccess;

  /// No description provided for @settingsDeleteError.
  ///
  /// In en, this message translates to:
  /// **'We could not delete the data.'**
  String get settingsDeleteError;

  /// No description provided for @tutorialTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Mis Compras'**
  String get tutorialTitle;

  /// No description provided for @tutorialDescription.
  ///
  /// In en, this message translates to:
  /// **'Record your purchases, products and expenses in Chilean pesos. Everything stays on your device.'**
  String get tutorialDescription;

  /// No description provided for @tutorialPurchases.
  ///
  /// In en, this message translates to:
  /// **'Create purchases and add products.'**
  String get tutorialPurchases;

  /// No description provided for @tutorialHistory.
  ///
  /// In en, this message translates to:
  /// **'Search and filter your history.'**
  String get tutorialHistory;

  /// No description provided for @tutorialStats.
  ///
  /// In en, this message translates to:
  /// **'Review your spending by month and category.'**
  String get tutorialStats;

  /// No description provided for @tutorialPrivacy.
  ///
  /// In en, this message translates to:
  /// **'No accounts, cloud or analytics. You can export or delete your data from Settings.'**
  String get tutorialPrivacy;

  /// No description provided for @tutorialStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get tutorialStart;

  /// No description provided for @settingsLegalSection.
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get settingsLegalSection;

  /// No description provided for @settingsLegal.
  ///
  /// In en, this message translates to:
  /// **'Privacy and terms'**
  String get settingsLegal;

  /// No description provided for @settingsLegalDesc.
  ///
  /// In en, this message translates to:
  /// **'How your data is stored and terms of use.'**
  String get settingsLegalDesc;

  /// No description provided for @legalTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy and terms'**
  String get legalTitle;

  /// No description provided for @legalDraft.
  ///
  /// In en, this message translates to:
  /// **'Informational text. The final legal version will be reviewed before publishing.'**
  String get legalDraft;

  /// No description provided for @legalPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get legalPrivacyTitle;

  /// No description provided for @legalPrivacyBody.
  ///
  /// In en, this message translates to:
  /// **'Mis Compras stores the data you enter on your device. It does not create accounts, send data to servers, or use analytics. You can delete a purchase or all your data from Settings.'**
  String get legalPrivacyBody;

  /// No description provided for @legalTermsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get legalTermsTitle;

  /// No description provided for @legalTermsBody.
  ///
  /// In en, this message translates to:
  /// **'Mis Compras is a personal record tool. It does not verify prices or replace financial, accounting or legal advice. You are responsible for the data you enter and for the files you export.'**
  String get legalTermsBody;

  /// No description provided for @legalFooter.
  ///
  /// In en, this message translates to:
  /// **'Mis Compras · 100% local'**
  String legalFooter(String appName);

  /// No description provided for @exportSummary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get exportSummary;

  /// No description provided for @exportPurchases.
  ///
  /// In en, this message translates to:
  /// **'Purchases'**
  String get exportPurchases;

  /// No description provided for @exportProducts.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get exportProducts;

  /// No description provided for @exportTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get exportTitle;

  /// No description provided for @exportDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get exportDate;

  /// No description provided for @exportPlace.
  ///
  /// In en, this message translates to:
  /// **'Place'**
  String get exportPlace;

  /// No description provided for @exportCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get exportCategory;

  /// No description provided for @exportProductsCount.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get exportProductsCount;

  /// No description provided for @exportTotal.
  ///
  /// In en, this message translates to:
  /// **'Total (CLP)'**
  String get exportTotal;

  /// No description provided for @exportNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get exportNotes;

  /// No description provided for @exportProduct.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get exportProduct;

  /// No description provided for @exportQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get exportQuantity;

  /// No description provided for @exportUnit.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get exportUnit;

  /// No description provided for @exportUnitPrice.
  ///
  /// In en, this message translates to:
  /// **'Unit price (CLP)'**
  String get exportUnitPrice;

  /// No description provided for @exportSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal (CLP)'**
  String get exportSubtotal;

  /// No description provided for @exportPurchasesRegistered.
  ///
  /// In en, this message translates to:
  /// **'Purchases registered'**
  String get exportPurchasesRegistered;

  /// No description provided for @exportProductsRegistered.
  ///
  /// In en, this message translates to:
  /// **'Products registered'**
  String get exportProductsRegistered;

  /// No description provided for @exportTotalSpent.
  ///
  /// In en, this message translates to:
  /// **'Total spent (CLP)'**
  String get exportTotalSpent;

  /// No description provided for @exportAverage.
  ///
  /// In en, this message translates to:
  /// **'Average per purchase (CLP)'**
  String get exportAverage;

  /// No description provided for @exportExportedAt.
  ///
  /// In en, this message translates to:
  /// **'Export date'**
  String get exportExportedAt;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsLight;

  /// No description provided for @settingsDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsDark;

  /// No description provided for @settingsColor.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get settingsColor;

  /// No description provided for @settingsAutoSave.
  ///
  /// In en, this message translates to:
  /// **'Changes are saved automatically.'**
  String get settingsAutoSave;

  /// No description provided for @settingsAboutSection.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAboutSection;

  /// No description provided for @settingsCreator.
  ///
  /// In en, this message translates to:
  /// **'Creator'**
  String get settingsCreator;

  /// No description provided for @settingsCreatorDesc.
  ///
  /// In en, this message translates to:
  /// **'Who made the app.'**
  String get settingsCreatorDesc;

  /// No description provided for @settingsAppInfo.
  ///
  /// In en, this message translates to:
  /// **'The app'**
  String get settingsAppInfo;

  /// No description provided for @settingsAppInfoDesc.
  ///
  /// In en, this message translates to:
  /// **'Version, privacy and license.'**
  String get settingsAppInfoDesc;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Your data lives on your device. No accounts, cloud or analytics.'**
  String get settingsPrivacy;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settingsVersion;

  /// No description provided for @aboutWhatIs.
  ///
  /// In en, this message translates to:
  /// **'Mis Compras is a personal purchase and expense log in Chilean pesos. It stores what you bought, how much you paid and when.'**
  String get aboutWhatIs;

  /// No description provided for @aboutLocal.
  ///
  /// In en, this message translates to:
  /// **'The data stays on your device. You can delete a purchase or all your data from Settings. Exported Excel files stay outside the app.'**
  String get aboutLocal;

  /// No description provided for @aboutLicense.
  ///
  /// In en, this message translates to:
  /// **'License'**
  String get aboutLicense;

  /// No description provided for @aboutLicenseBody.
  ///
  /// In en, this message translates to:
  /// **'MIT.'**
  String get aboutLicenseBody;

  /// No description provided for @aboutMadeIn.
  ///
  /// In en, this message translates to:
  /// **'Made in Chile.'**
  String get aboutMadeIn;

  /// No description provided for @creatorWebsite.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get creatorWebsite;

  /// No description provided for @creatorGithub.
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get creatorGithub;

  /// No description provided for @creatorContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get creatorContact;

  /// No description provided for @creatorSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get creatorSupport;

  /// No description provided for @accentsLavanda.
  ///
  /// In en, this message translates to:
  /// **'Lavender'**
  String get accentsLavanda;

  /// No description provided for @accentsMenta.
  ///
  /// In en, this message translates to:
  /// **'Mint'**
  String get accentsMenta;

  /// No description provided for @accentsDurazno.
  ///
  /// In en, this message translates to:
  /// **'Peach'**
  String get accentsDurazno;

  /// No description provided for @accentsRosa.
  ///
  /// In en, this message translates to:
  /// **'Rose'**
  String get accentsRosa;

  /// No description provided for @accentsCielo.
  ///
  /// In en, this message translates to:
  /// **'Sky'**
  String get accentsCielo;

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get commonRequired;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @errorsLoad.
  ///
  /// In en, this message translates to:
  /// **'We could not open the data. Try again.'**
  String get errorsLoad;

  /// No description provided for @errorsSave.
  ///
  /// In en, this message translates to:
  /// **'We could not save the changes.'**
  String get errorsSave;

  /// No description provided for @errorsDelete.
  ///
  /// In en, this message translates to:
  /// **'We could not delete.'**
  String get errorsDelete;

  /// No description provided for @tutorialTheme.
  ///
  /// In en, this message translates to:
  /// **'Light, dark theme and colors.'**
  String get tutorialTheme;

  /// No description provided for @tutorialLocal.
  ///
  /// In en, this message translates to:
  /// **'Your data stays on the device.'**
  String get tutorialLocal;

  /// No description provided for @tutorialData.
  ///
  /// In en, this message translates to:
  /// **'Export to Excel or delete everything whenever you want.'**
  String get tutorialData;

  /// No description provided for @homeWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Your base is ready'**
  String get homeWelcomeTitle;

  /// No description provided for @homeWelcomeDescription.
  ///
  /// In en, this message translates to:
  /// **'Change the name, theme and sample feature to get started.'**
  String get homeWelcomeDescription;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsAccent.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get settingsAccent;

  /// No description provided for @settingsDev.
  ///
  /// In en, this message translates to:
  /// **'Development'**
  String get settingsDev;

  /// No description provided for @settingsMode.
  ///
  /// In en, this message translates to:
  /// **'Data mode'**
  String get settingsMode;

  /// No description provided for @settingsModeDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Development'**
  String get settingsModeDevelopment;

  /// No description provided for @settingsModeDemo.
  ///
  /// In en, this message translates to:
  /// **'Demo'**
  String get settingsModeDemo;

  /// No description provided for @settingsModeProduction.
  ///
  /// In en, this message translates to:
  /// **'Production'**
  String get settingsModeProduction;

  /// No description provided for @settingsSeed.
  ///
  /// In en, this message translates to:
  /// **'Load sample data'**
  String get settingsSeed;

  /// No description provided for @settingsSeedDesc.
  ///
  /// In en, this message translates to:
  /// **'Adds sample purchases to review the app.'**
  String get settingsSeedDesc;

  /// No description provided for @settingsSeedBody.
  ///
  /// In en, this message translates to:
  /// **'10 sample purchases will be added to your current data. Nothing is deleted.'**
  String get settingsSeedBody;

  /// No description provided for @settingsSeedConfirm.
  ///
  /// In en, this message translates to:
  /// **'Load'**
  String get settingsSeedConfirm;

  /// No description provided for @settingsSeedSuccess.
  ///
  /// In en, this message translates to:
  /// **'{count} sample purchases loaded.'**
  String settingsSeedSuccess(int count);

  /// No description provided for @settingsSeedError.
  ///
  /// In en, this message translates to:
  /// **'We could not load the sample data.'**
  String get settingsSeedError;

  /// No description provided for @accentLavanda.
  ///
  /// In en, this message translates to:
  /// **'Lavender'**
  String get accentLavanda;

  /// No description provided for @accentMenta.
  ///
  /// In en, this message translates to:
  /// **'Mint'**
  String get accentMenta;

  /// No description provided for @accentDurazno.
  ///
  /// In en, this message translates to:
  /// **'Peach'**
  String get accentDurazno;

  /// No description provided for @accentRosa.
  ///
  /// In en, this message translates to:
  /// **'Rose'**
  String get accentRosa;

  /// No description provided for @accentCielo.
  ///
  /// In en, this message translates to:
  /// **'Sky'**
  String get accentCielo;

  /// No description provided for @categorySupermercado.
  ///
  /// In en, this message translates to:
  /// **'Supermarket'**
  String get categorySupermercado;

  /// No description provided for @categoryOnline.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get categoryOnline;

  /// No description provided for @categoryHogar.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get categoryHogar;

  /// No description provided for @categoryTecnologia.
  ///
  /// In en, this message translates to:
  /// **'Technology'**
  String get categoryTecnologia;

  /// No description provided for @categoryRopa.
  ///
  /// In en, this message translates to:
  /// **'Clothing'**
  String get categoryRopa;

  /// No description provided for @categoryOtros.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get categoryOtros;

  /// No description provided for @commonAccept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get commonAccept;

  /// No description provided for @historyAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get historyAll;

  /// No description provided for @historySearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get historySearch;

  /// No description provided for @historySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Product, title or place'**
  String get historySearchHint;

  /// No description provided for @homeMonthTotal.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get homeMonthTotal;

  /// No description provided for @homePurchases.
  ///
  /// In en, this message translates to:
  /// **'Purchases'**
  String get homePurchases;

  /// No description provided for @homeAverage.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get homeAverage;

  /// No description provided for @newPurchase.
  ///
  /// In en, this message translates to:
  /// **'Create purchase'**
  String get newPurchase;

  /// No description provided for @homeRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent purchases'**
  String get homeRecent;

  /// No description provided for @purchasesTitle.
  ///
  /// In en, this message translates to:
  /// **'Purchases'**
  String get purchasesTitle;

  /// No description provided for @purchasesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No purchases yet'**
  String get purchasesEmptyTitle;

  /// No description provided for @purchasesEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Create your first purchase to start tracking your spending.'**
  String get purchasesEmptyDescription;

  /// No description provided for @purchaseNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New purchase'**
  String get purchaseNewTitle;

  /// No description provided for @purchaseEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit purchase'**
  String get purchaseEditTitle;

  /// No description provided for @purchaseDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get purchaseDetailTitle;

  /// No description provided for @purchaseTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get purchaseTitleLabel;

  /// No description provided for @purchaseTitlePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. Online purchase'**
  String get purchaseTitlePlaceholder;

  /// No description provided for @purchaseDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get purchaseDate;

  /// No description provided for @purchaseDateHelp.
  ///
  /// In en, this message translates to:
  /// **'Format YYYY-MM-DD'**
  String get purchaseDateHelp;

  /// No description provided for @purchaseMerchant.
  ///
  /// In en, this message translates to:
  /// **'Place or store'**
  String get purchaseMerchant;

  /// No description provided for @purchaseMerchantPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get purchaseMerchantPlaceholder;

  /// No description provided for @purchaseCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get purchaseCategory;

  /// No description provided for @purchaseNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get purchaseNotes;

  /// No description provided for @purchaseNotesPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get purchaseNotesPlaceholder;

  /// No description provided for @purchaseProducts.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get purchaseProducts;

  /// No description provided for @purchaseProductCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 product} other{{count} products}}'**
  String purchaseProductCount(int count);

  /// No description provided for @purchaseAddProduct.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get purchaseAddProduct;

  /// No description provided for @purchaseNoProducts.
  ///
  /// In en, this message translates to:
  /// **'No products yet.'**
  String get purchaseNoProducts;

  /// No description provided for @purchaseCreatedAt.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get purchaseCreatedAt;

  /// No description provided for @purchaseEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get purchaseEdit;

  /// No description provided for @purchaseTotal.
  ///
  /// In en, this message translates to:
  /// **'Purchase total'**
  String get purchaseTotal;

  /// No description provided for @purchaseSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get purchaseSave;

  /// No description provided for @purchaseSaved.
  ///
  /// In en, this message translates to:
  /// **'Purchase saved.'**
  String get purchaseSaved;

  /// No description provided for @purchaseDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete purchase'**
  String get purchaseDeleteTitle;

  /// No description provided for @purchaseDeleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get purchaseDeleteAction;

  /// No description provided for @purchaseDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'The purchase and all its products will be deleted. This cannot be undone.'**
  String get purchaseDeleteBody;

  /// No description provided for @purchaseDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get purchaseDeleteConfirm;

  /// No description provided for @purchaseDuplicate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get purchaseDuplicate;

  /// No description provided for @purchaseDuplicateSuffix.
  ///
  /// In en, this message translates to:
  /// **' (copy)'**
  String get purchaseDuplicateSuffix;

  /// No description provided for @purchaseNotFound.
  ///
  /// In en, this message translates to:
  /// **'We could not find that purchase.'**
  String get purchaseNotFound;

  /// No description provided for @purchaseInvalidTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter a title.'**
  String get purchaseInvalidTitle;

  /// No description provided for @purchaseInvalidDate.
  ///
  /// In en, this message translates to:
  /// **'Use the format YYYY-MM-DD.'**
  String get purchaseInvalidDate;

  /// No description provided for @productNewTitle.
  ///
  /// In en, this message translates to:
  /// **'Add product'**
  String get productNewTitle;

  /// No description provided for @productEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit product'**
  String get productEditTitle;

  /// No description provided for @productFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Product details'**
  String get productFormTitle;

  /// No description provided for @productName.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get productName;

  /// No description provided for @productNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. Headphones'**
  String get productNamePlaceholder;

  /// No description provided for @productQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get productQuantity;

  /// No description provided for @productUnit.
  ///
  /// In en, this message translates to:
  /// **'Unit of measure'**
  String get productUnit;

  /// No description provided for @productPrice.
  ///
  /// In en, this message translates to:
  /// **'Unit price'**
  String get productPrice;

  /// No description provided for @productSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get productSubtotal;

  /// No description provided for @productSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get productSave;

  /// No description provided for @productSaveAndAdd.
  ///
  /// In en, this message translates to:
  /// **'Save & new'**
  String get productSaveAndAdd;

  /// No description provided for @productDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete product'**
  String get productDeleteTitle;

  /// No description provided for @productDeleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get productDeleteAction;

  /// No description provided for @productDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'This product will be removed from the purchase.'**
  String get productDeleteBody;

  /// No description provided for @productDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get productDeleteConfirm;

  /// No description provided for @productInvalidName.
  ///
  /// In en, this message translates to:
  /// **'Enter a name.'**
  String get productInvalidName;

  /// No description provided for @productInvalidQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity must be greater than 0.'**
  String get productInvalidQuantity;

  /// No description provided for @productInvalidInteger.
  ///
  /// In en, this message translates to:
  /// **'For units, use a whole number.'**
  String get productInvalidInteger;

  /// No description provided for @productInvalidPrice.
  ///
  /// In en, this message translates to:
  /// **'Price cannot be negative.'**
  String get productInvalidPrice;

  /// No description provided for @productIntegerHelp.
  ///
  /// In en, this message translates to:
  /// **'Whole number'**
  String get productIntegerHelp;

  /// No description provided for @productDecimalHelp.
  ///
  /// In en, this message translates to:
  /// **'You can use decimals, for example 1.5'**
  String get productDecimalHelp;

  /// No description provided for @shareAction.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareAction;

  /// No description provided for @shareTitle.
  ///
  /// In en, this message translates to:
  /// **'Share purchase'**
  String get shareTitle;

  /// No description provided for @shareCopied.
  ///
  /// In en, this message translates to:
  /// **'Purchase copied to clipboard.'**
  String get shareCopied;

  /// No description provided for @shareError.
  ///
  /// In en, this message translates to:
  /// **'We could not share the purchase.'**
  String get shareError;

  /// No description provided for @statisticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get statisticsTitle;

  /// No description provided for @statsPeriod3.
  ///
  /// In en, this message translates to:
  /// **'3 months'**
  String get statsPeriod3;

  /// No description provided for @statsPeriod6.
  ///
  /// In en, this message translates to:
  /// **'6 months'**
  String get statsPeriod6;

  /// No description provided for @statsPeriod12.
  ///
  /// In en, this message translates to:
  /// **'12 months'**
  String get statsPeriod12;

  /// No description provided for @statsCount.
  ///
  /// In en, this message translates to:
  /// **'Purchases'**
  String get statsCount;

  /// No description provided for @statsProducts.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get statsProducts;

  /// No description provided for @statsMonths.
  ///
  /// In en, this message translates to:
  /// **'Spending by month'**
  String get statsMonths;

  /// No description provided for @statsTopCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get statsTopCategories;

  /// No description provided for @statsEmptyDesc.
  ///
  /// In en, this message translates to:
  /// **'When you record purchases, your stats will appear here.'**
  String get statsEmptyDesc;

  /// No description provided for @statsPeriodTotal.
  ///
  /// In en, this message translates to:
  /// **'Total for {period}'**
  String statsPeriodTotal(String period);

  /// No description provided for @statsPurchaseCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 purchase} other{{count} purchases}}'**
  String statsPurchaseCount(int count);

  /// No description provided for @unitUn.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unitUn;

  /// No description provided for @unitKg.
  ///
  /// In en, this message translates to:
  /// **'Kilograms'**
  String get unitKg;

  /// No description provided for @unitL.
  ///
  /// In en, this message translates to:
  /// **'Liters'**
  String get unitL;

  /// No description provided for @unitNameUnOne.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unitNameUnOne;

  /// No description provided for @unitNameUnOther.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get unitNameUnOther;

  /// No description provided for @unitNameKgOne.
  ///
  /// In en, this message translates to:
  /// **'Kilogram'**
  String get unitNameKgOne;

  /// No description provided for @unitNameKgOther.
  ///
  /// In en, this message translates to:
  /// **'Kilograms'**
  String get unitNameKgOther;

  /// No description provided for @unitNameLOne.
  ///
  /// In en, this message translates to:
  /// **'Liter'**
  String get unitNameLOne;

  /// No description provided for @unitNameLOther.
  ///
  /// In en, this message translates to:
  /// **'Liters'**
  String get unitNameLOther;

  /// No description provided for @creatorNotSet.
  ///
  /// In en, this message translates to:
  /// **'Not defined'**
  String get creatorNotSet;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

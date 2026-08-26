import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

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
    Locale('fr'),
  ];

  /// No description provided for @appName.
  ///
  /// In fr, this message translates to:
  /// **'DeegiShop'**
  String get appName;

  /// No description provided for @hello.
  ///
  /// In fr, this message translates to:
  /// **'Bonjour 👋'**
  String get hello;

  /// No description provided for @welcome.
  ///
  /// In fr, this message translates to:
  /// **'Bienvenue sur DeegiShop'**
  String get welcome;

  /// No description provided for @home.
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get home;

  /// No description provided for @favorites.
  ///
  /// In fr, this message translates to:
  /// **'Favoris'**
  String get favorites;

  /// No description provided for @cart.
  ///
  /// In fr, this message translates to:
  /// **'Panier'**
  String get cart;

  /// No description provided for @profile.
  ///
  /// In fr, this message translates to:
  /// **'Profil'**
  String get profile;

  /// No description provided for @newCollection.
  ///
  /// In fr, this message translates to:
  /// **'✨ Nouvelle collection'**
  String get newCollection;

  /// No description provided for @yourStyle.
  ///
  /// In fr, this message translates to:
  /// **'Votre style.\nVotre univers.'**
  String get yourStyle;

  /// No description provided for @description.
  ///
  /// In fr, this message translates to:
  /// **'Mode, wax & électronique sélectionnés pour vous.'**
  String get description;

  /// No description provided for @buyNow.
  ///
  /// In fr, this message translates to:
  /// **'Acheter maintenant'**
  String get buyNow;

  /// No description provided for @categories.
  ///
  /// In fr, this message translates to:
  /// **'Catégories'**
  String get categories;

  /// No description provided for @findYourStyle.
  ///
  /// In fr, this message translates to:
  /// **'Trouvez votre style'**
  String get findYourStyle;

  /// No description provided for @bags.
  ///
  /// In fr, this message translates to:
  /// **'Sacs'**
  String get bags;

  /// No description provided for @waxElegance.
  ///
  /// In fr, this message translates to:
  /// **'Wax & élégance'**
  String get waxElegance;

  /// No description provided for @shoes.
  ///
  /// In fr, this message translates to:
  /// **'Chaussures'**
  String get shoes;

  /// No description provided for @styleComfort.
  ///
  /// In fr, this message translates to:
  /// **'Style & confort'**
  String get styleComfort;

  /// No description provided for @electronics.
  ///
  /// In fr, this message translates to:
  /// **'Électronique'**
  String get electronics;

  /// No description provided for @everydayTech.
  ///
  /// In fr, this message translates to:
  /// **'Tech du quotidien'**
  String get everydayTech;

  /// No description provided for @popularProducts.
  ///
  /// In fr, this message translates to:
  /// **'Produits populaires 🔥'**
  String get popularProducts;

  /// No description provided for @favoritesProducts.
  ///
  /// In fr, this message translates to:
  /// **'Nos coups de cœur'**
  String get favoritesProducts;

  /// No description provided for @seeAll.
  ///
  /// In fr, this message translates to:
  /// **'Voir tout'**
  String get seeAll;

  /// No description provided for @simpleShopping.
  ///
  /// In fr, this message translates to:
  /// **'Shopping simple & rapide'**
  String get simpleShopping;

  /// No description provided for @shoppingDescription.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez vos produits, ajoutez-les au panier et profitez d’une expérience simple.'**
  String get shoppingDescription;
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
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

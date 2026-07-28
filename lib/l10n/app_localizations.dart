import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

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
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'SUKNA'**
  String get appTitle;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'SUKNA'**
  String get homeTitle;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find your ideal home'**
  String get homeSubtitle;

  /// No description provided for @savedProperties.
  ///
  /// In en, this message translates to:
  /// **'Saved Properties'**
  String get savedProperties;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @browseListings.
  ///
  /// In en, this message translates to:
  /// **'Browse Listings'**
  String get browseListings;

  /// No description provided for @noSavedProperties.
  ///
  /// In en, this message translates to:
  /// **'No saved properties yet'**
  String get noSavedProperties;

  /// No description provided for @noSavedPropertiesDesc.
  ///
  /// In en, this message translates to:
  /// **'Tap the bookmark icon on any listing to save it here for quick access.'**
  String get noSavedPropertiesDesc;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navMap.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get navMap;

  /// No description provided for @navSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get navSaved;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @propertiesSaved.
  ///
  /// In en, this message translates to:
  /// **'{count} properties saved'**
  String propertiesSaved(int count);

  /// No description provided for @filterCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get filterCategories;

  /// No description provided for @filterAllAreas.
  ///
  /// In en, this message translates to:
  /// **'All Areas'**
  String get filterAllAreas;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterBoys.
  ///
  /// In en, this message translates to:
  /// **'Boys'**
  String get filterBoys;

  /// No description provided for @filterGirls.
  ///
  /// In en, this message translates to:
  /// **'Girls'**
  String get filterGirls;

  /// No description provided for @filterMixed.
  ///
  /// In en, this message translates to:
  /// **'Mixed'**
  String get filterMixed;

  /// No description provided for @filterPriceRange.
  ///
  /// In en, this message translates to:
  /// **'Price range'**
  String get filterPriceRange;

  /// No description provided for @filterPriceHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a max of {max} EGP to show lower prices'**
  String filterPriceHint(int max);

  /// No description provided for @filterAmenities.
  ///
  /// In en, this message translates to:
  /// **'Amenities'**
  String get filterAmenities;

  /// No description provided for @filterApply.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get filterApply;

  /// No description provided for @filtersButton.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filtersButton;

  /// No description provided for @sortPriceTitle.
  ///
  /// In en, this message translates to:
  /// **'Sort by price'**
  String get sortPriceTitle;

  /// No description provided for @sortPriceLowToHigh.
  ///
  /// In en, this message translates to:
  /// **'Low to high'**
  String get sortPriceLowToHigh;

  /// No description provided for @sortPriceHighToLow.
  ///
  /// In en, this message translates to:
  /// **'High to low'**
  String get sortPriceHighToLow;

  /// No description provided for @emptyFilterTitle.
  ///
  /// In en, this message translates to:
  /// **'No housing matches your filters.'**
  String get emptyFilterTitle;

  /// No description provided for @emptyFilterDesc.
  ///
  /// In en, this message translates to:
  /// **'Clear all filters'**
  String get emptyFilterDesc;

  /// No description provided for @offlineModeTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline'**
  String get offlineModeTitle;

  /// No description provided for @offlineModeDesc.
  ///
  /// In en, this message translates to:
  /// **'Showing cached data when available.'**
  String get offlineModeDesc;

  /// No description provided for @offlineModeEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No cached housing yet.'**
  String get offlineModeEmptyTitle;

  /// No description provided for @offlineModeEmptyDesc.
  ///
  /// In en, this message translates to:
  /// **'Connect once to load data, then it will stay available offline.'**
  String get offlineModeEmptyDesc;

  /// No description provided for @detailLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get detailLocation;

  /// No description provided for @detailHousingRules.
  ///
  /// In en, this message translates to:
  /// **'Housing Rules'**
  String get detailHousingRules;

  /// No description provided for @detailAmenities.
  ///
  /// In en, this message translates to:
  /// **'Amenities'**
  String get detailAmenities;

  /// No description provided for @detailPricing.
  ///
  /// In en, this message translates to:
  /// **'Pricing'**
  String get detailPricing;

  /// No description provided for @detailCode.
  ///
  /// In en, this message translates to:
  /// **'Building Code'**
  String get detailCode;

  /// No description provided for @contactNow.
  ///
  /// In en, this message translates to:
  /// **'Contact Now'**
  String get contactNow;

  /// No description provided for @beds.
  ///
  /// In en, this message translates to:
  /// **'beds'**
  String get beds;

  /// No description provided for @mo.
  ///
  /// In en, this message translates to:
  /// **'mo'**
  String get mo;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'month'**
  String get month;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @loadingProperties.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingProperties;

  /// No description provided for @propertiesFound.
  ///
  /// In en, this message translates to:
  /// **'{count} properties found'**
  String propertiesFound(int count);

  /// No description provided for @failedToLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load properties'**
  String get failedToLoad;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @customizeExperience.
  ///
  /// In en, this message translates to:
  /// **'Customize your experience'**
  String get customizeExperience;

  /// No description provided for @currentlyDark.
  ///
  /// In en, this message translates to:
  /// **'Currently dark'**
  String get currentlyDark;

  /// No description provided for @currentlyLight.
  ///
  /// In en, this message translates to:
  /// **'Currently light'**
  String get currentlyLight;

  /// No description provided for @perMonth.
  ///
  /// In en, this message translates to:
  /// **'per month'**
  String get perMonth;

  /// No description provided for @bedsAvailable.
  ///
  /// In en, this message translates to:
  /// **'{available} of {total} beds available'**
  String bedsAvailable(int available, int total);

  /// No description provided for @onlyLabel.
  ///
  /// In en, this message translates to:
  /// **'{gender} Only'**
  String onlyLabel(String gender);

  /// No description provided for @propertyDetails.
  ///
  /// In en, this message translates to:
  /// **'Property Details'**
  String get propertyDetails;

  /// No description provided for @totalRooms.
  ///
  /// In en, this message translates to:
  /// **'Total Rooms'**
  String get totalRooms;

  /// No description provided for @totalBeds.
  ///
  /// In en, this message translates to:
  /// **'Total Beds'**
  String get totalBeds;

  /// No description provided for @servicesIncluded.
  ///
  /// In en, this message translates to:
  /// **'Services Included'**
  String get servicesIncluded;

  /// No description provided for @apartmentCode.
  ///
  /// In en, this message translates to:
  /// **'Apartment Code'**
  String get apartmentCode;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingStart.
  ///
  /// In en, this message translates to:
  /// **'Get Started 🚀'**
  String get onboardingStart;

  /// No description provided for @onb1Title.
  ///
  /// In en, this message translates to:
  /// **'Welcome to SUKNA'**
  String get onb1Title;

  /// No description provided for @onb1Sub.
  ///
  /// In en, this message translates to:
  /// **'Your #1 home-finding platform'**
  String get onb1Sub;

  /// No description provided for @onb1Desc.
  ///
  /// In en, this message translates to:
  /// **'Find the perfect home near your university — fast, safe, and hassle-free.'**
  String get onb1Desc;

  /// No description provided for @onb2Title.
  ///
  /// In en, this message translates to:
  /// **'Browse & Compare'**
  String get onb2Title;

  /// No description provided for @onb2Sub.
  ///
  /// In en, this message translates to:
  /// **'All options in one place'**
  String get onb2Sub;

  /// No description provided for @onb2Desc.
  ///
  /// In en, this message translates to:
  /// **'Explore dozens of student housings with clear photos, prices, and amenities. Compare and choose what suits you.'**
  String get onb2Desc;

  /// No description provided for @onb3Title.
  ///
  /// In en, this message translates to:
  /// **'Contact Directly'**
  String get onb3Title;

  /// No description provided for @onb3Sub.
  ///
  /// In en, this message translates to:
  /// **'No middlemen, no hassle'**
  String get onb3Sub;

  /// No description provided for @onb3Desc.
  ///
  /// In en, this message translates to:
  /// **'Reach landlords directly by phone and close the deal as fast as possible.'**
  String get onb3Desc;

  /// No description provided for @availableLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} available'**
  String availableLabel(int count);

  /// No description provided for @fullyBooked.
  ///
  /// In en, this message translates to:
  /// **'Fully Booked'**
  String get fullyBooked;

  /// No description provided for @bedsLeft.
  ///
  /// In en, this message translates to:
  /// **'{count} beds left'**
  String bedsLeft(int count);

  /// No description provided for @mapViewTitle.
  ///
  /// In en, this message translates to:
  /// **'Map View'**
  String get mapViewTitle;

  /// No description provided for @mapSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Explore saved homes on the map'**
  String get mapSubtitle;

  /// No description provided for @savedOnly.
  ///
  /// In en, this message translates to:
  /// **'Saved only'**
  String get savedOnly;

  /// No description provided for @allProperties.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allProperties;

  /// No description provided for @legendSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get legendSaved;

  /// No description provided for @legendNotSaved.
  ///
  /// In en, this message translates to:
  /// **'Not saved'**
  String get legendNotSaved;

  /// No description provided for @pricePerMo.
  ///
  /// In en, this message translates to:
  /// **'EGP {price}/mo'**
  String pricePerMo(int price);

  /// No description provided for @removeFromSaved.
  ///
  /// In en, this message translates to:
  /// **'Remove from Saved'**
  String get removeFromSaved;

  /// No description provided for @confirmRemove.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this property from your saved list?'**
  String get confirmRemove;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @yesRemove.
  ///
  /// In en, this message translates to:
  /// **'Yes, Remove'**
  String get yesRemove;

  /// No description provided for @browseListingsBtn.
  ///
  /// In en, this message translates to:
  /// **'Browse Listings'**
  String get browseListingsBtn;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Student Housing';

  @override
  String get homeTitle => 'Student Housing';

  @override
  String get homeSubtitle => 'Find your perfect accommodation';

  @override
  String get savedProperties => 'Saved Properties';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get about => 'About';

  @override
  String get browseListings => 'Browse Listings';

  @override
  String get noSavedProperties => 'No saved properties yet';

  @override
  String get noSavedPropertiesDesc =>
      'Tap the bookmark icon on any listing to save it here for quick access.';

  @override
  String get navHome => 'Home';

  @override
  String get navMap => 'Map';

  @override
  String get navSaved => 'Saved';

  @override
  String get navSettings => 'Settings';

  @override
  String propertiesSaved(int count) {
    return '$count properties saved';
  }

  @override
  String get filterCategories => 'Categories';

  @override
  String get filterAllAreas => 'All Areas';

  @override
  String get filterAll => 'All';

  @override
  String get filterBoys => 'Boys';

  @override
  String get filterGirls => 'Girls';

  @override
  String get filterMixed => 'Mixed';

  @override
  String get filterPriceRange => 'Price Range (EGP)';

  @override
  String get filterAmenities => 'Amenities';

  @override
  String get filterApply => 'Apply Filters';

  @override
  String get emptyFilterTitle => 'No housing matches your filters.';

  @override
  String get emptyFilterDesc => 'Clear all filters';

  @override
  String get detailLocation => 'Location';

  @override
  String get detailHousingRules => 'Housing Rules';

  @override
  String get detailAmenities => 'Amenities';

  @override
  String get detailPricing => 'Pricing';

  @override
  String get detailCode => 'Building Code';

  @override
  String get contactNow => 'Contact Now';

  @override
  String get beds => 'beds';

  @override
  String get mo => 'mo';

  @override
  String get month => 'month';

  @override
  String get price => 'Price';
}

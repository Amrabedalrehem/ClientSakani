// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'SUKNA';

  @override
  String get homeTitle => 'SUKNA';

  @override
  String get homeSubtitle => 'Find your ideal home';

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
  String get filterPriceRange => 'Price range';

  @override
  String filterPriceHint(int max) {
    return 'Enter a max of $max EGP to show lower prices';
  }

  @override
  String get filterAmenities => 'Amenities';

  @override
  String get filterApply => 'Apply Filters';

  @override
  String get filtersButton => 'Filters';

  @override
  String get sortPriceTitle => 'Sort by price';

  @override
  String get sortPriceLowToHigh => 'Low to high';

  @override
  String get sortPriceHighToLow => 'High to low';

  @override
  String get emptyFilterTitle => 'No housing matches your filters.';

  @override
  String get emptyFilterDesc => 'Clear all filters';

  @override
  String get offlineModeTitle => 'You\'re offline';

  @override
  String get offlineModeDesc => 'Showing cached data when available.';

  @override
  String get offlineModeEmptyTitle => 'No cached housing yet.';

  @override
  String get offlineModeEmptyDesc =>
      'Connect once to load data, then it will stay available offline.';

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

  @override
  String get loadingProperties => 'Loading...';

  @override
  String propertiesFound(int count) {
    return '$count properties found';
  }

  @override
  String get failedToLoad => 'Failed to load properties';

  @override
  String get retry => 'Retry';

  @override
  String get customizeExperience => 'Customize your experience';

  @override
  String get currentlyDark => 'Currently dark';

  @override
  String get currentlyLight => 'Currently light';

  @override
  String get perMonth => 'per month';

  @override
  String bedsAvailable(int available, int total) {
    return '$available of $total beds available';
  }

  @override
  String onlyLabel(String gender) {
    return '$gender Only';
  }

  @override
  String get propertyDetails => 'Property Details';

  @override
  String get totalRooms => 'Total Rooms';

  @override
  String get totalBeds => 'Total Beds';

  @override
  String get servicesIncluded => 'Services Included';

  @override
  String get apartmentCode => 'Apartment Code';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingStart => 'Get Started 🚀';

  @override
  String get onb1Title => 'Welcome to SUKNA';

  @override
  String get onb1Sub => 'Your #1 home-finding platform';

  @override
  String get onb1Desc =>
      'Find the perfect home near your university — fast, safe, and hassle-free.';

  @override
  String get onb2Title => 'Browse & Compare';

  @override
  String get onb2Sub => 'All options in one place';

  @override
  String get onb2Desc =>
      'Explore dozens of student housings with clear photos, prices, and amenities. Compare and choose what suits you.';

  @override
  String get onb3Title => 'Contact Directly';

  @override
  String get onb3Sub => 'No middlemen, no hassle';

  @override
  String get onb3Desc =>
      'Reach landlords directly by phone and close the deal as fast as possible.';

  @override
  String availableLabel(int count) {
    return '$count available';
  }

  @override
  String get fullyBooked => 'Fully Booked';

  @override
  String bedsLeft(int count) {
    return '$count beds left';
  }

  @override
  String get mapViewTitle => 'Map View';

  @override
  String get mapSubtitle => 'Explore saved homes on the map';

  @override
  String get savedOnly => 'Saved only';

  @override
  String get allProperties => 'All';

  @override
  String get legendSaved => 'Saved';

  @override
  String get legendNotSaved => 'Not saved';

  @override
  String pricePerMo(int price) {
    return 'EGP $price/mo';
  }

  @override
  String get removeFromSaved => 'Remove from Saved';

  @override
  String get confirmRemove =>
      'Are you sure you want to remove this property from your saved list?';

  @override
  String get cancel => 'Cancel';

  @override
  String get yesRemove => 'Yes, Remove';

  @override
  String get browseListingsBtn => 'Browse Listings';
}

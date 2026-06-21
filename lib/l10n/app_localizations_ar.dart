// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'سكن الطلاب';

  @override
  String get homeTitle => 'سكن الطلاب';

  @override
  String get homeSubtitle => 'ابحث عن سكنك المثالي';

  @override
  String get savedProperties => 'العقارات المحفوظة';

  @override
  String get settings => 'الإعدادات';

  @override
  String get language => 'اللغة';

  @override
  String get darkMode => 'الوضع الليلي';

  @override
  String get about => 'حول التطبيق';

  @override
  String get browseListings => 'تصفح العقارات';

  @override
  String get noSavedProperties => 'لا توجد عقارات محفوظة بعد';

  @override
  String get noSavedPropertiesDesc =>
      'اضغط على أيقونة الحفظ على أي عقار لحفظه هنا للوصول السريع.';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navMap => 'الخريطة';

  @override
  String get navSaved => 'المحفوظات';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String propertiesSaved(int count) {
    return '$count عقارات محفوظة';
  }

  @override
  String get filterCategories => 'الفئات';

  @override
  String get filterAllAreas => 'كل المناطق';

  @override
  String get filterAll => 'الكل';

  @override
  String get filterBoys => 'بنين';

  @override
  String get filterGirls => 'بنات';

  @override
  String get filterMixed => 'مختلط';

  @override
  String get filterPriceRange => 'نطاق السعر (جنيه)';

  @override
  String get filterAmenities => 'المميزات';

  @override
  String get filterApply => 'تطبيق الفلاتر';

  @override
  String get emptyFilterTitle => 'لا يوجد سكن يطابق بحثك.';

  @override
  String get emptyFilterDesc => 'مسح الفلاتر';

  @override
  String get detailLocation => 'الموقع';

  @override
  String get detailHousingRules => 'قواعد السكن';

  @override
  String get detailAmenities => 'المميزات';

  @override
  String get detailPricing => 'السعر';

  @override
  String get detailCode => 'كود المبنى';

  @override
  String get contactNow => 'تواصل الآن';

  @override
  String get beds => 'أسرة';

  @override
  String get mo => 'شهرياً';

  @override
  String get month => 'شهر';

  @override
  String get price => 'السعر';
}

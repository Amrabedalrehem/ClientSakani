// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'SUKNA';

  @override
  String get homeTitle => 'SUKNA';

  @override
  String get homeSubtitle => 'ابحث عن سكن مناسب';

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
  String get filterPriceRange => 'نطاق السعر';

  @override
  String filterPriceHint(int max) {
    return 'اكتب بحد أقصى $max جنيه عشان يظهر اللي أقل منه';
  }

  @override
  String get filterAmenities => 'المميزات';

  @override
  String get filterApply => 'تطبيق الفلاتر';

  @override
  String get filtersButton => 'الفلاتر';

  @override
  String get sortPriceTitle => 'ترتيب السعر';

  @override
  String get sortPriceLowToHigh => 'من الأقل إلى الأعلى';

  @override
  String get sortPriceHighToLow => 'من الأعلى إلى الأقل';

  @override
  String get emptyFilterTitle => 'لا يوجد سكن يطابق بحثك.';

  @override
  String get emptyFilterDesc => 'مسح الفلاتر';

  @override
  String get offlineModeTitle => 'أنت غير متصل';

  @override
  String get offlineModeDesc => 'يتم عرض البيانات المخزنة محليًا إن وجدت.';

  @override
  String get offlineModeEmptyTitle => 'لا توجد بيانات مخزنة بعد.';

  @override
  String get offlineModeEmptyDesc =>
      'اتصل بالإنترنت مرة واحدة لتحميل البيانات، ثم ستظل متاحة بدون نت.';

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

  @override
  String get loadingProperties => 'جاري التحميل...';

  @override
  String propertiesFound(int count) {
    return '$count عقار متاح';
  }

  @override
  String get failedToLoad => 'فشل في تحميل العقارات';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get customizeExperience => 'خصص تجربتك';

  @override
  String get currentlyDark => 'الوضع الداكن مفعّل';

  @override
  String get currentlyLight => 'الوضع الفاتح مفعّل';

  @override
  String get perMonth => 'شهرياً';

  @override
  String bedsAvailable(int available, int total) {
    return '$available من $total سرير متاح';
  }

  @override
  String onlyLabel(String gender) {
    return '$gender فقط';
  }

  @override
  String get propertyDetails => 'تفاصيل العقار';

  @override
  String get totalRooms => 'إجمالي الغرف';

  @override
  String get totalBeds => 'إجمالي الأسرة';

  @override
  String get servicesIncluded => 'الخدمات المتضمنة';

  @override
  String get apartmentCode => 'كود الشقة';

  @override
  String get onboardingSkip => 'تخطي';

  @override
  String get onboardingNext => 'التالي';

  @override
  String get onboardingStart => 'ابدأ الآن 🚀';

  @override
  String get onb1Title => 'مرحباً بك في SUKNA';

  @override
  String get onb1Sub => 'منصتك الأولى للعثور على السكن';

  @override
  String get onb1Desc =>
      'ابحث عن السكن المثالي بالقرب من جامعتك — بسرعة وأمان وبدون عناء.';

  @override
  String get onb2Title => 'تصفح وقارن';

  @override
  String get onb2Sub => 'كل الخيارات في مكان واحد';

  @override
  String get onb2Desc =>
      'اكتشف العشرات من مساكن الطلاب مع صور واضحة وأسعار ومميزات. قارن واختر ما يناسبك.';

  @override
  String get onb3Title => 'تواصل مباشرة';

  @override
  String get onb3Sub => 'بدون وسطاء، بدون عناء';

  @override
  String get onb3Desc =>
      'تواصل مع الملاك مباشرة عبر الهاتف وأتمم الصفقة بأسرع وقت ممكن.';

  @override
  String availableLabel(int count) {
    return '$count متاح';
  }

  @override
  String get fullyBooked => 'محجوز بالكامل';

  @override
  String bedsLeft(int count) {
    return '$count أسرة متبقية';
  }

  @override
  String get mapViewTitle => 'خريطة العقارات';

  @override
  String get mapSubtitle => 'استعرض السكنات المحفوظة على الخريطة';

  @override
  String get savedOnly => 'المحفوظات فقط';

  @override
  String get allProperties => 'الكل';

  @override
  String get legendSaved => 'محفوظ';

  @override
  String get legendNotSaved => 'غير محفوظ';

  @override
  String pricePerMo(int price) {
    return 'ج.م $price/شهر';
  }

  @override
  String get removeFromSaved => 'إزالة من المحفوظات';

  @override
  String get confirmRemove => 'هل تريد إزالة هذا العقار من قائمة المحفوظات؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get yesRemove => 'نعم، إزالة';

  @override
  String get browseListingsBtn => 'تصفح العقارات';
}

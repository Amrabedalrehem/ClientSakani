import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String _savedBox = 'saved_properties';
  static const String _cachedApartmentsBox = 'cached_apartments';
  static const String _cachedAreasBox = 'cached_areas';

   static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<String>(_savedBox);
    await Hive.openBox<String>(_cachedApartmentsBox);
    await Hive.openBox<String>(_cachedAreasBox);
  }

   static Box<String> get savedBox => Hive.box<String>(_savedBox);
  static Box<String> get cachedApartmentsBox => Hive.box<String>(_cachedApartmentsBox);
  static Box<String> get cachedAreasBox => Hive.box<String>(_cachedAreasBox);
}

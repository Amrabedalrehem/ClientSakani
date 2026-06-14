import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String _savedBox = 'saved_properties';

   static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<String>(_savedBox);
  }

   static Box<String> get savedBox => Hive.box<String>(_savedBox);
}
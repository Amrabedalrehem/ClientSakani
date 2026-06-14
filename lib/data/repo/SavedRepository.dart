import 'package:flutter_application_1/data/network/HiveService.dart';
import 'package:hive_flutter/hive_flutter.dart';
 
class SavedRepository {
  Box<String> get _box => HiveService.savedBox;

   Future<void> saveProperty(String propertyId) async {
    await _box.put(propertyId, propertyId);
  }

   Future<void> removeProperty(String propertyId) async {
    await _box.delete(propertyId);
  }

   Future<void> toggleSaved(String propertyId) async {
    if (isSaved(propertyId)) {
      await removeProperty(propertyId);
    } else {
      await saveProperty(propertyId);
    }
  }

   bool isSaved(String propertyId) {
    return _box.containsKey(propertyId);
  }

   List<String> getSavedIds() {
    return _box.values.toList();
  }

   int get savedCount => _box.length;

   Stream<BoxEvent> watchSaved() {
    return _box.watch();
  }
}
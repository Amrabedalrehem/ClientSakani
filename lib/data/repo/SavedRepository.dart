import 'package:flutter_application_1/core/dp/HiveService.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_application_1/data/datasource/HomeDataSource.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';
import 'package:flutter_application_1/data/model/AreaModel.dart';
 
class SavedRepository {
  Box<String> get _box => HiveService.savedBox;
  final HomeDataSource _homeDataSource = HomeDataSource();

  Future<List<PropertyModel>> getApartments() async {
    return await _homeDataSource.getApartments();
  }

  Future<List<AreaModel>> getAreas() async {
    return await _homeDataSource.getAreas();
  }

  Future<List<PropertyModel>> searchApartments({int? areaId, int? gender, double? maxPrice}) async {
    return await _homeDataSource.searchApartments(areaId: areaId, gender: gender, maxPrice: maxPrice);
  }

  Future<PropertyModel?> getApartmentById(int id) async {
    return await _homeDataSource.getApartmentById(id);
  }

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
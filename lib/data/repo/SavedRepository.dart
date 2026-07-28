import 'dart:convert';

import 'package:flutter_application_1/core/const/HomeConst.dart';
import 'package:flutter_application_1/core/dp/HiveService.dart';
import 'package:flutter_application_1/data/datasource/HomeDataSource.dart';
import 'package:flutter_application_1/data/model/AreaModel.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SavedRepository {
  final HomeDataSource _homeDataSource = HomeDataSource();

  Box<String> get _savedBox => HiveService.savedBox;
  Box<String> get _cachedApartmentsBox => HiveService.cachedApartmentsBox;
  Box<String> get _cachedAreasBox => HiveService.cachedAreasBox;

  Future<List<PropertyModel>> getApartments() async {
    try {
      final apartments = await _homeDataSource.getApartments();
      await _cacheApartments(apartments);
      return apartments;
    } catch (_) {
      final cached = getCachedApartments();
      if (cached.isNotEmpty) return cached;
      rethrow;
    }
  }

  Future<List<AreaModel>> getAreas() async {
    try {
      final areas = await _homeDataSource.getAreas();
      await _cacheAreas(areas);
      return areas;
    } catch (_) {
      final cached = getCachedAreas();
      if (cached.isNotEmpty) return cached;
      rethrow;
    }
  }

  Future<List<PropertyModel>> searchApartments({
    int? areaId,
    int? gender,
    double? maxPrice,
  }) async {
    try {
      final apartments = await _homeDataSource.searchApartments(
        areaId: areaId,
        gender: gender,
        maxPrice: maxPrice,
      );
      return apartments;
    } catch (_) {
      final cached = getCachedApartments();
      if (cached.isEmpty) rethrow;
      return _filterCachedApartments(
        cached,
        areaId: areaId,
        gender: gender,
        maxPrice: maxPrice,
      );
    }
  }

  Future<PropertyModel?> getApartmentById(int id) async {
    try {
      final property = await _homeDataSource.getApartmentById(id);
      if (property != null) {
        await _cacheApartments([property]);
        return property;
      }
    } catch (_) {
      // Fallback to local cache below.
    }

    return getCachedApartmentById(id);
  }

  Future<void> saveProperty(PropertyModel property) async {
    final savedProperty = property.copyWith(isSaved: true);
    await _savedBox.put(
      savedProperty.id,
      jsonEncode(savedProperty.toJson()),
    );
    await _cacheApartments([savedProperty]);
  }

  Future<void> removeProperty(String propertyId) async {
    await _savedBox.delete(propertyId);
  }

  Future<void> toggleSaved(PropertyModel property) async {
    if (isSaved(property.id)) {
      await removeProperty(property.id);
    } else {
      await saveProperty(property);
    }
  }

  bool isSaved(String propertyId) {
    return _savedBox.containsKey(propertyId);
  }

  List<String> getSavedIds() {
    return _savedBox.keys.map((key) => key.toString()).toList();
  }

  List<PropertyModel> getSavedProperties() {
    return _savedBox.toMap().entries.map(_decodePropertyEntry).whereType<PropertyModel>().toList();
  }

  List<PropertyModel> getCachedApartments() {
    return _cachedApartmentsBox.toMap().entries
        .map(_decodePropertyEntry)
        .whereType<PropertyModel>()
        .toList();
  }

  PropertyModel? getCachedApartmentById(int id) {
    final key = id.toString();
    final savedValue = _savedBox.get(key);
    if (savedValue != null) {
      final property = _decodePropertyValue(key, savedValue);
      if (property != null) return property;
    }

    final cachedValue = _cachedApartmentsBox.get(key);
    if (cachedValue != null) {
      return _decodePropertyValue(key, cachedValue);
    }

    return null;
  }

  List<AreaModel> getCachedAreas() {
    return _cachedAreasBox.toMap().entries
        .map((entry) {
          try {
            final decoded = jsonDecode(entry.value);
            if (decoded is Map<String, dynamic>) {
              return AreaModel.fromJson(decoded);
            }
            if (decoded is Map) {
              return AreaModel.fromJson(Map<String, dynamic>.from(decoded));
            }
          } catch (_) {
            // Ignore malformed cache entries.
          }
          return null;
        })
        .whereType<AreaModel>()
        .toList();
  }

  int get savedCount => _savedBox.length;

  Stream<BoxEvent> watchSaved() {
    return _savedBox.watch();
  }

  Future<void> _cacheApartments(List<PropertyModel> apartments) async {
    for (final apartment in apartments) {
      await _cachedApartmentsBox.put(
        apartment.id,
        jsonEncode(apartment.toJson()),
      );
    }
  }

  Future<void> _cacheAreas(List<AreaModel> areas) async {
    for (final area in areas) {
      await _cachedAreasBox.put(
        area.id.toString(),
        jsonEncode(area.toJson()),
      );
    }
  }

  List<PropertyModel> _filterCachedApartments(
    List<PropertyModel> apartments, {
    int? areaId,
    int? gender,
    double? maxPrice,
  }) {
    final areaName = _areaNameFromId(areaId);
    if (areaId != null && areaName == null) {
      return const [];
    }

    return apartments.where((property) {
      if (areaName != null && property.area != areaName) return false;

      if (gender != null) {
        final requiredGender = gender == 1 ? PropertyGender.females : PropertyGender.males;
        if (property.gender != requiredGender) return false;
      }

      if (maxPrice != null && property.pricePerMonth > maxPrice) return false;
      return true;
    }).toList();
  }

  String? _areaNameFromId(int? areaId) {
    if (areaId == null) return null;
    for (final area in getCachedAreas()) {
      if (area.id == areaId) return area.name;
    }
    return null;
  }

  PropertyModel? _decodePropertyEntry(MapEntry<dynamic, dynamic> entry) {
    final key = entry.key.toString();
    return _decodePropertyValue(key, entry.value.toString());
  }

  PropertyModel? _decodePropertyValue(String key, String value) {
    try {
      final decoded = jsonDecode(value);
      if (decoded is Map<String, dynamic>) {
        return PropertyModel.fromJson(decoded);
      }
      if (decoded is Map) {
        return PropertyModel.fromJson(Map<String, dynamic>.from(decoded));
      }
    } catch (_) {
      // Legacy fallback: if only the id was stored, use cached apartment data.
      final cached = _cachedApartmentsBox.get(key);
      if (cached != null && cached != value) {
        return _decodePropertyValue(key, cached);
      }
    }

    return null;
  }
}

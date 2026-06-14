import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/datasource/HomeDataSource.dart';

enum PropertyGender { males, females, mixed }

enum AvailabilityStatus { available, fullyBooked, limitedBeds }

class PropertyModel {
  final String id;
  final String name;
  final String area;
  final String imageUrl;
  final int pricePerMonth;
  final int totalBeds;
  final int availableBeds;
  final List<String> amenities;
  final PropertyGender gender;
  final bool isSaved;
  final double lat;
  final double lng;

  const PropertyModel({
    required this.id,
    required this.name,
    required this.area,
    required this.imageUrl,
    required this.pricePerMonth,
    required this.totalBeds,
    required this.availableBeds,
    required this.amenities,
    required this.gender,
    this.isSaved = false,
    this.lat = 30.0444,  
    this.lng = 31.2357,
  });

  AvailabilityStatus get availabilityStatus {
    if (availableBeds == 0) return AvailabilityStatus.fullyBooked;
    if (availableBeds <= 2) return AvailabilityStatus.limitedBeds;
    return AvailabilityStatus.available;
  }

  PropertyModel copyWith({
    bool? isSaved,
  }) {
    return PropertyModel(
      id: id,
      name: name,
      area: area,
      imageUrl: imageUrl,
      pricePerMonth: pricePerMonth,
      totalBeds: totalBeds,
      availableBeds: availableBeds,
      amenities: amenities,
      gender: gender,
      isSaved: isSaved ?? this.isSaved,
      lat: lat,
      lng: lng,
    );
  }
}

enum BottomNavItem { home, map, saved, settings }

extension BottomNavItemExt on BottomNavItem {
  String get label {
    switch (this) {
      case BottomNavItem.home:
        return 'Home';
      case BottomNavItem.map:
        return 'Map';
      case BottomNavItem.saved:
        return 'Saved';
      case BottomNavItem.settings:
        return 'Settings';
    }
  }

  IconData get icon {
    switch (this) {
      case BottomNavItem.home:
        return Icons.home_rounded;
      case BottomNavItem.map:
        return Icons.location_on_outlined;
      case BottomNavItem.saved:
        return Icons.bookmark_border_rounded;
      case BottomNavItem.settings:
        return Icons.settings_outlined;
    }
  }

  IconData get activeIcon {
    switch (this) {
      case BottomNavItem.home:
        return Icons.home_rounded;
      case BottomNavItem.map:
        return Icons.location_on_rounded;
      case BottomNavItem.saved:
        return Icons.bookmark_rounded;
      case BottomNavItem.settings:
        return Icons.settings_rounded;
    }
  }
}

class FilterValues {
  final String area;
  final GenderFilter gender;
  final int? maxPrice;

  const FilterValues({
    required this.area,
    required this.gender,
    this.maxPrice,
  });
}
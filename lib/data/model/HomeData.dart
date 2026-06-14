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
    );
  }
}

enum BottomNavItem { home, saved, settings }

extension BottomNavItemExt on BottomNavItem {
  String get label {
    switch (this) {
      case BottomNavItem.home:
        return 'Home';
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
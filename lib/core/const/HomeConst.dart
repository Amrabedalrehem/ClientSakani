import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/datasource/HomeDataSource.dart';

enum PropertyGender { males, females }

enum AvailabilityStatus { available, fullyBooked, limitedBeds }

class PropertyModel {
  final String id;
  final String name;
  final String area;
  final String imageUrl;
  final List<String> images;
  final int pricePerMonth;
  final int totalBeds;
  final int availableBeds;
  final int totalRooms;
  final List<String> amenities;
  final PropertyGender gender;
  final bool isSaved;
  final double lat;
  final double lng;
  final String address;
  final String phone;
  final String apartmentCode;
  final List<String> rules;

  const PropertyModel({
    required this.id,
    required this.name,
    required this.area,
    required this.imageUrl,
    this.images = const [],
    required this.pricePerMonth,
    required this.totalBeds,
    required this.availableBeds,
    this.totalRooms = 3,
    required this.amenities,
    required this.gender,
    this.isSaved = false,
    this.lat = 30.0444,
    this.lng = 31.2357,
    this.address = '',
    this.phone = '',
    this.apartmentCode = '',
    this.rules = const [
      'No smoking',
      'No pets',
      'Quiet hours 10PM-7AM',
      'Keep common areas clean',
    ],
  });

  AvailabilityStatus get availabilityStatus {
    if (availableBeds == 0) return AvailabilityStatus.fullyBooked;
    if (availableBeds <= 2) return AvailabilityStatus.limitedBeds;
    return AvailabilityStatus.available;
  }

  List<String> get allImages =>
      images.isNotEmpty ? images : [imageUrl];

  PropertyModel copyWith({
    bool? isSaved,
  }) {
    return PropertyModel(
      id: id,
      name: name,
      area: area,
      imageUrl: imageUrl,
      images: images,
      pricePerMonth: pricePerMonth,
      totalBeds: totalBeds,
      availableBeds: availableBeds,
      totalRooms: totalRooms,
      amenities: amenities,
      gender: gender,
      isSaved: isSaved ?? this.isSaved,
      lat: lat,
      lng: lng,
      address: address,
      phone: phone,
      apartmentCode: apartmentCode,
      rules: rules,
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


enum GenderFilter { all, males, females }

extension GenderFilterExt on GenderFilter {
  String get label {
    switch (this) {
      case GenderFilter.all:
        return 'All';
      case GenderFilter.males:
        return 'Males';
      case GenderFilter.females:
        return 'Females';
    }
  }

  IconData get icon {
    switch (this) {
      case GenderFilter.all:
        return Icons.people_rounded;
      case GenderFilter.males:
        return Icons.male_rounded;
      case GenderFilter.females:
        return Icons.female_rounded;
    }
  }

  Color get activeColor {
    switch (this) {
      case GenderFilter.all:
        return const Color(0xFF1A7EC8);
      case GenderFilter.males:
        return const Color(0xFF1A7EC8);
      case GenderFilter.females:
        return const Color(0xFFE91E8C);
    }
  }
}

 
 
extension PropertyGenderExt on PropertyGender {
  String get label {
    switch (this) {
      case PropertyGender.males:
        return 'Males';
      case PropertyGender.females:
        return 'Females';
    }
  }

  IconData get icon {
    switch (this) {
      case PropertyGender.males:
        return Icons.male_rounded;
      case PropertyGender.females:
        return Icons.female_rounded;
    }
  }

  Color get color {
    switch (this) {
      case PropertyGender.males:
        return const Color(0xFF1A7EC8);
      case PropertyGender.females:
        return const Color(0xFFE91E8C);
    }
  }
}

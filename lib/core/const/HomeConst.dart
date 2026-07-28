import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/data/datasource/HomeDataSource.dart';

enum PropertyGender { males, females }

enum AvailabilityStatus { available, fullyBooked, limitedBeds }

class PropertyModel {
  static const List<String> defaultRules = [
    'No smoking',
    'No pets',
    'Quiet hours 10PM-7AM',
    'Keep common areas clean',
  ];

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
    this.rules = defaultRules,
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'area': area,
      'imageUrl': imageUrl,
      'images': images,
      'pricePerMonth': pricePerMonth,
      'totalBeds': totalBeds,
      'availableBeds': availableBeds,
      'totalRooms': totalRooms,
      'amenities': amenities,
      'gender': gender.index,
      'isSaved': isSaved,
      'lat': lat,
      'lng': lng,
      'address': address,
      'phone': phone,
      'apartmentCode': apartmentCode,
      'rules': rules,
    };
  }

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    final images = (json['images'] as List?) ?? const [];
    final amenities = (json['amenities'] as List?) ?? const [];
    final rules = (json['rules'] as List?) ?? const [];
    final parsedRules = List<String>.from(rules.map((e) => e.toString()));

    return PropertyModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      area: json['area']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? '',
      images: List<String>.from(images.map((e) => e.toString())),
      pricePerMonth: (json['pricePerMonth'] as num?)?.toInt() ?? 0,
      totalBeds: (json['totalBeds'] as num?)?.toInt() ?? 0,
      availableBeds: (json['availableBeds'] as num?)?.toInt() ?? 0,
      totalRooms: (json['totalRooms'] as num?)?.toInt() ?? 0,
      amenities: List<String>.from(amenities.map((e) => e.toString())),
      gender: (json['gender'] as num?)?.toInt() == 1
          ? PropertyGender.females
          : PropertyGender.males,
      isSaved: json['isSaved'] == true,
      lat: (json['lat'] as num?)?.toDouble() ?? 30.0444,
      lng: (json['lng'] as num?)?.toDouble() ?? 31.2357,
      address: json['address']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      apartmentCode: json['apartmentCode']?.toString() ?? '',
      rules: parsedRules.isEmpty ? defaultRules : parsedRules,
    );
  }
}

enum BottomNavItem { home, map, saved, settings }

extension BottomNavItemExt on BottomNavItem {
  String label(BuildContext context) {
    switch (this) {
      case BottomNavItem.home:
        return AppLocalizations.of(context)?.navHome ?? 'Home';
      case BottomNavItem.map:
        return AppLocalizations.of(context)?.navMap ?? 'Map';
      case BottomNavItem.saved:
        return AppLocalizations.of(context)?.navSaved ?? 'Saved';
      case BottomNavItem.settings:
        return AppLocalizations.of(context)?.navSettings ?? 'Settings';
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
  final PriceSortOrder sortOrder;

  const FilterValues({
    required this.area,
    required this.gender,
    this.maxPrice,
    this.sortOrder = PriceSortOrder.none,
  });
}

extension FilterValuesExt on FilterValues {
  int get activeCount {
    var count = 0;
    if (area != 'All Areas') count++;
    if (gender != GenderFilter.all) count++;
    if (maxPrice != null) count++;
    if (sortOrder != PriceSortOrder.none) count++;
    return count;
  }
}

enum PriceSortOrder { none, lowToHigh, highToLow }

extension PriceSortOrderExt on PriceSortOrder {
  String label(BuildContext context) {
    switch (this) {
      case PriceSortOrder.none:
        return '';
      case PriceSortOrder.lowToHigh:
        return AppLocalizations.of(context)?.sortPriceLowToHigh ?? 'Low to high';
      case PriceSortOrder.highToLow:
        return AppLocalizations.of(context)?.sortPriceHighToLow ?? 'High to low';
    }
  }
}

enum GenderFilter { all, males, females }

extension GenderFilterExt on GenderFilter {
  String label(BuildContext context) {
    switch (this) {
      case GenderFilter.all:
        return AppLocalizations.of(context)?.filterAll ?? 'All';
      case GenderFilter.males:
        return AppLocalizations.of(context)?.filterBoys ?? 'Males';
      case GenderFilter.females:
        return AppLocalizations.of(context)?.filterGirls ?? 'Females';
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
  String label(BuildContext context) {
    switch (this) {
      case PropertyGender.males:
        return AppLocalizations.of(context)?.filterBoys ?? 'Males';
      case PropertyGender.females:
        return AppLocalizations.of(context)?.filterGirls ?? 'Females';
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

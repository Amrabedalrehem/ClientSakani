
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/HomeData.dart';

extension PropertyGenderExt on PropertyGender {
  String get label {
    switch (this) {
      case PropertyGender.males:
        return 'Males';
      case PropertyGender.females:
        return 'Females';
      case PropertyGender.mixed:
        return 'Mixed';
    }
  }

  IconData get icon {
    switch (this) {
      case PropertyGender.males:
        return Icons.male_rounded;
      case PropertyGender.females:
        return Icons.female_rounded;
      case PropertyGender.mixed:
        return Icons.people_alt_rounded;
    }
  }

  Color get color {
    switch (this) {
      case PropertyGender.males:
        return const Color(0xFF1A7EC8);
      case PropertyGender.females:
        return const Color(0xFFE91E8C);
      case PropertyGender.mixed:
        return const Color(0xFF9C27B0);
    }
  }
}
final List<PropertyModel> kDummyProperties = [
  const PropertyModel(
    id: '1',
    name: 'Campus View Apartments',
    area: 'Downtown',
    imageUrl: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=600',
    pricePerMonth: 450,
    totalBeds: 6,
    availableBeds: 2,
    amenities: ['WiFi', 'Electricity', 'Water'],
    gender: PropertyGender.males,
    lat: 30.0444,
    lng: 31.2357,
  ),
  const PropertyModel(
    id: '2',
    name: 'Sunrise Student Living',
    area: 'Eastside',
    imageUrl: 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=600',
    pricePerMonth: 520,
    totalBeds: 4,
    availableBeds: 0,
    amenities: ['WiFi', 'Electricity', 'Water'],
    gender: PropertyGender.mixed,
    lat: 30.0600,
    lng: 31.2800,
  ),
  const PropertyModel(
    id: '3',
    name: 'Green Park Residences',
    area: 'Westside',
    imageUrl: 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=600',
    pricePerMonth: 380,
    totalBeds: 8,
    availableBeds: 5,
    amenities: ['WiFi', 'Electricity', 'Water'],
    gender: PropertyGender.females,
    lat: 30.0300,
    lng: 31.2100,
  ),
];

enum GenderFilter { all, males, females, mixed }

extension GenderFilterExt on GenderFilter {
  String get label {
    switch (this) {
      case GenderFilter.all:
        return 'All';
      case GenderFilter.males:
        return 'Males';
      case GenderFilter.females:
        return 'Females';
      case GenderFilter.mixed:
        return 'Mixed';
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
      case GenderFilter.mixed:
        return Icons.people_alt_rounded;
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
      case GenderFilter.mixed:
        return const Color(0xFF9C27B0);
    }
  }
}

 
const List<String> kAreas = [
  'All Areas',
  'Downtown',
  'Westside',
  'Eastside',
];
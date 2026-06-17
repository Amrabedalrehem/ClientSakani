import 'package:dio/dio.dart';

class ApartmentModel {
  final int id;
  final double lat;
  final double lng;
  final String address;
  final int numberOfBeds;
  final int availableBeds;
  final String imageUrlCover;
  final String areaName;
  final double price;
  final int gender;
  final List<String> services;

  ApartmentModel({
    required this.id,
    required this.lat,
    required this.lng,
    required this.address,
    required this.numberOfBeds,
    required this.availableBeds,
    required this.imageUrlCover,
    required this.areaName,
    required this.price,
    required this.gender,
    required this.services,
  });

  factory ApartmentModel.fromJson(Map<String, dynamic> json) {
    return ApartmentModel(
      id: json['id'] ?? json['Id'] ?? 0,
      lat: (json['lat'] ?? json['Lat'] ?? 0.0).toDouble(),
      lng: (json['lng'] ?? json['Lng'] ?? 0.0).toDouble(),
      address: json['address'] ?? json['Address'] ?? '',
      numberOfBeds: json['numberOfBeds'] ?? json['NumberOfBeds'] ?? 0,
      availableBeds: json['availableBeds'] ?? json['AvailableBeds'] ?? 0,
      imageUrlCover: json['imageUrlCover'] ?? json['ImageUrlCover'] ?? '',
      areaName: json['areaName'] ?? json['AreaName'] ?? '',
      price: (json['price'] ?? json['Price'] ?? 0.0).toDouble(),
      gender: json['gender'] ?? json['Gender'] ?? 0,
      services: List<String>.from(json['services'] ?? json['Services'] ?? []),
    );
  }
}

void main() async {
  try {
      final dio = Dio(BaseOptions(baseUrl: 'http://sakan-qena.runasp.net'));
      final response = await dio.get('/api/Apartment/GetAllForUser');
      if (response.data != null && response.data['status'] == true) {
        List<dynamic> data = response.data['data'] ?? [];
        List<ApartmentModel> apartments = data.map((e) => ApartmentModel.fromJson(e)).toList();
        print('Success! Parsed ${apartments.length} apartments.');
      } else {
        print('API returned false status.');
      }
  } catch (e, stacktrace) {
      print('Exception: $e');
      print(stacktrace);
  }
}

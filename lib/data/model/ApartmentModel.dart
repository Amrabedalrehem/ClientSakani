class ApartmentModel {
  final int id;
  final double lat;
  final double lng;
  final String address;
  final int numberOfBeds;
  final int availableBeds;
  final int numberOfRooms;
  final String imageUrlCover;
  final List<String> imageUrls;
  final String areaName;
  final double price;
  final int gender;
  final String code;
  final String notes;
  final List<String> rules;
  final List<String> services;

  ApartmentModel({
    required this.id,
    required this.lat,
    required this.lng,
    required this.address,
    required this.numberOfBeds,
    required this.availableBeds,
    required this.numberOfRooms,
    required this.imageUrlCover,
    required this.imageUrls,
    required this.areaName,
    required this.price,
    required this.gender,
    required this.code,
    required this.notes,
    required this.rules,
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
      numberOfRooms: json['numberOfRooms'] ?? json['NumberOfRooms'] ?? 0,
      imageUrls: List<String>.from(json['imageUrls'] ?? json['ImageUrls'] ?? []),
      imageUrlCover: json['imageUrlCover'] ?? json['ImageUrlCover'] ?? (json['imageUrls'] != null && json['imageUrls'].isNotEmpty ? json['imageUrls'][0] : ''),
      areaName: json['areaName'] ?? json['AreaName'] ?? '',
      price: (json['pricePerBed'] ?? json['PricePerBed'] ?? json['price'] ?? json['Price'] ?? 0.0).toDouble(),
      gender: json['gender'] ?? json['Gender'] ?? 0,
      code: json['code'] ?? json['Code'] ?? '',
      notes: json['notes'] ?? json['Notes'] ?? '',
      rules: List<String>.from(json['rules'] ?? json['Rules'] ?? []),
      services: List<String>.from(json['services'] ?? json['Services'] ?? []),
    );
  }
}

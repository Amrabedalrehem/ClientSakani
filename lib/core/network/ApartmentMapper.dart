import 'package:flutter_application_1/core/const/HomeConst.dart';
import 'package:flutter_application_1/data/model/ApartmentModel.dart';

class ApartmentMapper {
  ApartmentMapper._();

  static PropertyModel toPropertyModel(ApartmentModel apt) {
    return PropertyModel(
      id: apt.id.toString(),
      name: apt.address.isNotEmpty ? apt.address : 'Apartment ${apt.id}',
      area: apt.areaName.isNotEmpty ? apt.areaName : 'Area',
      imageUrl: apt.imageUrlCover.isNotEmpty
          ? apt.imageUrlCover
          : 'https://via.placeholder.com/600',
      images: apt.imageUrls.isNotEmpty ? apt.imageUrls : <String>[],
      pricePerMonth: apt.price.toInt(),
      totalBeds: apt.numberOfBeds,
      availableBeds: apt.availableBeds,
      totalRooms: apt.numberOfRooms > 0 ? apt.numberOfRooms : 1,
      amenities: apt.services,
      gender: _mapGender(apt.gender),
      lat: apt.lat,
      lng: apt.lng,
      address: apt.address,
      phone: '',
      apartmentCode: apt.code.isNotEmpty ? apt.code : apt.id.toString(),
      rules: apt.rules.isNotEmpty ? apt.rules : <String>[],
    );
  }

  static List<PropertyModel> toPropertyModelList(List<ApartmentModel> apartments) {
    return apartments.map(toPropertyModel).toList();
  }

  static PropertyGender _mapGender(int gender) {
    if (gender == 1) return PropertyGender.females;
    return PropertyGender.males;
  }
}
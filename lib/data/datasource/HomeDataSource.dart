import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';
import 'package:flutter_application_1/core/network/Dio.dart';
import 'package:flutter_application_1/data/model/ApartmentModel.dart';
import 'package:flutter_application_1/data/model/AreaModel.dart';

class HomeDataSource {
  Future<List<PropertyModel>> getApartments() async {
    try {
      final response = await DioClient.instance.get('/api/Apartment/GetAllForUser');
      if (response.data != null && response.data['status'] == true) {
        List<dynamic> data = response.data['data'] ?? [];
        List<ApartmentModel> apartments = data.map((e) => ApartmentModel.fromJson(e)).toList();
        
        return apartments.map((apt) {
          PropertyGender pGender = PropertyGender.males;
          if (apt.gender == 0) pGender = PropertyGender.males;
          else if (apt.gender == 1) pGender = PropertyGender.females;
          
          return PropertyModel(
            id: apt.id.toString(),
            name: apt.address.isNotEmpty ? apt.address : 'Apartment ${apt.id}', 
            area: apt.areaName.isNotEmpty ? apt.areaName : 'Area',
            imageUrl: apt.imageUrlCover.isNotEmpty ? apt.imageUrlCover : 'https://via.placeholder.com/600',
            images: apt.imageUrls.isNotEmpty ? apt.imageUrls : <String>[],   
            pricePerMonth: apt.price.toInt(), 
            totalBeds: apt.numberOfBeds,
            availableBeds: apt.availableBeds,
            totalRooms: apt.numberOfRooms > 0 ? apt.numberOfRooms : 1,  
            amenities: apt.services, 
            gender: pGender, 
            lat: apt.lat,
            lng: apt.lng,
            address: apt.address,
            phone: '',
            apartmentCode: apt.code.isNotEmpty ? apt.code : apt.id.toString(),
            rules: apt.rules.isNotEmpty ? apt.rules : <String>[],  
          );
        }).toList();
      }
      return [];
    } catch (e) {
      print('Error fetching apartments: $e');
      return [];
    }
  }

  Future<List<PropertyModel>> searchApartments({int? areaId, int? gender, double? maxPrice}) async {
    try {
      final Map<String, dynamic> queryParams = {};
      if (areaId != null) queryParams['areaId'] = areaId;
      if (gender != null) queryParams['gender'] = gender;
      if (maxPrice != null) queryParams['maxPrice'] = maxPrice;

      final response = await DioClient.instance.get('/api/Apartment/GetApartments', queryParameters: queryParams);
      if (response.data != null && response.data['status'] == true) {
        List<dynamic> data = response.data['data'] ?? [];
        List<ApartmentModel> apartments = data.map((e) => ApartmentModel.fromJson(e)).toList();
        
        return apartments.map((apt) {
          PropertyGender pGender = PropertyGender.males;
          if (apt.gender == 0) pGender = PropertyGender.males;
          else if (apt.gender == 1) pGender = PropertyGender.females;
          
          return PropertyModel(
            id: apt.id.toString(),
            name: apt.address.isNotEmpty ? apt.address : 'Apartment ${apt.id}', 
            area: apt.areaName.isNotEmpty ? apt.areaName : 'Area',
            imageUrl: apt.imageUrlCover.isNotEmpty ? apt.imageUrlCover : 'https://via.placeholder.com/600',
            images: apt.imageUrls.isNotEmpty ? apt.imageUrls : <String>[],   
            pricePerMonth: apt.price.toInt(), 
            totalBeds: apt.numberOfBeds,
            availableBeds: apt.availableBeds,
            totalRooms: apt.numberOfRooms > 0 ? apt.numberOfRooms : 1,  
            amenities: apt.services, 
            gender: pGender, 
            lat: apt.lat,
            lng: apt.lng,
            address: apt.address,
            phone: '',
            apartmentCode: apt.code.isNotEmpty ? apt.code : apt.id.toString(),
            rules: apt.rules.isNotEmpty ? apt.rules : <String>[],  
          );
        }).toList();
      }
      return [];
    } catch (e) {
      print('Error searching apartments: $e');
      return [];
    }
  }

  Future<PropertyModel?> getApartmentById(int id) async {
    try {
      final response = await DioClient.instance.get('/api/Apartment/GetApartmentById', queryParameters: {'id': id});
      if (response.data != null && response.data['status'] == true) {
        final data = response.data['data'];
        if (data != null) {
          final apt = ApartmentModel.fromJson(data);
          PropertyGender pGender = PropertyGender.males;
          if (apt.gender == 0) pGender = PropertyGender.males;
          else if (apt.gender == 1) pGender = PropertyGender.females;
          
          return PropertyModel(
            id: apt.id.toString(),
            name: apt.address.isNotEmpty ? apt.address : 'Apartment ${apt.id}', 
            area: apt.areaName.isNotEmpty ? apt.areaName : 'Area',
            imageUrl: apt.imageUrlCover.isNotEmpty ? apt.imageUrlCover : 'https://via.placeholder.com/600',
            images: apt.imageUrls.isNotEmpty ? apt.imageUrls : <String>[],   
            pricePerMonth: apt.price.toInt(), 
            totalBeds: apt.numberOfBeds,
            availableBeds: apt.availableBeds,
            totalRooms: apt.numberOfRooms > 0 ? apt.numberOfRooms : 1,  
            amenities: apt.services, 
            gender: pGender, 
            lat: apt.lat,
            lng: apt.lng,
            address: apt.address,
            phone: '',
            apartmentCode: apt.code.isNotEmpty ? apt.code : apt.id.toString(),
            rules: apt.rules.isNotEmpty ? apt.rules : <String>[],  
          );
        }
      }
      return null;
    } catch (e) {
      print('Error fetching apartment details: $e');
      return null;
    }
  }

  Future<List<AreaModel>> getAreas() async {
    try {
      final response = await DioClient.instance.get('/api/Area/GetAllAreas');
      if (response.data != null && response.data['status'] == true) {
        List<dynamic> data = response.data['data'] ?? [];
        return data.map((e) => AreaModel.fromJson(e)).where((a) => a.name.isNotEmpty).toList();
      }
      return [];
    } catch (e) {
      print('Error fetching areas: $e');
      return [];
    }
  }
}



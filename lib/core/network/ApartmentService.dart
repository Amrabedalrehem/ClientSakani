import 'package:flutter_application_1/core/network/Dio.dart';
import 'package:flutter_application_1/data/model/ApartmentModel.dart';
import 'package:flutter_application_1/data/model/AreaModel.dart';
import 'ErrorHandler.dart';

class ApartmentService {
  Future<List<ApartmentModel>> getAllApartments() async {
    try {
      final response = await DioClient.instance.get('/api/Apartment/GetAllForUser');
      if (response.data?['status'] == true) {
        List<dynamic> data = response.data['data'] ?? [];
        return data.map((e) => ApartmentModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<List<ApartmentModel>> searchApartments({
    int? areaId,
    int? gender,
    double? maxPrice,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {};
      if (areaId != null) queryParams['areaId'] = areaId;
      if (gender != null) queryParams['gender'] = gender;
      if (maxPrice != null) queryParams['maxPrice'] = maxPrice;

      final response = await DioClient.instance.get(
        '/api/Apartment/GetApartments',
        queryParameters: queryParams,
      );

      if (response.data?['status'] == true) {
        List<dynamic> data = response.data['data'] ?? [];
        return data.map((e) => ApartmentModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<ApartmentModel?> getApartmentById(int id) async {
    try {
      final response = await DioClient.instance.get(
        '/api/Apartment/GetApartmentById',
        queryParameters: {'id': id},
      );

      if (response.data?['status'] == true) {
        final data = response.data['data'];
        if (data != null) return ApartmentModel.fromJson(data);
      }
      return null;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<List<AreaModel>> getAreas() async {
    try {
      final response = await DioClient.instance.get('/api/Area/GetAllAreas');
      if (response.data?['status'] == true) {
        List<dynamic> data = response.data['data'] ?? [];
        return data
            .map((e) => AreaModel.fromJson(e))
            .where((a) => a.name.isNotEmpty)
            .toList();
      }
      return [];
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}
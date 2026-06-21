import 'package:flutter_application_1/core/const/HomeConst.dart';
import 'package:flutter_application_1/core/network/ApartmentMapper.dart';
import 'package:flutter_application_1/core/network/ApartmentService.dart';
import 'package:flutter_application_1/core/network/ErrorHandler.dart';
import 'package:flutter_application_1/data/model/AreaModel.dart';
 

class HomeDataSource {
  final ApartmentService _service;

  HomeDataSource({ApartmentService? service})
      : _service = service ?? ApartmentService();

  Future<List<PropertyModel>> getApartments() async {
    try {
      final apartments = await _service.getAllApartments();
      return ApartmentMapper.toPropertyModelList(apartments);
    } on AppException {
      rethrow;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<List<PropertyModel>> searchApartments({
    int? areaId,
    int? gender,
    double? maxPrice,
  }) async {
    try {
      final apartments = await _service.searchApartments(
        areaId: areaId,
        gender: gender,
        maxPrice: maxPrice,
      );
      return ApartmentMapper.toPropertyModelList(apartments);
    } on AppException {
      rethrow;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<PropertyModel?> getApartmentById(int id) async {
    try {
      final apt = await _service.getApartmentById(id);
      if (apt == null) return null;
      return ApartmentMapper.toPropertyModel(apt);
    } on AppException {
      rethrow;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<List<AreaModel>> getAreas() async {
    try {
      return await _service.getAreas();
    } on AppException {
      rethrow;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}
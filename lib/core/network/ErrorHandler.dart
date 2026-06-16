import 'package:dio/dio.dart';

class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException({required this.message, this.statusCode});

  @override
  String toString() => message;
}

class ErrorHandler {
  ErrorHandler._();

  static AppException handle(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is AppException) {
      return error;
    } else {
      return AppException(message: 'Unexpected error: ${error.toString()}');
    }
  }

  static AppException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const AppException(message: 'Connection timed out. Please try again.');

      case DioExceptionType.connectionError:
        return const AppException(message: 'No internet connection. Please check your network.');

      case DioExceptionType.badResponse:
        return _handleStatusCode(error.response?.statusCode, error.response?.data);

      case DioExceptionType.cancel:
        return const AppException(message: 'Request was cancelled.');

      default:
        return const AppException(message: 'Something went wrong. Please try again.');
    }
  }

  static AppException _handleStatusCode(int? statusCode, dynamic data) {
    final serverMessage = data is Map ? data['message'] ?? data['error'] : null;

    switch (statusCode) {
      case 400:
        return AppException(message: serverMessage ?? 'Bad request.', statusCode: 400);
      case 401:
        return AppException(message: serverMessage ?? 'Unauthorized. Please login again.', statusCode: 401);
      case 403:
        return AppException(message: serverMessage ?? 'Access denied.', statusCode: 403);
      case 404:
        return AppException(message: serverMessage ?? 'Resource not found.', statusCode: 404);
      case 500:
        return AppException(message: serverMessage ?? 'Server error. Please try again later.', statusCode: 500);
      default:
        return AppException(message: serverMessage ?? 'Unexpected error.', statusCode: statusCode);
    }
  }
}
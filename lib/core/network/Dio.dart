import 'package:dio/dio.dart';

class DioClient {
  static const String _baseUrl = 'http://sakan-qena.runasp.net';

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  )..interceptors.add(_LogInterceptor()); 
  static Dio get instance => _dio;
}

 class _LogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST: ${options.method} ${options.baseUrl}${options.path}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RESPONSE: ${response.statusCode} ${response.requestOptions.path}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('ERROR: ${err.response?.statusCode} ${err.message}');
    handler.next(err);
  }
}
 
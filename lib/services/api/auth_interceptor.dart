import 'package:dio/dio.dart';

import '../storage/storage_services.dart';

class AuthInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!options.headers.containsKey('Authorization') && LocalStorage.token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ${LocalStorage.token}';
    }
    
    if (!options.headers.containsKey('Content-Type')) {
      options.headers['Content-Type'] = 'application/json';
    }

    super.onRequest(options, handler);
  }
}

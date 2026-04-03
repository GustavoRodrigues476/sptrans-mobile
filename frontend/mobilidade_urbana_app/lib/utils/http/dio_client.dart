import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  static final Dio instance = _build();

  static Dio _build() {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://url_base_da_API', // trocar quando for definido
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // To do:
        // adicionar JWT aqui
        // final token = await AuthService.getToken();
        // if (token != null) options.headers['Authorization'] = 'Bearer $token';

        handler.next(options);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (DioException e, handler) {
        if (kDebugMode) {
          debugPrint(
            '[DioClient] ${e.requestOptions.method} '
                '${e.requestOptions.path} → ${e.message}',
          );
        }
        handler.next(e);
      },
    ));

    return dio;
  }
}
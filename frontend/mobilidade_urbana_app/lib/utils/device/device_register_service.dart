import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mobilidade_urbana_app/utils/http/dio_client.dart';
import 'package:mobilidade_urbana_app/utils/device/device_token_service.dart';

class DeviceRegisterService {
  static final _dio = DioClient.instance;

  static Future<bool> register() async {
    try {
      final token = await DeviceTokenService.getOrCreate();

      final response = await _dio.post(
        '/devices',
        data: {
          'deviceToken': token,
          'platform': defaultTargetPlatform == TargetPlatform.android
              ? 'ANDROID'
              : 'IOS',
          'appVersion': '1.0.0',
        },
      );

      return response.statusCode == 201 || response.statusCode == 409;
    } on DioException catch (e) {
      debugPrint('[DeviceRegisterService] Falha: ${e.message}');
      return false;
    }
  }
}
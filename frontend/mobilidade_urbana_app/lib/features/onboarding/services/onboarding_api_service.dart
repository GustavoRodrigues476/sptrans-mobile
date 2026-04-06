import 'package:dio/dio.dart';
import '../models/onboarding_model.dart';
import 'onboarding_hive_service.dart';
import 'package:mobilidade_urbana_app/utils/http/dio_client.dart';

class OnboardingApiService {
  final _dio = DioClient.instance;

  Future<bool> send(OnboardingModel data) async {
    try {
      final response = await _dio.post(
        '/devices',
        data: data.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 409) {
        await OnboardingHiveService.markAsSynced();
        return true;
      }
      return false;
    } on DioException catch (e) {
      print('[OnboardingApiService] Falha: ${e.message}');
      return false;
    }
  }
}
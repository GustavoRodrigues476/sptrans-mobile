import 'package:dio/dio.dart';
import '../models/onboarding_model.dart';
import 'onboarding_hive_service.dart';
import 'package:mobilidade_urbana_app/utils/http/dio_client.dart';

class OnboardingApiService {
  final _dio = DioClient.instance;

  Future<bool> enviar(OnboardingModel data) async {
    try {
      await _dio.post('/api/onboarding', data: data.toJson());
      await OnboardingHiveService.markAsSynced();
      return true;
    } on DioException catch (e) {
      print('[OnboardingApiService] Falha ao enviar: ${e.message}');
      return false;
    }
  }
}
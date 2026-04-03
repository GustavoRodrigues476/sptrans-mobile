import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilidade_urbana_app/features/onboarding/screens/onboarding.dart';
import 'package:mobilidade_urbana_app/features/home/pages/screens/home_page.dart';
import 'core/bindings/app_bindings.dart';
import 'features/onboarding/services/onboarding_hive_service.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingFinished = OnboardingHiveService.isSynced;

    return GetMaterialApp(
      title: 'Mobilidade Urbana',
      initialBinding: AppBindings(),
      home: onboardingFinished ? const HomeScreen() : const OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
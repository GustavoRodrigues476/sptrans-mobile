
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobilidade_urbana_app/features/home/pages/screens/home_page.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  final pageController = PageController();
  final currentPageIndex = 0.obs;

  final selectedRoutePreference = 'Mais rápida'.obs;
  final transportPreferences = <String, bool>{
    'Ônibus': true,
    'Trem': true,
    'Metrô': true,
  }.obs;
  final slowWalkingPace = false.obs;
  final walkingDuration = 10.0.obs;

  bool get canGoNext {
    switch (currentPageIndex.value) {
      case 0:
        return transportPreferences.values.any((value) => value);

      case 1:
        return selectedRoutePreference.value.isNotEmpty;

      case 2:
        return true;

      default:
        return false;
    }
  }


  void updatePageIndicator(index) => currentPageIndex.value = index;

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage() {
    if (!canGoNext) return;

    if (currentPageIndex.value == 2) {
      Get.to(() => const HomeScreen());
    } else {
      final page = currentPageIndex.value + 1;
      pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previusPage() {
    if (currentPageIndex.value == 0) {
      return;
    } else {
      final page = currentPageIndex.value - 1;
      pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }

  void toggleTransport(String transport, bool value) {
    transportPreferences[transport] = value;
    transportPreferences.refresh();
  }

  bool isTransportEnabled(String transport) {
    return transportPreferences[transport] ?? false;
  }

  void updateRoutePreference(String value) {
    selectedRoutePreference.value = value;
  }

  void updateSlowWalkingPace(bool value) {
    slowWalkingPace.value = value;
  }

  void updateWalkingDuration(double value) {
    walkingDuration.value = value;
  }



}
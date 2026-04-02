
// import 'package:mobilidade_urbana_app/features/home/pages/screens/home_page.dart';
// import 'package:mobilidade_urbana_app/features/onboarding/screens/onboarding.dart';
// import 'package:mobilidade_urbana_app/features/welcome/pages/Welcome_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final prefs = await SharedPreferences.getInstance();
//   final onboardingDone = prefs.getBool('onboarding_complete') ?? false;
//
//   runApp(MyApp(onboardingDone: onboardingDone));
// }
//
// class MyApp extends StatelessWidget {
//   final bool onboardingDone;
//   const MyApp({super.key, required this.onboardingDone});
//
//   @override
//   Widget build(BuildContext context) {
//     final router = GoRouter(
//       initialLocation: onboardingDone ? '/home' : '/welcome',
//       routes: [
//         GoRoute(
//           path: '/welcome',
//           builder: (context, state) => const WelcomeScreen(),
//         ),
//         GoRoute(
//           path: '/onboarding',
//           builder: (context, state) => const OnboardingScreen(),
//         ),
//         GoRoute(
//           path: '/home',
//           builder: (context, state) => const HomeScreen(),
//         ),
//       ],
//     );
//
//     return MaterialApp.router(
//       title: 'Onboarding Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color(0xFF6C63FF),
//           brightness: Brightness.light,
//         ),
//         useMaterial3: true,
//         fontFamily: 'Roboto',
//       ),
//       routerConfig: router,
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilidade_urbana_app/features/onboarding/screens/onboarding.dart';
import 'package:mobilidade_urbana_app/features/welcome/pages/Welcome_page.dart';
import 'package:mobilidade_urbana_app/utils/theme/theme.dart';
import 'package:mobilidade_urbana_app/utils/theme/controllers/theme.controller.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  static const double fontScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme(fontScale),
      darkTheme: TAppTheme.darkTheme(fontScale),
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
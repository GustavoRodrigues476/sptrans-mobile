import 'package:go_router/go_router.dart';
import 'package:mobilidade_urbana_app/features/onboarding/screens/onboarding_page.dart';

final GoRouter appRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingScreen(),
      )
    ]
);
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilidade_urbana_app/features/onboarding/controllers/onboarding_controller.dart';
import 'package:mobilidade_urbana_app/utils/constants/colors.dart';
import 'package:mobilidade_urbana_app/utils/constants/sizes.dart';
import 'package:mobilidade_urbana_app/utils/helpers/helper_functions.dart';
import 'walking_duration_bottom_sheet.dart';

class OnboardingWalkingOptions extends StatelessWidget {
  const OnboardingWalkingOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = OnBoardingController.instance;

    return Obx(
          () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: TSizes.spaceBtwSections),
          _WalkingPaceSwitch(isDark: isDark, controller: controller),
          const SizedBox(height: TSizes.spaceBtwSections),
          _WalkingDurationSection(controller: controller, context: context),
        ],
      ),
    );
  }
}

class _WalkingPaceSwitch extends StatelessWidget {
  final bool isDark;
  final OnBoardingController controller;

  const _WalkingPaceSwitch({required this.isDark, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Ritmo de caminhada lento',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Switch(
          value: controller.slowWalkingPace.value,
          activeThumbColor: Colors.white,
          activeTrackColor: TColors.primary,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: isDark ? Colors.black38 : Colors.grey.shade300,
          onChanged: controller.updateSlowWalkingPace,
        ),
      ],
    );
  }
}

class _WalkingDurationSection extends StatelessWidget {
  final OnBoardingController controller;
  final BuildContext context;

  const _WalkingDurationSection({required this.controller, required this.context});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Duração da caminhada', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Text(
          'Define o máximo de minutos para cada seção de caminhada da sua viagem',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: () => WalkingDurationBottomSheet.show(context),
              icon: const Icon(Icons.directions_walk_outlined, size: 18),
              label: const Text('Definir duração'),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            Expanded(
              child: Text(
                controller.walkingDuration.value >= 60
                    ? 'Padrão (sem limite)'
                    : '${controller.walkingDuration.value.toInt()} min',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
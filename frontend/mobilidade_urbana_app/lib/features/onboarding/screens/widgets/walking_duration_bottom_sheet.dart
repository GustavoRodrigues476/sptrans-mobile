import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilidade_urbana_app/features/onboarding/controllers/onboarding_controller.dart';
import 'package:mobilidade_urbana_app/utils/constants/colors.dart';
import 'package:mobilidade_urbana_app/utils/constants/sizes.dart';
import 'package:mobilidade_urbana_app/utils/helpers/helper_functions.dart';

class WalkingDurationBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const _WalkingDurationContent(),
    );
  }
}

class _WalkingDurationContent extends StatelessWidget {
  const _WalkingDurationContent();

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    return Obx(
          () => Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Duração máxima da caminhada',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              '${controller.walkingDuration.value.toInt()} minutos',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Slider(
              value: controller.walkingDuration.value,
              min: 5,
              max: 60,
              divisions: 11,
              activeColor: TColors.primary,
              onChanged: controller.updateWalkingDuration,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Salvar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
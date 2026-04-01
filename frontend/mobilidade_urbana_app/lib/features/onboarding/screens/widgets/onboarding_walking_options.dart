import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilidade_urbana_app/features/onboarding/controllers/onboarding_controller.dart';
import 'package:mobilidade_urbana_app/utils/constants/colors.dart';
import 'package:mobilidade_urbana_app/utils/constants/sizes.dart';
import 'package:mobilidade_urbana_app/utils/helpers/helper_functions.dart';

class OnboardingWalkingOptions extends StatelessWidget {
  const OnboardingWalkingOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = OnBoardingController.instance;

    return Obx(
          () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: TSizes.spaceBtwSections),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Ritmo de caminhada lento',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Switch(
                value: controller.slowWalkingPace.value,
                activeColor: Colors.white,
                activeTrackColor: TColors.primary,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: dark ? Colors.black38: Colors.grey.shade300,
                onChanged: controller.updateSlowWalkingPace,
              ),
            ],
          ),

          const SizedBox(height: TSizes.spaceBtwSections),

          Text(
            'Duração da caminhada',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
          Text(
            'Define o máximo de minutos para cada seção de caminhada da sua viagem',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () => _showWalkingDurationModal(context),
                style: ButtonStyle( ),
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
      ),
    );
  }

  void _showWalkingDurationModal(BuildContext context) {
    final controller = OnBoardingController.instance;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final dark = THelperFunctions.isDarkMode(context);

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
      },
    );
  }
}
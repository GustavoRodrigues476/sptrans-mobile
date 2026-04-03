import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mobilidade_urbana_app/features/onboarding/screens/onboarding_debug.dart';
import 'package:mobilidade_urbana_app/features/welcome/pages/Welcome_page.dart';
import 'package:mobilidade_urbana_app/utils/constants/colors.dart';
import 'package:mobilidade_urbana_app/utils/helpers/helper_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    super.initState();
    // _loadPrefs();
  }

  Future<void> _resetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (mounted) Get.to(WelcomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? TColors.darkBackground : TColors.background,
      appBar: AppBar(
        backgroundColor: isDark ? TColors.darkBackground : TColors.background,
        foregroundColor: isDark ? Colors.white : Colors.black,
        title: const Text('Configurações Salvas',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: _resetOnboarding,
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Refazer onboarding',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          OutlinedButton.icon(
            onPressed: _resetOnboarding,
            icon: const Icon(Icons.restart_alt_rounded),
            label: const Text('Refazer onboarding'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              side: BorderSide(color: isDark ? Colors.white : Colors.black),
              foregroundColor: isDark ? Colors.white : Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () => Get.to(() => const OnboardingDebugPage()),
            icon: const Icon(Icons.link),
            label: const Text('Ver Debug do onboarding'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              side:  BorderSide(color: isDark ? Colors.white : Colors.black),
              foregroundColor: isDark ? Colors.white : Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFF6C63FF),
                  letterSpacing: 1)),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C63FF).withOpacity(0.07),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF6C63FF)),
      title: Text(label, style: const TextStyle(fontSize: 14)),
      trailing: Text(value,
          style: const TextStyle(
              fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E))),
    );
  }

  Widget _buildBoolTile(IconData icon, String label, bool value) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF6C63FF)),
      title: Text(label, style: const TextStyle(fontSize: 14)),
      trailing: Icon(
        value ? Icons.check_circle_rounded : Icons.cancel_rounded,
        color: value ? Colors.green : Colors.grey,
      ),
    );
  }
}
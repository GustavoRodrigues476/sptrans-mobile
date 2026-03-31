import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';
  String email = '';
  String theme = '';
  String language = '';
  bool notifyUpdates = false;
  bool notifyPromotions = false;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('user_name') ?? '';
      email = prefs.getString('user_email') ?? '';
      theme = prefs.getString('app_theme') ?? '';
      language = prefs.getString('app_language') ?? '';
      notifyUpdates = prefs.getBool('notify_updates') ?? false;
      notifyPromotions = prefs.getBool('notify_promotions') ?? false;
    });
  }

  Future<void> _resetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (mounted) context.go('/welcome');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
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
          // Avatar / Saudação
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6C63FF), Color(0xFF3B3799)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: Text(
                    name.isNotEmpty ? name[0].toUpperCase() : '?',
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Olá, $name!',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    Text(email,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildSection('Preferências', [
            _buildInfoTile(Icons.dark_mode_outlined, 'Tema', theme),
            _buildInfoTile(Icons.language, 'Idioma', language),
          ]),
          const SizedBox(height: 16),
          _buildSection('Notificações', [
            _buildBoolTile(
                Icons.system_update_alt, 'Atualizações', notifyUpdates),
            _buildBoolTile(
                Icons.local_offer_outlined, 'Promoções', notifyPromotions),
          ]),
          const SizedBox(height: 32),
          OutlinedButton.icon(
            onPressed: _resetOnboarding,
            icon: const Icon(Icons.restart_alt_rounded),
            label: const Text('Refazer onboarding'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              side: const BorderSide(color: Color(0xFF6C63FF)),
              foregroundColor: const Color(0xFF6C63FF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
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
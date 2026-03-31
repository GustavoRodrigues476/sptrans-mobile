import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
const OnboardingScreen({super.key});

@override
State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
final PageController _pageController = PageController();

int _currentPage = 0;
bool _isSaving = false;

final List<bool> _transportPreferences = [true, true, true];

String _selectedRoutePreference = 'Mais rápida';

bool _slowWalkingPace = true;
double _walkingDuration = 10;

@override
void dispose() {
_pageController.dispose();
super.dispose();
}

void _nextPage() {
if (_currentPage < 2) {
_pageController.nextPage(
duration: const Duration(milliseconds: 300),
curve: Curves.easeInOut,
);
} else {
_finishOnboarding();
}
}

void _prevPage() {
if (_currentPage > 0) {
_pageController.previousPage(
duration: const Duration(milliseconds: 300),
curve: Curves.easeInOut,
);
}
}

Future<void> _finishOnboarding() async {
setState(() => _isSaving = true);

final prefs = await SharedPreferences.getInstance();

await prefs.setBool('transport_bus', _transportPreferences[0]);
await prefs.setBool('transport_train', _transportPreferences[1]);
await prefs.setBool('transport_subway', _transportPreferences[2]);

await prefs.setString('route_preference', _selectedRoutePreference);

await prefs.setBool('slow_walking_pace', _slowWalkingPace);
await prefs.setDouble('walking_duration', _walkingDuration);

await prefs.setBool('onboarding_complete', true);

setState(() => _isSaving = false);

if (mounted) {
context.go('/home');
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFFF7F7F7),
body: SafeArea(
child: Column(
children: [
Expanded(
child: PageView(
controller: _pageController,
physics: const NeverScrollableScrollPhysics(),
onPageChanged: (index) {
setState(() => _currentPage = index);
},
children: [
_buildTransportPreferencesPage(),
_buildRoutePreferencesPage(),
_buildWalkingOptionsPage(),
],
),
),
_buildBottomButton(),
],
),
),
);
}

Widget _buildTransportPreferencesPage() {
return Padding(
padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
_buildHeader(title: 'Preferências'),
const SizedBox(height: 32),
const Text(
'Preferências de modos de transporte',
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.w700,
color: Color(0xFF2F2B35),
),
),
const SizedBox(height: 12),
const Text(
'Os tipos de transporte selecionados terão prioridade mais alta no trajeto sugerido',
style: TextStyle(
fontSize: 14,
color: Color(0xFF5F5B66),
height: 1.5,
),
),
const SizedBox(height: 36),
_buildTransportTile(
icon: Icons.directions_bus_outlined,
label: 'Ônibus',
value: _transportPreferences[0],
onChanged: (value) {
setState(() => _transportPreferences[0] = value);
},
),
const SizedBox(height: 24),
_buildTransportTile(
icon: Icons.train_outlined,
label: 'Trem',
value: _transportPreferences[1],
onChanged: (value) {
setState(() => _transportPreferences[1] = value);
},
),
const SizedBox(height: 24),
_buildTransportTile(
icon: Icons.subway_outlined,
label: 'Metrô',
value: _transportPreferences[2],
onChanged: (value) {
setState(() => _transportPreferences[2] = value);
},
),
],
),
);
}

Widget _buildRoutePreferencesPage() {
final options = [
{
'label': 'Mais rápida',
'icon': Icons.stars_outlined,
},
{
'label': 'Menos trocas',
'icon': Icons.sync_alt_outlined,
},
{
'label': 'Caminhar menos',
'icon': Icons.directions_walk_outlined,
},
];

return Padding(
padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
_buildHeader(title: 'Preferências'),
const SizedBox(height: 32),
const Text(
'Preferências de rota',
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.w700,
color: Color(0xFF2F2B35),
),
),
const SizedBox(height: 28),
...options.map((option) {
final label = option['label'] as String;
final icon = option['icon'] as IconData;
final isSelected = _selectedRoutePreference == label;

return Padding(
padding: const EdgeInsets.only(bottom: 16),
child: InkWell(
borderRadius: BorderRadius.circular(18),
onTap: () {
setState(() => _selectedRoutePreference = label);
},
child: Container(
padding: const EdgeInsets.symmetric(
horizontal: 16,
vertical: 20,
),
decoration: BoxDecoration(
color: isSelected
? const Color(0xFFF0F5E6)
    : Colors.transparent,
borderRadius: BorderRadius.circular(18),
),
child: Row(
children: [
Icon(icon, color: const Color(0xFF2F2B35)),
const SizedBox(width: 14),
Expanded(
child: Text(
label,
style: const TextStyle(
fontSize: 16,
fontWeight: FontWeight.w500,
color: Color(0xFF2F2B35),
),
),
),
Radio<String>(
value: label,
groupValue: _selectedRoutePreference,
activeColor: const Color(0xFF97C11F),
onChanged: (value) {
setState(() => _selectedRoutePreference = value!);
},
),
],
),
),
),
);
}),
],
),
);
}

Widget _buildWalkingOptionsPage() {
return Padding(
padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
_buildHeader(title: 'Opções de caminhada'),
const SizedBox(height: 32),
const Text(
'Velocidade de caminhada',
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.w700,
color: Color(0xFF2F2B35),
),
),
const SizedBox(height: 10),
const Text(
'Duplica o tempo para cada seção de caminhada de sua viagem',
style: TextStyle(
fontSize: 14,
color: Color(0xFF5F5B66),
height: 1.5,
),
),
const SizedBox(height: 28),
Row(
children: [
const Expanded(
child: Text(
'Ritmo de caminhada lento',
style: TextStyle(
fontSize: 16,
fontWeight: FontWeight.w500,
color: Color(0xFF2F2B35),
),
),
),
Switch(
value: _slowWalkingPace,
activeColor: Colors.white,
activeTrackColor: const Color(0xFF97C11F),
inactiveThumbColor: Colors.white,
inactiveTrackColor: Colors.grey.shade300,
onChanged: (value) {
setState(() => _slowWalkingPace = value);
},
),
],
),
const SizedBox(height: 40),
const Text(
'Duração da caminhada',
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.w700,
color: Color(0xFF2F2B35),
),
),
const SizedBox(height: 10),
const Text(
'Define o máximo de minutos para cada seção de caminhada da sua viagem',
style: TextStyle(
fontSize: 14,
color: Color(0xFF5F5B66),
height: 1.5,
),
),
const SizedBox(height: 28),
Row(
children: [
OutlinedButton.icon(
onPressed: () {
_showWalkingDurationModal();
},
icon: const Icon(Icons.directions_walk_outlined, size: 18),
label: const Text('Definir a duração'),
style: OutlinedButton.styleFrom(
foregroundColor: const Color(0xFF5F5B66),
side: BorderSide(color: Colors.grey.shade300),
padding: const EdgeInsets.symmetric(
horizontal: 18,
vertical: 16,
),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(28),
),
),
),
const SizedBox(width: 16),
Expanded(
child: Text(
_walkingDuration >= 60
? 'Padrão (sem limite)'
    : '${_walkingDuration.toInt()} min',
style: const TextStyle(
fontSize: 14,
color: Color(0xFF5F5B66),
),
),
),
],
),
],
),
);
}

Widget _buildHeader({required String title}) {
return Row(
children: [
IconButton(
onPressed: _currentPage == 0 ? null : _prevPage,
icon: const Icon(Icons.arrow_back_ios_new_rounded),
color: const Color(0xFF2F2B35),
),
Expanded(
child: Text(
title,
style: const TextStyle(
fontSize: 18,
fontWeight: FontWeight.w700,
color: Color(0xFF2F2B35),
),
),
),
const Icon(
Icons.flutter_dash_rounded,
color: Color(0xFF97C11F),
size: 28,
),
],
);
}

Widget _buildTransportTile({
required IconData icon,
required String label,
required bool value,
required ValueChanged<bool> onChanged,
}) {
return Row(
children: [
Icon(icon, color: const Color(0xFF2F2B35), size: 24),
const SizedBox(width: 16),
Expanded(
child: Text(
label,
style: const TextStyle(
fontSize: 16,
fontWeight: FontWeight.w500,
color: Color(0xFF2F2B35),
),
),
),
Switch(
value: value,
activeColor: Colors.white,
activeTrackColor: const Color(0xFF97C11F),
inactiveThumbColor: Colors.white,
inactiveTrackColor: Colors.grey.shade300,
onChanged: onChanged,
),
],
);
}

Widget _buildBottomButton() {
return Padding(
padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
child: SizedBox(
width: double.infinity,
height: 60,
child: ElevatedButton(
onPressed: _isSaving ? null : _nextPage,
style: ElevatedButton.styleFrom(
backgroundColor: const Color(0xFF2F2B35),
foregroundColor: Colors.white,
elevation: 0,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(32),
),
),
child: _isSaving
? const SizedBox(
width: 22,
height: 22,
child: CircularProgressIndicator(
color: Colors.white,
strokeWidth: 2,
),
)
    : Text(
_currentPage == 2 ? 'Concluir' : 'Continuar',
style: const TextStyle(
fontSize: 16,
fontWeight: FontWeight.w600,
),
),
),
),
);
}

void _showWalkingDurationModal() {
showModalBottomSheet(
context: context,
backgroundColor: Colors.white,
shape: const RoundedRectangleBorder(
borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
),
builder: (context) {
return StatefulBuilder(
builder: (context, setModalState) {
return Padding(
padding: const EdgeInsets.all(24),
child: Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'Duração máxima da caminhada',
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.w700,
),
),
const SizedBox(height: 20),
Text('${_walkingDuration.toInt()} minutos'),
Slider(
value: _walkingDuration,
min: 5,
max: 60,
divisions: 11,
activeColor: const Color(0xFF97C11F),
onChanged: (value) {
setModalState(() => _walkingDuration = value);
setState(() => _walkingDuration = value);
},
),
const SizedBox(height: 16),
SizedBox(
width: double.infinity,
child: ElevatedButton(
onPressed: () => Navigator.pop(context),
style: ElevatedButton.styleFrom(
backgroundColor: const Color(0xFF2F2B35),
foregroundColor: Colors.white,
),
child: const Text('Salvar'),
),
),
],
),
);
},
);
},
);
}
}

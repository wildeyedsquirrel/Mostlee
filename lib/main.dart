import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MostleeApp());
}

class MostleeApp extends StatelessWidget {
  const MostleeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mostlee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B9B7E),
          background: const Color(0xFFFAF7F2),
          surface: Colors.white,
          primary: const Color(0xFF6B7A5E),
          secondary: const Color(0xFFD98A6C),
        ),
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
      home: const MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final LatLng _moscowCenter = const LatLng(55.7558, 37.6173);

  String _selectedMode = 'Зелёный';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _modes = [
    {'name': 'Зелёный', 'icon': Icons.park_outlined, 'color': const Color(0xFF6B7A5E)},
    {'name': 'Исторический', 'icon': Icons.account_balance_outlined, 'color': const Color(0xFFD98A6C)},
    {'name': 'Тихий', 'icon': Icons.volume_off_outlined, 'color': const Color(0xFF7B8B9A)},
    {'name': 'Интересный', 'icon': Icons.storefront_outlined, 'color': const Color(0xFFE5A93C)},
    {'name': 'Долгий', 'icon': Icons.directions_walk_rounded, 'color': const Color(0xFF8E7C93)},
  ];

  void _showAiDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          top: 24,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.auto_awesome, color: Color(0xFF6B7A5E), size: 28),
                const SizedBox(width: 10),
                Text(
                  'Mostlee AI',
                  style: GoogleFonts.nunito(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF6B7A5E),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Опишите вашу идеальную прогулку (например: «Хочу пройтись 40 минут через тихие дворики к уютной кофейне»):',
              style: TextStyle(color: Colors.black70, fontSize: 14),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              autofocus: true,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Введите
                

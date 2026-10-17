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
  // Центр Москвы (Кремль / Охотный Ряд)
  final MapController _mapController = MapController();
  LatLng _currentCenter = const LatLng(55.7558, 37.6173);

  // Выбранный режим прогулки
  String _selectedMode = 'Зелёный';

  final List<Map<String, dynamic>> _modes = [
    {'name': 'Зелёный', 'icon': Icons.park_outlined, 'color': Color(0xFF6B7A5E)},
    {'name': 'Исторический', 'icon': Icons.account_balance_outlined, 'color': Color(0xFFD98A6C)},
    {'name': 'Тихий', 'icon': Icons.volume_off_outlined, 'color': Color(0xFF7B8B9A)},
    {'name': 'Интересный', 'icon': Icons.storefront_outlined, 'color': Color(0xFFE5A93C)},
    {'name': 'Долгий', 'icon': Icons.directions_walk_rounded, 'color': Color(0xFF8E7C93)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Интерактивная карта OpenStreetMap с пастельной стилизацией
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentCenter,
              initialZoom: 14.5,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.mostlee.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _currentCenter,
                    width: 40,
                    height: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFD98A6C),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: const [
                          BoxShadow(color: Colors.black26, blurRadius: 8),
                        ],
                      ),
                      child: const Icon(Icons.my_location, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // 2. Верхняя пастельная поисковая панель Mostlee AI
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.auto_awesome, color: Color(0xFF6B7A5E)),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Mostlee AI: куда отправимся?',
                      style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFAF7F2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.tune_rounded, color: Color(0xFFD98A6C), size: 20),
                  ),
                ],
              ),
            ),
          ),

          // 3. Нижний переключатель прогулочных режимов
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _modes.length,
                itemBuilder: (context, index) {
                  final mode = _modes[index];
                  final isSelected = _selectedMode == mode['name'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedMode = mode['name'];
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? mode['color'] : Colors.white.withOpacity(0.92),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            mode['icon'],
                            color: isSelected ? Colors.white : mode['color'],
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            mode['name'],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

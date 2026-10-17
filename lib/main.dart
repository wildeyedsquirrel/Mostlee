import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MostleeApp());
}

class MostleeApp extends StatelessWidget {
  const MostleeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mostlee - Прогулочные маршруты',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B9B7E), // Пастельный зелёный (шалфей)
          background: const Color(0xFFFAF7F2), // Тёплый молочный фон
          surface: Colors.white,
          primary: const Color(0xFF6B7A5E),
          secondary: const Color(0xFFD98A6C), // Тёплый терракотовый акцент
        ),
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Заглушка под будущую интерактивную карту Mostlee
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Mostlee',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6B7A5E),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '🗺️ Интерактивная карта микропутешествий',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            
            // Верхняя поисковая строка Mostlee AI
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search_rounded, color: Color(0xFF6B7A5E)),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Куда пойдём с Mostlee? Напиши ИИ...',
                        style: TextStyle(color: Colors.black45, fontSize: 15),
                      ),
                    ),
                    Icon(Icons.tune_rounded, color: Color(0xFFD98A6C)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

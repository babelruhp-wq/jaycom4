import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_router.dart';

void main() {
  runApp(const Jaycom4Site());
}

class JC {
  JC._();

  static const Color main = Color(0xFF38C792);
  static const Color mainSoft = Color(0xFF2DB47F);
  static const Color mainLight = Color(0xFFE6F9F1);
  static const Color mainDark = Color(0xFF1A3A2E);

  static const Color dark = Color(0xFF0B1A14);
  static const Color dark2 = Color(0xFF122A1F);
  static const Color title = Color(0xFF0B1A14);
  static const Color muted = Color(0xFF5A7268);
  static const Color border = Color(0xFFD4E5DC);
  static const Color bg = Color(0xFFF4FAF7);
  static const Color card = Colors.white;

  static const Color accentBlue = Color(0xFF2563EB);
  static const Color accentViolet = Color(0xFF7C3AED);

  static const Color softGreen = Color(0xFFE6F9F1);
  static const Color softBlue = Color(0xFFE8F1FF);
  static const Color softViolet = Color(0xFFF3E8FF);
  static const Color softIndigo = Color(0xFFEEF2FF);
  static const Color softOrange = Color(0xFFFFF7ED);
}

class Jaycom4Site extends StatelessWidget {
  const Jaycom4Site({super.key});

  ThemeData _buildTheme() {
    const colorScheme = ColorScheme.light(
      primary: Color(0xFF0F2A5F),
      secondary: Color(0xFF16A34A),
      surface: Colors.white,
      background: Color(0xFFF6F7FB),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xFF0F172A),
      onBackground: Color(0xFF0F172A),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFFF6F7FB),
      textTheme: GoogleFonts.notoSansArabicTextTheme(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      title: 'Jaycom4',
      themeMode: ThemeMode.light,
      theme: _buildTheme(),
      darkTheme: _buildTheme(),
    );
  }
}
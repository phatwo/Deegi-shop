import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/home/home_screen.dart';
import 'package:deegi_shop/l10n/app_localizations.dart';


void main() {
  runApp(
    const ProviderScope(
      child: DeegiShopApp(),
    ),
  );
}

class DeegiShopApp extends StatelessWidget {
  const DeegiShopApp({super.key});

  static const bordeaux = Color(0xFF8B1E3F);
  static const bordeauxDark = Color(0xFF64152D);
  static const cream = Color(0xFFFFF8F3);
  static const gold = Color(0xFFD4A72C);

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: bordeaux,
      brightness: Brightness.light,
    ).copyWith(
      primary: bordeaux,
      onPrimary: Colors.white,
      secondary: gold,
      surface: Colors.white,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeegiShop',

      // =========================================================
      // INTERNATIONALISATION
      // =========================================================

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [
        Locale('fr'),
        Locale('en'),
      ],

      locale: const Locale('fr'),

      // =========================================================
      // THÈME
      // =========================================================

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,

        scaffoldBackgroundColor: cream,

        appBarTheme: const AppBarTheme(
          backgroundColor: bordeaux,
          foregroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
        ),

        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          margin: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 6,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: bordeaux,
              width: 2,
            ),
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: bordeaux,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 14,
            ),
          ),
        ),

        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: Color(0xFFF3DDE4),
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        iconTheme: const IconThemeData(
          color: bordeaux,
        ),
      ),

      home: const HomeScreen(),
    );
  }
}
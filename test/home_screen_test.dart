import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:deegi_shop/features/home/home_screen.dart';
import 'package:deegi_shop/l10n/app_localizations.dart';

void main() {
  Widget createTestApp() {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('fr'),
      home: const HomeScreen(),
    );
  }

  testWidgets('HomeScreen affiche le contenu principal', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createTestApp());

    expect(find.text('Bienvenue sur DeegiShop'), findsOneWidget);
    expect(find.text('Catégories'), findsOneWidget);
    expect(find.text('Produits populaires 🔥'), findsOneWidget);
    expect(find.text('Acheter maintenant'), findsOneWidget);
  });

  testWidgets('HomeScreen affiche les quatre destinations', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createTestApp());

    expect(find.text('Accueil'), findsOneWidget);
    expect(find.text('Favoris'), findsOneWidget);
    expect(find.text('Panier'), findsOneWidget);
    expect(find.text('Profil'), findsOneWidget);
  });
}
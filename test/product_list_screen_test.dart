import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:deegi_shop/features/products/product_list_screen.dart';
import 'package:deegi_shop/providers/product_provider.dart';

void main() {
  testWidgets('ProductListScreen affiche la recherche et les filtres', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          productsProvider.overrideWith(
            (ref) async => [],
          ),
        ],
        child: const MaterialApp(
          home: ProductListScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('DeegiShop'), findsOneWidget);
    expect(
      find.byType(TextField),
      findsOneWidget,
    );
    expect(find.text('Catégorie'), findsOneWidget);
    expect(find.text('Trier'), findsOneWidget);
  });

  testWidgets('ProductListScreen affiche le message si aucun produit', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          productsProvider.overrideWith(
            (ref) async => [],
          ),
        ],
        child: const MaterialApp(
          home: ProductListScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(
      find.text('Aucun produit trouvé'),
      findsOneWidget,
    );
  });
}
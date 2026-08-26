import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:deegi_shop/features/cart/cart_screen.dart';

void main() {
  testWidgets('CartScreen affiche le panier vide', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: CartScreen(),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Mon panier'), findsOneWidget);
    expect(
      find.text('Votre panier est vide'),
      findsOneWidget,
    );
  });
}
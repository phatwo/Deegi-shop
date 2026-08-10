import 'package:deegi_shop/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('Le catalogue affiche les produits', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: DeegiShopApp(),
      ),
    );

    // Lance le chargement asynchrone.
    await tester.pump();

    // Attend la réponse du faux DataSource.
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Nos produits'), findsOneWidget);
    expect(find.text('Smartphone Pro'), findsOneWidget);
    expect(find.text('Casque Bluetooth'), findsOneWidget);
  });
}
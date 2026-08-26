import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:deegi_shop/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'navigation entre accueil et favoris',
    (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Accueil
      expect(find.text('Bienvenue sur DeegiShop'), findsOneWidget);

      // Favoris
      await tester.tap(find.text('Favoris'));
      await tester.pumpAndSettle();

      expect(find.text('Mes favoris ❤️'), findsOneWidget);
    },
  );
}
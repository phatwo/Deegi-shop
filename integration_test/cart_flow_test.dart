import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:deegi_shop/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'navigation vers le panier',
    (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Ouvrir le panier
      await tester.tap(find.text('Panier'));
      await tester.pumpAndSettle();

      expect(find.text('Mon panier'), findsOneWidget);
    },
  );
}
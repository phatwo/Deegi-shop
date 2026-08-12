import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:deegi_shop/main.dart';
import 'package:deegi_shop/providers/product_provider.dart';

void main() {
  testWidgets(
    'DeegiShop démarre correctement',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            productsProvider.overrideWith(
              (ref) async => [],
            ),
          ],
          child: const DeegiShopApp(),
        ),
      );

      await tester.pump();

      expect(
        find.byType(DeegiShopApp),
        findsOneWidget,
      );
    },
  );
}
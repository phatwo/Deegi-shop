import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:deegi_shop/data/models/product.dart';
import 'package:deegi_shop/providers/cart_provider.dart';

void main() {
  late Product product1;
  late Product product2;

  setUp(() {
    SharedPreferences.setMockInitialValues({});

    product1 = Product(
      id: 1,
      name: 'Robe',
      price: 15000,
      image: 'assets/images/robe.jpg',
      category: 'Mode',
      description: 'Une belle robe élégante.',
      rating: 4.5,
    );

    product2 = Product(
      id: 2,
      name: 'Sac',
      price: 10000,
      image: 'assets/images/sac.jpg',
      category: 'Accessoires',
      description: 'Un joli sac pratique.',
      rating: 4.2,
    );
  });

  Future<CartNotifier> createNotifier() async {
    final notifier = CartNotifier(
      () async => [product1, product2],
    );

    // Laisse le _loadCart() lancé par le constructeur
    // terminer avant de commencer le test.
    await Future<void>.delayed(Duration.zero);

    return notifier;
  }

  // ==========================================
  // 1. PANIER VIDE
  // ==========================================

  test('le panier est vide au démarrage', () async {
    final notifier = await createNotifier();

    expect(notifier.state, isEmpty);

    notifier.dispose();
  });

  // ==========================================
  // 2. AJOUTER UN PRODUIT
  // ==========================================

  test('ajouter un produit au panier', () async {
    final notifier = await createNotifier();

    await notifier.addProduct(product1);

    expect(notifier.state.length, 1);
    expect(notifier.state.first.product.id, 1);
    expect(notifier.state.first.quantity, 1);

    notifier.dispose();
  });

  // ==========================================
  // 3. AJOUTER DEUX FOIS LE MÊME PRODUIT
  // ==========================================

  test(
    'ajouter deux fois le même produit augmente la quantité',
    () async {
      final notifier = await createNotifier();

      await notifier.addProduct(product1);
      await notifier.addProduct(product1);

      expect(notifier.state.length, 1);
      expect(notifier.state.first.quantity, 2);

      notifier.dispose();
    },
  );

  // ==========================================
  // 4. AJOUTER DEUX PRODUITS DIFFÉRENTS
  // ==========================================

  test(
    'ajouter deux produits différents crée deux lignes',
    () async {
      final notifier = await createNotifier();

      await notifier.addProduct(product1);
      await notifier.addProduct(product2);

      expect(notifier.state.length, 2);
      expect(notifier.state[0].product.id, 1);
      expect(notifier.state[1].product.id, 2);

      notifier.dispose();
    },
  );

  // ==========================================
  // 5. AUGMENTER LA QUANTITÉ
  // ==========================================

  test(
    'augmenter la quantité d’un produit',
    () async {
      final notifier = await createNotifier();

      await notifier.addProduct(product1);
      await notifier.increaseQuantity(product1.id);

      expect(notifier.state.first.quantity, 2);

      notifier.dispose();
    },
  );

  // ==========================================
  // 6. DIMINUER LA QUANTITÉ
  // ==========================================

  test(
    'diminuer la quantité d’un produit',
    () async {
      final notifier = await createNotifier();

      await notifier.addProduct(product1);
      await notifier.increaseQuantity(product1.id);
      await notifier.decreaseQuantity(product1.id);

      expect(notifier.state.length, 1);
      expect(notifier.state.first.quantity, 1);

      notifier.dispose();
    },
  );

  // ==========================================
  // 7. DIMINUER À 1 SUPPRIME LE PRODUIT
  // ==========================================

  test(
    'diminuer la quantité à 1 supprime le produit',
    () async {
      final notifier = await createNotifier();

      await notifier.addProduct(product1);

      await notifier.decreaseQuantity(product1.id);

      expect(notifier.state, isEmpty);

      notifier.dispose();
    },
  );

  // ==========================================
  // 8. SUPPRIMER UN PRODUIT
  // ==========================================

  test(
    'supprimer un produit du panier',
    () async {
      final notifier = await createNotifier();

      await notifier.addProduct(product1);
      await notifier.addProduct(product2);

      await notifier.removeProduct(product1.id);

      expect(notifier.state.length, 1);
      expect(notifier.state.first.product.id, 2);

      notifier.dispose();
    },
  );

  // ==========================================
  // 9. VIDER LE PANIER
  // ==========================================

  test(
    'vider complètement le panier',
    () async {
      final notifier = await createNotifier();

      await notifier.addProduct(product1);
      await notifier.addProduct(product2);

      await notifier.clearCart();

      expect(notifier.state, isEmpty);

      notifier.dispose();
    },
  );

  // ==========================================
  // 10. SAUVEGARDE LOCALE
  // ==========================================

  test(
    'le panier sauvegarde les produits localement',
    () async {
      final notifier = await createNotifier();

      await notifier.addProduct(product1);

      final preferences =
          await SharedPreferences.getInstance();

      final savedCart =
          preferences.getString('cart_products');

      expect(savedCart, isNotNull);

      final decoded =
          jsonDecode(savedCart!) as List<dynamic>;

      expect(decoded.length, 1);
      expect(decoded[0]['productId'], 1);
      expect(decoded[0]['quantity'], 1);

      notifier.dispose();
    },
  );

  // ==========================================
  // 11. SAUVEGARDE DE LA QUANTITÉ
  // ==========================================

  test(
    'le panier sauvegarde la nouvelle quantité',
    () async {
      final notifier = await createNotifier();

      await notifier.addProduct(product1);
      await notifier.increaseQuantity(product1.id);

      final preferences =
          await SharedPreferences.getInstance();

      final savedCart =
          preferences.getString('cart_products');

      expect(savedCart, isNotNull);

      final decoded =
          jsonDecode(savedCart!) as List<dynamic>;

      expect(decoded[0]['productId'], 1);
      expect(decoded[0]['quantity'], 2);

      notifier.dispose();
    },
  );

  // ==========================================
  // 12. TOTAL
  // ==========================================

  test(
    'le total des produits du panier est correct',
    () async {
      final notifier = await createNotifier();

      await notifier.addProduct(product1);
      await notifier.addProduct(product2);

      final total = notifier.state.fold<double>(
        0,
        (sum, item) => sum + item.total,
      );

      expect(total, 25000);

      notifier.dispose();
    },
  );

  // ==========================================
  // 13. TOTAL AVEC QUANTITÉ
  // ==========================================

  test(
  'le total prend en compte la quantité',
  () async {
    final notifier = await createNotifier();

    await notifier.addProduct(product1);
    await notifier.increaseQuantity(product1.id);

    final total = notifier.state.fold<double>(
      0,
      (sum, item) => sum + item.total,
    );

    expect(total, 30000);

    notifier.dispose();
  },
);
  // ==========================================
  // 14. NOMBRE TOTAL D’ARTICLES
  // ==========================================

  test(
    'le nombre total d’articles est correct',
    () async {
      final notifier = await createNotifier();

      await notifier.addProduct(product1);
      await notifier.addProduct(product1);
      await notifier.addProduct(product2);

      final itemCount = notifier.state.fold<int>(
        0,
        (sum, item) => sum + item.quantity,
      );

      expect(itemCount, 3);

      notifier.dispose();
    },
  );
}
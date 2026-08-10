import 'dart:convert';

import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/cart_item.dart';
import '../data/models/product.dart';
import 'product_provider.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier(this._loadProducts) : super([]) {
    _loadCart();
  }

  final Future<List<Product>> Function() _loadProducts;

  static const String _cartKey = 'cart_products';

  // =========================
  // CHARGER LE PANIER
  // =========================

  Future<void> _loadCart() async {
    try {
      final preferences = await SharedPreferences.getInstance();

      final savedCart = preferences.getString(_cartKey);

      if (savedCart == null || savedCart.isEmpty) {
        return;
      }

      final List<dynamic> decoded = jsonDecode(savedCart);

      final products = await _loadProducts();

      final List<CartItem> loadedItems = [];

      for (final item in decoded) {
        final productId = item['productId'] as int;
        final quantity = item['quantity'] as int;

        final product = products.cast<Product?>().firstWhere(
              (product) => product?.id == productId,
              orElse: () => null,
            );

        if (product != null) {
          loadedItems.add(
            CartItem(
              product: product,
              quantity: quantity,
            ),
          );
        }
      }

      state = loadedItems;
    } catch (e) {
      // En cas d'erreur, on garde simplement un panier vide.
      state = [];
    }
  }

  // =========================
  // SAUVEGARDER LE PANIER
  // =========================

  Future<void> _saveCart() async {
    final preferences = await SharedPreferences.getInstance();

    final cartData = state.map((item) {
      return {
        'productId': item.product.id,
        'quantity': item.quantity,
      };
    }).toList();

    await preferences.setString(
      _cartKey,
      jsonEncode(cartData),
    );
  }

  // =========================
  // AJOUTER UN PRODUIT
  // =========================

  Future<void> addProduct(Product product) async {
    final index = state.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index == -1) {
      state = [
        ...state,
        CartItem(
          product: product,
          quantity: 1,
        ),
      ];
    } else {
      final updatedItems = [...state];

      updatedItems[index] = updatedItems[index].copyWith(
        quantity: updatedItems[index].quantity + 1,
      );

      state = updatedItems;
    }

    await _saveCart();
  }

  // =========================
  // SUPPRIMER UN PRODUIT
  // =========================

  Future<void> removeProduct(int productId) async {
    state = state
        .where((item) => item.product.id != productId)
        .toList();

    await _saveCart();
  }

  // =========================
  // AUGMENTER LA QUANTITÉ
  // =========================

  Future<void> increaseQuantity(int productId) async {
    state = state.map((item) {
      if (item.product.id == productId) {
        return item.copyWith(
          quantity: item.quantity + 1,
        );
      }

      return item;
    }).toList();

    await _saveCart();
  }

  // =========================
  // DIMINUER LA QUANTITÉ
  // =========================

  Future<void> decreaseQuantity(int productId) async {
    final updatedItems = <CartItem>[];

    for (final item in state) {
      if (item.product.id == productId) {
        if (item.quantity > 1) {
          updatedItems.add(
            item.copyWith(
              quantity: item.quantity - 1,
            ),
          );
        }
      } else {
        updatedItems.add(item);
      }
    }

    state = updatedItems;

    await _saveCart();
  }

  // =========================
  // VIDER LE PANIER
  // =========================

  Future<void> clearCart() async {
    state = [];

    final preferences = await SharedPreferences.getInstance();

    await preferences.remove(_cartKey);
  }
}

// =========================
// PROVIDER
// =========================

final cartProvider =
    StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier(
    () => ref.read(productsProvider.future),
  );
});

// =========================
// TOTAL DU PANIER
// =========================

final cartTotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);

  return cart.fold(
    0.0,
    (total, item) => total + item.total,
  );
});

// =========================
// NOMBRE D'ARTICLES
// =========================

final cartItemCountProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider);

  return cart.fold(
    0,
    (total, item) => total + item.quantity,
  );
});


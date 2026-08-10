import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../data/datasources/product_datasource.dart';
import '../data/models/product.dart';
import '../data/repositories/product_repository.dart';

/// Fournit la source de données des produits.
final productDataSourceProvider = Provider<ProductDataSource>((ref) {
  return ProductDataSource();
});

/// Fournit le repository des produits.
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final dataSource = ref.watch(productDataSourceProvider);

  return ProductRepository(dataSource);
});

/// Récupère les produits de manière asynchrone.
final productsProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);

  return repository.getProducts();
});

/// Texte de recherche actuel.
final productSearchProvider = StateProvider<String>((ref) {
  return '';
});

/// Catégorie sélectionnée.
/// null = toutes les catégories.
final productCategoryProvider = StateProvider<String?>((ref) {
  return null;
});

/// Tri sélectionné.
final productSortProvider = StateProvider<ProductSort>((ref) {
  return ProductSort.none;
});

enum ProductSort {
  none,
  priceLowToHigh,
  priceHighToLow,
  ratingHighToLow,
}

/// Produits filtrés et triés.
final filteredProductsProvider = Provider<AsyncValue<List<Product>>>((ref) {
  final productsAsync = ref.watch(productsProvider);
  final search = ref.watch(productSearchProvider).toLowerCase();
  final category = ref.watch(productCategoryProvider);
  final sort = ref.watch(productSortProvider);

  return productsAsync.whenData((products) {
    var result = products.where((product) {
      final matchesSearch =
          product.name.toLowerCase().contains(search);

      final matchesCategory =
          category == null || product.category == category;

      return matchesSearch && matchesCategory;
    }).toList();

    switch (sort) {
      case ProductSort.priceLowToHigh:
        result.sort((a, b) => a.price.compareTo(b.price));
        break;

      case ProductSort.priceHighToLow:
        result.sort((a, b) => b.price.compareTo(a.price));
        break;

      case ProductSort.ratingHighToLow:
        result.sort((a, b) => b.rating.compareTo(a.rating));
        break;

      case ProductSort.none:
        break;
    }

    return result;
  });
});

/// Liste des catégories disponibles.
final productCategoriesProvider = Provider<List<String>>((ref) {
  final productsAsync = ref.watch(productsProvider);

  return productsAsync.when(
    data: (products) {
      final categories = products
          .map((product) => product.category)
          .toSet()
          .toList();

      categories.sort();

      return categories;
    },
    loading: () => [],
    error: (_, _) => [],
  );
});
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/product_datasource.dart';
import '../../data/models/product.dart';
import '../../data/repositories/product_repository.dart';

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
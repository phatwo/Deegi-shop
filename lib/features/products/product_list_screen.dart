import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/product.dart';
import '../../providers/cart_provider.dart';
import '../../providers/favorite_provider.dart';
import '../../providers/product_provider.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(filteredProductsProvider);
    final categories = ref.watch(productCategoriesProvider);
    final selectedCategory = ref.watch(productCategoryProvider);
    final selectedSort = ref.watch(productSortProvider);
    final search = ref.watch(productSearchProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nos produits'),
      ),
      body: Column(
        children: [
          // 🔎 Recherche
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un produit...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: search.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          ref
                              .read(productSearchProvider.notifier)
                              .state = '';
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                ref.read(productSearchProvider.notifier).state = value;
              },
            ),
          ),

          // 🏷️ Catégorie + tri
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              children: [
                // Catégorie
                Expanded(
                  child: DropdownButtonFormField<String?>(
                    initialValue: selectedCategory,
                    decoration: const InputDecoration(
                      labelText: 'Catégorie',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem<String?>(
                        value: null,
                        child: Text('Toutes'),
                      ),
                      ...categories.map(
                        (category) => DropdownMenuItem<String?>(
                          value: category,
                          child: Text(category),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      ref
                          .read(productCategoryProvider.notifier)
                          .state = value;
                    },
                  ),
                ),

                const SizedBox(width: 12),

                // Tri
                Expanded(
                  child: DropdownButtonFormField<ProductSort>(
                    initialValue: selectedSort,
                    decoration: const InputDecoration(
                      labelText: 'Trier',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: ProductSort.none,
                        child: Text('Par défaut'),
                      ),
                      DropdownMenuItem(
                        value: ProductSort.priceLowToHigh,
                        child: Text('Prix ↑'),
                      ),
                      DropdownMenuItem(
                        value: ProductSort.priceHighToLow,
                        child: Text('Prix ↓'),
                      ),
                      DropdownMenuItem(
                        value: ProductSort.ratingHighToLow,
                        child: Text('Note ⭐'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        ref.read(productSortProvider.notifier).state =
                            value;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 4),

          // 📦 Produits
          Expanded(
            child: productsAsync.when(
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              error: (error, stackTrace) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 50,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Une erreur est survenue.',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          error.toString(),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            ref.invalidate(productsProvider);
                          },
                          child: const Text('Réessayer'),
                        ),
                      ],
                    ),
                  ),
                );
              },
              data: (products) {
                if (products.isEmpty) {
                  return const Center(
                    child: Text(
                      'Aucun produit ne correspond à votre recherche.',
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return ProductCard(
                      product: product,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends ConsumerWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoriteProvider);

    final isFavorite =
        favoritesAsync.value?.contains(product.id) ?? false;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              child: Icon(Icons.shopping_bag),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(product.category),

                  const SizedBox(height: 4),

                  Text(
                    '${product.price.toStringAsFixed(0)} FCFA',
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toStringAsFixed(1),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ❤️ Favoris
            IconButton(
              onPressed: () {
                ref
                    .read(favoriteProvider.notifier)
                    .toggleFavorite(product.id);
              },
              icon: Icon(
                isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
              ),
            ),

            // 🛒 Panier
            IconButton(
              onPressed: () {
                ref
                    .read(cartProvider.notifier)
                    .addProduct(product);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${product.name} ajouté au panier',
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.add_shopping_cart,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

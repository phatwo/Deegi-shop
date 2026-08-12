import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/product.dart';
import '../../providers/cart_provider.dart';
import '../../providers/favorite_provider.dart';
import '../../providers/product_provider.dart';
import 'product_detail_screen.dart';

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
        title: const Text(
          'DeegiShop',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
            tooltip: 'Notifications',
          ),
        ],
      ),
      body: Column(
        children: [
          // 🔎 Recherche
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
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
              ),
              onChanged: (value) {
                ref
                    .read(productSearchProvider.notifier)
                    .state = value;
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
                        ref
                            .read(productSortProvider.notifier)
                            .state = value;
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
                          size: 52,
                          color: Color(0xFF8B1E3F),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Une erreur est survenue.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          error.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            ref.invalidate(productsProvider);
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Réessayer'),
                        ),
                      ],
                    ),
                  ),
                );
              },
              data: (products) {
                if (products.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 55,
                            color: Color(0xFF8B1E3F),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Aucun produit trouvé',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Essayez une autre recherche ou une autre catégorie.',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    8,
                    16,
                    24,
                  ),
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
      margin: const EdgeInsets.only(bottom: 18),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(
                product: product,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼️ Image
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 220,
                  child: Image.asset(
                    product.image,
                    fit: BoxFit.cover,
                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return Container(
                        color: const Color(0xFFF6EDEF),
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            size: 50,
                            color: Color(0xFF8B1E3F),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // 🏷️ Catégorie
                Positioned(
                  left: 12,
                  bottom: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(
                        alpha: 0.94,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      product.category,
                      style: const TextStyle(
                        color: Color(0xFF64152D),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),

                // ❤️ Favoris
                Positioned(
                  top: 12,
                  right: 12,
                  child: Material(
                    color: Colors.white,
                    elevation: 3,
                    shape: const CircleBorder(),
                    child: IconButton(
                      tooltip: 'Ajouter aux favoris',
                      onPressed: () {
                        ref
                            .read(favoriteProvider.notifier)
                            .toggleFavorite(product.id);
                      },
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isFavorite
                            ? const Color(0xFF8B1E3F)
                            : Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // 📦 Informations
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                14,
                16,
                16,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.3,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ⭐ Note
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 18,
                        color: Color(0xFFD4A72C),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        product.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // 💰 Prix + 🛒 Panier
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${product.price.toStringAsFixed(0)} FCFA',
                          style: const TextStyle(
                            color: Color(0xFF8B1E3F),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      FilledButton.icon(
                        onPressed: () {
                          ref
                              .read(cartProvider.notifier)
                              .addProduct(product);

                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            SnackBar(
                              content: Text(
                                '${product.name} ajouté au panier',
                              ),
                              backgroundColor:
                                  const Color(0xFF64152D),
                              behavior:
                                  SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          size: 18,
                        ),
                        label: const Text('Ajouter'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


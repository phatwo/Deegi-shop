import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/product.dart';
import '../../providers/cart_provider.dart';
import '../../providers/favorite_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoriteProvider);

    final isFavorite =
        favoritesAsync.value?.contains(product.id) ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Détails du produit',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
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
            color: Colors.white,
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼️ Image du produit
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 360,
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
                            size: 70,
                            color: Color(0xFF8B1E3F),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // 🏷️ Catégorie
                Positioned(
                  left: 20,
                  bottom: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      product.category,
                      style: const TextStyle(
                        color: Color(0xFF64152D),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // 📦 Informations
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // Nom
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF64152D),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ⭐ Note
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFD4A72C),
                        size: 22,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        product.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Excellent produit',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // 💰 Prix
                  Text(
                    '${product.price.toStringAsFixed(0)} FCFA',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B1E3F),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ❤️ Favoris
                  OutlinedButton.icon(
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
                    label: Text(
                      isFavorite
                          ? 'Retirer des favoris'
                          : 'Ajouter aux favoris',
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor:
                          const Color(0xFF8B1E3F),
                      side: const BorderSide(
                        color: Color(0xFF8B1E3F),
                      ),
                      minimumSize: const Size(
                        double.infinity,
                        52,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 🛒 Panier
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
                    ),
                    label: const Text(
                      'Ajouter au panier',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF8B1E3F),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(
                        double.infinity,
                        54,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                    ),
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
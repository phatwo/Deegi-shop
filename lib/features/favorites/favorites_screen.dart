import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/cart_provider.dart';
import '../../providers/favorite_provider.dart';
import '../../providers/product_provider.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  static const Color primaryColor = Color(0xFF7A263A);
  static const Color darkColor = Color(0xFF3D2029);
  static const Color backgroundColor = Color(0xFFF8F4F5);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoriteProvider);
    final productsAsync = ref.watch(productsProvider);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        titleSpacing: 20,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ma sélection',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Mes favoris ❤️',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: darkColor,
              ),
            ),
          ],
        ),
      ),
      body: favoritesAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        ),
        error: (error, stackTrace) => _ErrorState(error: error.toString()),
        data: (favorites) {
          return productsAsync.when(
            loading: () => const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
            error: (error, stackTrace) =>
                _ErrorState(error: error.toString()),
            data: (products) {
              final favoriteProducts = products
                  .where(
                    (product) => favorites.contains(product.id),
                  )
                  .toList();

              if (favoriteProducts.isEmpty) {
                return const _EmptyFavorites();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                    child: Text(
                      '${favoriteProducts.length} produit${favoriteProducts.length > 1 ? 's' : ''} enregistré${favoriteProducts.length > 1 ? 's' : ''}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
                      itemCount: favoriteProducts.length,
                      itemBuilder: (context, index) {
                        final product = favoriteProducts[index];

                        return _FavoriteProductCard(
                          product: product,
                          onRemove: () {
                            ref
                                .read(favoriteProvider.notifier)
                                .toggleFavorite(product.id);
                          },
                          onAddToCart: () {
                            ref
                                .read(cartProvider.notifier)
                                .addProduct(product);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${product.name} ajouté au panier',
                                ),
                                backgroundColor: primaryColor,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

// =============================================================
// CARTE PRODUIT FAVORI
// =============================================================

class _FavoriteProductCard extends StatelessWidget {
  final dynamic product;
  final VoidCallback onRemove;
  final VoidCallback onAddToCart;

  const _FavoriteProductCard({
    required this.product,
    required this.onRemove,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFEADCE0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            // IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                product.image,
                width: 92,
                height: 92,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 92,
                    height: 92,
                    color: const Color(0xFFF5E8EB),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Color(0xFF7A263A),
                      size: 32,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 13),

            // INFORMATIONS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3D2029),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${product.rating}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Text(
                    '${product.price.toStringAsFixed(0)} FCFA',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7A263A),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 5),

            // ACTIONS
            Column(
              children: [
                IconButton(
                  onPressed: onRemove,
                  tooltip: 'Retirer des favoris',
                  icon: const Icon(
                    Icons.favorite,
                    color: Color(0xFF7A263A),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF7A263A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: onAddToCart,
                    tooltip: 'Ajouter au panier',
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================
// FAVORIS VIDE
// =============================================================

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 105,
              height: 105,
              decoration: BoxDecoration(
                color: const Color(0xFFF5E8EB),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border,
                size: 52,
                color: Color(0xFF7A263A),
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Votre sélection est vide',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3D2029),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ajoutez vos produits préférés ici\npour les retrouver facilement.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================
// ERREUR
// =============================================================

class _ErrorState extends StatelessWidget {
  final String error;

  const _ErrorState({
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 55,
              color: Color(0xFF7A263A),
            ),
            const SizedBox(height: 15),
            const Text(
              'Impossible de charger les favoris',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
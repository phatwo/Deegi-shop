import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/favorite_provider.dart';
import '../../providers/product_provider.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoriteProvider);
    final productsAsync = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes favoris'),
      ),
      body: favoritesAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text(
            'Erreur : $error',
            textAlign: TextAlign.center,
          ),
        ),
        data: (favorites) {
          return productsAsync.when(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stackTrace) => Center(
              child: Text(
                'Erreur : $error',
                textAlign: TextAlign.center,
              ),
            ),
            data: (products) {
              final favoriteProducts = products
                  .where(
                    (product) => favorites.contains(product.id),
                  )
                  .toList();

              if (favoriteProducts.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 70,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Aucun favori pour le moment',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: favoriteProducts.length,
                itemBuilder: (context, index) {
                  final product = favoriteProducts[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.shopping_bag),
                      ),
                      title: Text(product.name),
                      subtitle: Text(
                        '${product.price.toStringAsFixed(0)} FCFA',
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          ref
                              .read(favoriteProvider.notifier)
                              .toggleFavorite(product.id);
                        },
                        icon: const Icon(Icons.favorite),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
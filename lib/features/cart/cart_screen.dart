import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  static const bordeaux = Color(0xFF8B1E3F);
  static const darkBordeaux = Color(0xFF64152D);
  static const softBackground = Color(0xFFF9F3F5);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final total = ref.watch(cartTotalProvider);
    final itemCount = ref.watch(cartItemCountProvider);

    // 🛒 Panier vide
    if (cart.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Mon panier',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6EDEF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    size: 70,
                    color: bordeaux,
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Votre panier est vide',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: darkBordeaux,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'Découvrez nos produits et ajoutez vos coups de cœur.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: softBackground,

      appBar: AppBar(
        title: const Text(
          'Mon panier',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            tooltip: 'Vider le panier',
            onPressed: () {
              _showClearCartDialog(context, ref);
            },
            icon: const Icon(
              Icons.delete_sweep_outlined,
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          // 🧾 Résumé
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(
              16,
              16,
              16,
              4,
            ),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6EDEF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    color: bordeaux,
                  ),
                ),

                const SizedBox(width: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$itemCount article${itemCount > 1 ? 's' : ''}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Dans votre panier',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 📦 Produits
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(
                16,
                12,
                16,
                16,
              ),
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];

                return _CartItemCard(
                  item: item,
                  ref: ref,
                );
              },
            ),
          ),

          // 💰 Résumé total
          Container(
            padding: const EdgeInsets.fromLTRB(
              20,
              18,
              20,
              20,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sous-total',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '${total.toStringAsFixed(0)} FCFA',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Livraison',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const Text(
                        'À déterminer',
                        style: TextStyle(
                          color: bordeaux,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    child: Divider(),
                  ),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${total.toStringAsFixed(0)} FCFA',
                        style: const TextStyle(
                          color: bordeaux,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: FilledButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Commande bientôt disponible 🛍️',
                            ),
                            behavior:
                                SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.shopping_bag_outlined,
                      ),
                      label: const Text(
                        'Passer la commande',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: bordeaux,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearCartDialog(
    BuildContext context,
    WidgetRef ref,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Vider le panier ?',
          ),
          content: const Text(
            'Tous les produits seront retirés du panier.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Annuler'),
            ),
            FilledButton(
              onPressed: () {
                ref
                    .read(cartProvider.notifier)
                    .clearCart();

                Navigator.pop(context);
              },
              style: FilledButton.styleFrom(
                backgroundColor: bordeaux,
              ),
              child: const Text('Vider'),
            ),
          ],
        );
      },
    );
  }
}

// =====================================================
// 🛍️ CARTE PRODUIT DU PANIER
// =====================================================

class _CartItemCard extends StatelessWidget {
  final dynamic item;
  final WidgetRef ref;

  const _CartItemCard({
    required this.item,
    required this.ref,
  });

  static const bordeaux = Color(0xFF8B1E3F);
  static const darkBordeaux = Color(0xFF64152D);

  @override
  Widget build(BuildContext context) {
    final product = item.product;

    final itemTotal =
        product.price * item.quantity;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            // 🖼️ Image
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(14),
              child: SizedBox(
                width: 95,
                height: 105,
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
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        color: bordeaux,
                        size: 35,
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(width: 14),

            // 📦 Informations
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: darkBordeaux,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    '${product.price.toStringAsFixed(0)} FCFA',
                    style: const TextStyle(
                      color: bordeaux,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ➖ quantité ➕
                  Row(
                    children: [
                      _QuantityButton(
                        icon: Icons.remove,
                        onPressed: () {
                          ref
                              .read(
                                cartProvider.notifier,
                              )
                              .decreaseQuantity(
                                product.id,
                              );
                        },
                      ),

                      Container(
                        width: 38,
                        alignment:
                            Alignment.center,
                        child: Text(
                          '${item.quantity}',
                          style: const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),

                      _QuantityButton(
                        icon: Icons.add,
                        onPressed: () {
                          ref
                              .read(
                                cartProvider.notifier,
                              )
                              .increaseQuantity(
                                product.id,
                              );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // 💰 Total + suppression
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.end,
              children: [
                IconButton(
                  visualDensity:
                      VisualDensity.compact,
                  onPressed: () {
                    ref
                        .read(cartProvider.notifier)
                        .removeProduct(product.id);
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                  ),
                  color: Colors.grey.shade600,
                  tooltip: 'Supprimer',
                ),

                const SizedBox(height: 8),

                Text(
                  '${itemTotal.toStringAsFixed(0)} FCFA',
                  style: const TextStyle(
                    color: bordeaux,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
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

// =====================================================
// ➕➖ BOUTON QUANTITÉ
// =====================================================

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _QuantityButton({
    required this.icon,
    required this.onPressed,
  });

  static const bordeaux = Color(0xFF8B1E3F);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: const Color(0xFFF6EDEF),
          borderRadius:
              BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 18,
          color: bordeaux,
        ),
      ),
    );
  }
}
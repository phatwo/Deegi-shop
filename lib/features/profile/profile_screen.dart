import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/cart_provider.dart';
import '../../providers/favorite_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  static const Color primaryColor = Color(0xFF7A263A);
  static const Color darkColor = Color(0xFF3D2029);
  static const Color backgroundColor = Color(0xFFF8F4F5);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItemCount = ref.watch(cartItemCountProvider);
    final favoritesAsync = ref.watch(favoriteProvider);
    final favoriteCount = favoritesAsync.value?.length ?? 0;

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
              'Votre espace',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Mon profil 👤',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: darkColor,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
        children: [
          // =========================================================
          // HEADER PROFIL
          // =========================================================

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF681F32),
                  Color(0xFF9A4058),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.18),
                  blurRadius: 16,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.16),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.35),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 38,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bonjour 👋',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Fatou Touré',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'fatou@example.com',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          // =========================================================
          // STATISTIQUES
          // =========================================================

          const Text(
            'Mon activité',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: darkColor,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _ProfileStat(
                  icon: Icons.shopping_cart_outlined,
                  value: '$cartItemCount',
                  label: 'Panier',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ProfileStat(
                  icon: Icons.favorite_border,
                  value: '$favoriteCount',
                  label: 'Favoris',
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: _ProfileStat(
                  icon: Icons.receipt_long_outlined,
                  value: '0',
                  label: 'Commandes',
                ),
              ),
            ],
          ),

          const SizedBox(height: 26),

          // =========================================================
          // MON COMPTE
          // =========================================================

          const Text(
            'Mon compte',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: darkColor,
            ),
          ),

          const SizedBox(height: 12),

          _ProfileOption(
            icon: Icons.receipt_long_outlined,
            title: 'Mes commandes',
            subtitle: 'Consulter mes commandes',
            onTap: () {
              _showComingSoon(context, 'Mes commandes');
            },
          ),

          const SizedBox(height: 10),

          _ProfileOption(
            icon: Icons.favorite_border,
            title: 'Mes favoris',
            subtitle: '$favoriteCount produit(s) enregistré(s)',
            onTap: () {
              _showComingSoon(context, 'Mes favoris');
            },
          ),

          const SizedBox(height: 10),

          _ProfileOption(
            icon: Icons.shopping_cart_outlined,
            title: 'Mon panier',
            subtitle: '$cartItemCount article(s) dans le panier',
            onTap: () {
              _showComingSoon(context, 'Mon panier');
            },
          ),

          const SizedBox(height: 26),

          // =========================================================
          // PARAMÈTRES
          // =========================================================

          const Text(
            'Application',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: darkColor,
            ),
          ),

          const SizedBox(height: 12),

          _ProfileOption(
            icon: Icons.settings_outlined,
            title: 'Paramètres',
            subtitle: 'Gérer les paramètres',
            onTap: () {
              _showComingSoon(context, 'Paramètres');
            },
          ),

          const SizedBox(height: 10),

          _ProfileOption(
            icon: Icons.notifications_none,
            title: 'Notifications',
            subtitle: 'Gérer mes notifications',
            onTap: () {
              _showComingSoon(context, 'Notifications');
            },
          ),

          const SizedBox(height: 10),

          _ProfileOption(
            icon: Icons.info_outline,
            title: 'À propos de DeegiShop',
            subtitle: 'Version 1.0.0',
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'DeegiShop',
                applicationVersion: '1.0.0',
                applicationIcon: const CircleAvatar(
                  backgroundColor: primaryColor,
                  child: Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                  ),
                ),
                children: const [
                  Text(
                    'DeegiShop est une application e-commerce '
                    'moderne permettant de découvrir et acheter '
                    'des produits de mode et d’électronique.',
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 26),

          // =========================================================
          // DÉCONNEXION
          // =========================================================

          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Déconnexion simulée',
                  ),
                  backgroundColor: primaryColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.logout,
              color: primaryColor,
            ),
            label: const Text(
              'Se déconnecter',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 14,
              ),
              side: const BorderSide(
                color: Color(0xFFE0C8CE),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Center(
            child: Text(
              'DeegiShop • 2026',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void _showComingSoon(
    BuildContext context,
    String feature,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$feature sera disponible prochainement.',
        ),
        backgroundColor: primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}

// =============================================================
// STATISTIQUE
// =============================================================

class _ProfileStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _ProfileStat({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFEADCE0),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFF5E8EB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF7A263A),
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3D2029),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// OPTION PROFIL
// =============================================================

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProfileOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 13,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFEADCE0),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5E8EB),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF7A263A),
                  size: 22,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3D2029),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
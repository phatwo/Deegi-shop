import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/cart_provider.dart';
import '../../providers/favorite_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItemCount = ref.watch(cartItemCountProvider);

    final favoritesAsync = ref.watch(favoriteProvider);

    final favoriteCount = favoritesAsync.value?.length ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon profil'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // 👤 Informations utilisateur
          const CircleAvatar(
            radius: 45,
            child: Icon(
              Icons.person,
              size: 50,
            ),
          ),

          const SizedBox(height: 16),

          const Center(
            child: Text(
              'Fatou Touré',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 4),

          const Center(
            child: Text(
              'fatou@example.com',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),

          const SizedBox(height: 30),

          // 📊 Statistiques
          Row(
            children: [
              Expanded(
                child: _ProfileStat(
                  icon: Icons.shopping_bag_outlined,
                  value: '$cartItemCount',
                  label: 'Panier',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ProfileStat(
                  icon: Icons.favorite_border,
                  value: '$favoriteCount',
                  label: 'Favoris',
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: _ProfileStat(
                  icon: Icons.receipt_long_outlined,
                  value: '0',
                  label: 'Commandes',
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // ⚙️ Options
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.shopping_bag_outlined),
                  title: const Text('Mes commandes'),
                  subtitle: const Text(
                    'Consulter mes commandes',
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                  ),
                  onTap: () {},
                ),

                const Divider(height: 1),

                ListTile(
                  leading: const Icon(
                    Icons.favorite_border,
                  ),
                  title: const Text('Mes favoris'),
                  subtitle: Text(
                    '$favoriteCount produit(s) favori(s)',
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                  ),
                  onTap: () {},
                ),

                const Divider(height: 1),

                ListTile(
                  leading: const Icon(
                    Icons.settings_outlined,
                  ),
                  title: const Text('Paramètres'),
                  subtitle: const Text(
                    'Gérer les paramètres de l’application',
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 🚪 Déconnexion mock
          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Déconnexion simulée',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text('Se déconnecter'),
          ),
        ],
      ),
    );
  }
}

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
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 8,
        ),
        child: Column(
          children: [
            Icon(icon),

            const SizedBox(height: 8),

            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              label,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

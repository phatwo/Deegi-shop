import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final favoriteProvider =
    AsyncNotifierProvider<FavoriteNotifier, Set<int>>(
  FavoriteNotifier.new,
);

class FavoriteNotifier extends AsyncNotifier<Set<int>> {
  static const String _favoritesKey = 'favorite_products';

  @override
  Future<Set<int>> build() async {
    final preferences = await SharedPreferences.getInstance();

    final savedFavorites =
        preferences.getStringList(_favoritesKey) ?? [];
    return savedFavorites.map(int.parse).toSet();
  }

  Future<void> toggleFavorite(int productId) async {
    final currentFavorites = state.value ?? <int>{};
    final updatedFavorites = <int>{...currentFavorites};

    if (updatedFavorites.contains(productId)) {
      updatedFavorites.remove(productId);
    } else {
      updatedFavorites.add(productId);
    }

    state = AsyncData(updatedFavorites);

    final preferences = await SharedPreferences.getInstance();

    await preferences.setStringList(
      _favoritesKey,
      updatedFavorites.map((id) => id.toString()).toList(),
    );
  }

  Future<void> clearFavorites() async {
    state = const AsyncData(<int>{});

    final preferences = await SharedPreferences.getInstance();

    await preferences.remove(_favoritesKey);
  }
}
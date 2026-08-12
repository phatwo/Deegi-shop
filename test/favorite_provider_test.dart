import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:deegi_shop/providers/favorite_provider.dart';

void main() {
  // ==========================================
  // TEST 1 : CHARGEMENT SANS FAVORIS
  // ==========================================

  test('les favoris sont vides au premier chargement', () async {
    SharedPreferences.setMockInitialValues({});

    final container = ProviderContainer();
    addTearDown(container.dispose);

    final favorites = await container.read(favoriteProvider.future);

    expect(favorites, isEmpty);
  });

  // ==========================================
  // TEST 2 : AJOUTER UN FAVORI
  // ==========================================

  test('ajouter un produit aux favoris', () async {
    SharedPreferences.setMockInitialValues({});

    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container.read(favoriteProvider.future);

    await container
        .read(favoriteProvider.notifier)
        .toggleFavorite(1);

    final favorites = container.read(favoriteProvider).value;

    expect(favorites, contains(1));
    expect(favorites!.length, 1);
  });

  // ==========================================
  // TEST 3 : AJOUTER PLUSIEURS FAVORIS
  // ==========================================

  test('ajouter plusieurs produits aux favoris', () async {
    SharedPreferences.setMockInitialValues({});

    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container.read(favoriteProvider.future);

    final notifier = container.read(favoriteProvider.notifier);

    await notifier.toggleFavorite(1);
    await notifier.toggleFavorite(2);
    await notifier.toggleFavorite(3);

    final favorites = container.read(favoriteProvider).value;

    expect(favorites, containsAll([1, 2, 3]));
    expect(favorites!.length, 3);
  });

  // ==========================================
  // TEST 4 : RETIRER UN FAVORI
  // ==========================================

  test('retirer un produit des favoris', () async {
    SharedPreferences.setMockInitialValues({});

    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container.read(favoriteProvider.future);

    final notifier = container.read(favoriteProvider.notifier);

    await notifier.toggleFavorite(1);

    expect(
      container.read(favoriteProvider).value,
      contains(1),
    );

    await notifier.toggleFavorite(1);

    final favorites = container.read(favoriteProvider).value;

    expect(favorites, isNot(contains(1)));
    expect(favorites, isEmpty);
  });

  // ==========================================
  // TEST 5 : PAS DE DOUBLON
  // ==========================================

  test('un produit favori ne peut pas être ajouté deux fois', () async {
    SharedPreferences.setMockInitialValues({});

    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container.read(favoriteProvider.future);

    final notifier = container.read(favoriteProvider.notifier);

    await notifier.toggleFavorite(1);

    // Deuxième toggle retire le favori.
    await notifier.toggleFavorite(1);

    final favorites = container.read(favoriteProvider).value;

    expect(favorites, isEmpty);
  });

  // ==========================================
  // TEST 6 : PERSISTANCE LOCALE
  // ==========================================

  test('les favoris sont sauvegardés localement', () async {
    SharedPreferences.setMockInitialValues({});

    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container.read(favoriteProvider.future);

    await container
        .read(favoriteProvider.notifier)
        .toggleFavorite(5);

    final preferences = await SharedPreferences.getInstance();

    final savedFavorites =
        preferences.getStringList('favorite_products');

    expect(savedFavorites, isNotNull);
    expect(savedFavorites, contains('5'));
  });

  // ==========================================
  // TEST 7 : CHARGER LES FAVORIS SAUVEGARDÉS
  // ==========================================

  test('les favoris sauvegardés sont récupérés au chargement', () async {
    SharedPreferences.setMockInitialValues({
      'favorite_products': ['1', '2', '5'],
    });

    final container = ProviderContainer();
    addTearDown(container.dispose);

    final favorites = await container.read(favoriteProvider.future);

    expect(favorites, containsAll([1, 2, 5]));
    expect(favorites.length, 3);
  });

  // ==========================================
  // TEST 8 : VIDER LES FAVORIS
  // ==========================================

  test('clearFavorites vide tous les favoris', () async {
    SharedPreferences.setMockInitialValues({
      'favorite_products': ['1', '2', '3'],
    });

    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container.read(favoriteProvider.future);

    await container
        .read(favoriteProvider.notifier)
        .clearFavorites();

    final favorites = container.read(favoriteProvider).value;

    expect(favorites, isEmpty);
  });

  // ==========================================
  // TEST 9 : clearFavorites SUPPRIME LA SAUVEGARDE
  // ==========================================

  test('clearFavorites supprime les favoris de SharedPreferences',
      () async {
    SharedPreferences.setMockInitialValues({
      'favorite_products': ['1', '2'],
    });

    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container.read(favoriteProvider.future);

    await container
        .read(favoriteProvider.notifier)
        .clearFavorites();

    final preferences = await SharedPreferences.getInstance();

    final savedFavorites =
        preferences.getStringList('favorite_products');

    expect(savedFavorites, isNull);
  });

  // ==========================================
  // TEST 10 : ÉTAT ASYNCHRONE
  // ==========================================

  test('le provider retourne un AsyncValue contenant les favoris',
      () async {
    SharedPreferences.setMockInitialValues({
      'favorite_products': ['10', '20'],
    });

    final container = ProviderContainer();
    addTearDown(container.dispose);

    final favorites = await container.read(favoriteProvider.future);

    final state = container.read(favoriteProvider);

    expect(state, isA<AsyncData<Set<int>>>());
    expect(favorites, containsAll([10, 20]));
  });
}
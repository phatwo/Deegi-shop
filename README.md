# 🛍️ DeegiShop

DeegiShop est une application e-commerce mobile développée avec Flutter et Riverpod.

L'application permet de consulter des produits, rechercher et filtrer le catalogue, gérer ses favoris et gérer un panier d'achat.

## ✨ Fonctionnalités

- 🛍️ Catalogue de produits
- 🔎 Recherche de produits
- 🏷️ Filtrage par catégorie
- ↕️ Tri par prix et par note
- 📦 Détail des produits
- ❤️ Système de favoris
- 💾 Favoris persistés localement
- 🛒 Panier d'achat
- ➕ Augmentation de la quantité
- ➖ Diminution de la quantité
- 🗑️ Suppression des produits
- 🧹 Possibilité de vider le panier
- 💾 Panier persisté localement
- 💰 Calcul automatique du total
- 👤 Profil utilisateur mock
- ⏳ Gestion des états de chargement
- ⚠️ Gestion des erreurs

## 🛠️ Technologies

- Flutter
- Dart
- Riverpod
- SharedPreferences
- Material 3

## 🏗️ Architecture

Le projet sépare les données, la logique métier et l'interface utilisateur.

```text
lib/
│
├── data/
│   ├── datasources/
│   │   └── product_datasource.dart
│   │
│   ├── models/
│   │   ├── product.dart
│   │   └── cart_item.dart
│   │
│   └── repositories/
│       └── product_repository.dart
│
├── providers/
│   ├── product_provider.dart
│   ├── cart_provider.dart
│   └── favorite_provider.dart
│
└── features/
    ├── home/
    ├── products/
    ├── favorites/
    ├── cart/
    └── profile/
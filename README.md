# 🛍️ DeegiShop

**DeegiShop** est une application e-commerce mobile développée avec **Flutter** et **Dart**. Elle permet de découvrir des produits, gérer ses favoris et son panier, et consulter son profil à travers une interface moderne et adaptée aux appareils mobiles.

![Flutter](https://img.shields.io/badge/Flutter-3.44.8-02569B?logo=flutter\&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.12.2-0175C2?logo=dart\&logoColor=white)
![Riverpod](https://img.shields.io/badge/State%20Management-Riverpod-00B4AB)
![Tests](https://img.shields.io/badge/Tests-Flutter%20Test-success)
![CI](https://github.com/TON-USERNAME/deegi_shop/actions/workflows/flutter.yml/badge.svg)

---

## 📱 Fonctionnalités

* 🏠 Accueil avec présentation des produits
* 🛍️ Catalogue de produits
* 🔎 Recherche et filtrage des produits
* ❤️ Gestion des favoris
* 🛒 Ajout et suppression des produits du panier
* ➕ Gestion des quantités dans le panier
* 👤 Profil utilisateur
* 🌍 Internationalisation français / anglais
* ♿ Éléments d'accessibilité avec `Semantics`
* 💾 Persistance locale des données
* 🧪 Tests unitaires et tests de widgets
* ⚙️ Intégration continue avec GitHub Actions

---

## 🏗️ Architecture

Le projet utilise une architecture organisée par fonctionnalités (*feature-based architecture*), avec une séparation claire des responsabilités.

```text
lib/
├── core/
│   └── ...
│
├── features/
│   ├── home/
│   │   ├── home_screen.dart
│   │   └── ...
│   │
│   ├── products/
│   │   ├── product_list_screen.dart
│   │   └── ...
│   │
│   ├── cart/
│   │   ├── cart_screen.dart
│   │   └── ...
│   │
│   ├── favorites/
│   │   ├── favorites_screen.dart
│   │   └── ...
│   │
│   └── profile/
│       ├── profile_screen.dart
│       └── ...
│
├── l10n/
│   ├── app_fr.arb
│   ├── app_en.arb
│   └── app_localizations.dart
│
└── main.dart
```

### Gestion d'état

La gestion d'état est réalisée avec **Riverpod**.

Elle permet notamment de gérer :

* le panier ;
* les favoris ;
* les données produits ;
* les états asynchrones ;
* la communication entre les différentes parties de l'application.

### Internationalisation

L'application utilise le système de localisation de Flutter avec des fichiers `.arb`.

Langues disponibles :

* 🇫🇷 Français
* 🇬🇧 Anglais

---

## 🚀 Installation

### Prérequis

Avant de commencer, installer :

* Flutter
* Dart
* Git
* Un appareil Android ou un émulateur

Vérifier l'installation :

```bash
flutter doctor
```

### Cloner le projet

```bash
git clone https://github.com/phatwo/deegi_shop.git
cd deegi_shop
```

### Installer les dépendances

```bash
flutter pub get
```

### Générer les fichiers de localisation

```bash
flutter gen-l10n
```

### Vérifier le projet

```bash
flutter analyze
```

### Lancer les tests

```bash
flutter test
```

### Lancer l'application

```bash
flutter run
```

---

## 🧪 Tests

Le projet contient plusieurs niveaux de tests :

```bash
flutter test
```

Pour analyser le code :

```bash
flutter analyze
```

L'objectif est de maintenir :

* ✅ une analyse Flutter sans erreur ;
* ✅ des tests automatisés fonctionnels ;
* ✅ une CI exécutée automatiquement à chaque modification du dépôt.

---

## ⚙️ Continuous Integration

Le projet utilise **GitHub Actions** pour automatiser les vérifications.

Le workflow vérifie notamment :

```text
Push / Pull Request
        ↓
Flutter setup
        ↓
Installation des dépendances
        ↓
flutter analyze
        ↓
flutter test
        ↓
Résultat CI
```

Le statut du workflow est affiché par le badge CI présent en haut de ce README.

> ⚠️ Remplace `phatwo` dans le badge par ton véritable nom d'utilisateur GitHub.

---

## 📸 Captures d'écran

### 🏠 Accueil

Ajoute ici une capture de l'écran d'accueil :

```text
docs/screenshots/home.png
```

### 🛍️ Produits

```text
docs/screenshots/products.png
```

### ❤️ Favoris

```text
docs/screenshots/favorites.png
```

### 🛒 Panier

```text
docs/screenshots/cart.png
```

### 👤 Profil

```text
docs/screenshots/profile.png
```

Lorsque les captures seront ajoutées au dépôt, elles pourront être affichées directement avec :

```markdown
![Accueil](docs/screenshots/home.png)
```

---

## 📁 Structure du projet

```text
deegi_shop/
├── android/
├── assets/
│   └── images/
├── ios/
├── lib/
│   ├── core/
│   ├── features/
│   │   ├── home/
│   │   ├── products/
│   │   ├── cart/
│   │   ├── favorites/
│   │   └── profile/
│   ├── l10n/
│   └── main.dart
├── test/
├── integration_test/
├── .github/
│   └── workflows/
├── l10n.yaml
├── pubspec.yaml
├── CHANGELOG.md
└── README.md
```

---

## 🛠️ Technologies utilisées

| Technologie       | Utilisation              |
| ----------------- | ------------------------ |
| Flutter           | Framework mobile         |
| Dart              | Langage de programmation |
| Riverpod          | Gestion d'état           |
| SharedPreferences | Persistance locale       |
| Flutter Test      | Tests automatisés        |
| Git               | Gestion de versions      |
| GitHub Actions    | CI/CD                    |
| ARB               | Internationalisation     |

---

## 📌 État du projet

**Version actuelle : 1.2.0**

Le projet est actuellement en développement actif.

### Roadmap

* [x] Interface principale
* [x] Catalogue produits
* [x] Panier
* [x] Favoris
* [x] Profil
* [x] Internationalisation FR/EN
* [x] Tests automatisés
* [x] CI GitHub Actions
* [x] Documentation
* [ ] Finalisation du build Android
* [ ] Amélioration de la persistance
* [ ] Publication de l'application

---

## 👩🏾‍💻 Auteur

**Fatou Touré**

Projet réalisé dans le cadre d'un projet Flutter e-commerce.

---

## 📄 Licence

Ce projet est destiné à un usage éducatif et de démonstration.

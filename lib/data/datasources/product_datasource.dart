import '../models/product.dart';

class ProductDataSource {
  Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(seconds: 1));

    return const [
      // =========================
      // 👗 MODE — SACS
      // =========================

      Product(
        id: 1,
        name: 'Pouch Wax',
        description: 'Petit sac élégant avec motif wax africain.',
        price: 15000,
        image: 'assets/images/pouch.png',
        category: 'Mode',
        rating: 4.6,
      ),

      Product(
        id: 2,
        name: 'Sac à dos Wax',
        description: 'Sac à dos moderne avec une touche africaine.',
        price: 30000,
        image: 'assets/images/sacados.png',
        category: 'Mode',
        rating: 4.7,
      ),

      Product(
        id: 3,
        name: 'Sac Élégance',
        description: 'Sac chic et coloré pour vos sorties.',
        price: 35000,
        image: 'assets/images/saci.png',
        category: 'Mode',
        rating: 4.8,
      ),

      Product(
        id: 4,
        name: 'Sac Chic Wax',
        description: 'Sac tendance inspiré des motifs africains.',
        price: 40000,
        image: 'assets/images/saco.png',
        category: 'Mode',
        rating: 4.7,
      ),

      Product(
        id: 5,
        name: 'Sac de voyage Wax',
        description: 'Grand sac pratique et élégant pour vos voyages.',
        price: 50000,
        image: 'assets/images/sacvoyage.png',
        category: 'Mode',
        rating: 4.8,
      ),

      // =========================
      // 👠 MODE — CHAUSSURES
      // =========================

      Product(
        id: 6,
        name: 'Talons Wax',
        description: 'Chaussures à talons élégantes avec motif wax.',
        price: 35000,
        image: 'assets/images/heels_wax.png',
        category: 'Mode',
        rating: 4.7,
      ),

      Product(
        id: 7,
        name: 'Sandales Wax',
        description: 'Sandales légères et colorées inspirées du wax.',
        price: 25000,
        image: 'assets/images/sandals_wax.png',
        category: 'Mode',
        rating: 4.6,
      ),

      Product(
        id: 8,
        name: 'Sneakers Wax',
        description: 'Sneakers modernes avec motifs africains.',
        price: 40000,
        image: 'assets/images/sneakers_wax.png',
        category: 'Mode',
        rating: 4.8,
      ),

      // =========================
      // 📱 ÉLECTRONIQUE
      // =========================

      Product(
        id: 9,
        name: 'Appareil photo',
        description: 'Appareil photo compact pour capturer vos meilleurs moments.',
        price: 250000,
        image: 'assets/images/appareilphoto.png',
        category: 'Électronique',
        rating: 4.5,
      ),

      Product(
        id: 10,
        name: 'Casque Bluetooth',
        description: 'Casque sans fil avec une excellente qualité sonore.',
        price: 45000,
        image: 'assets/images/casque.png',
        category: 'Électronique',
        rating: 4.6,
      ),

      Product(
        id: 11,
        name: 'Montre connectée',
        description: 'Montre moderne et élégante pour suivre votre quotidien.',
        price: 55000,
        image: 'assets/images/montre.png',
        category: 'Électronique',
        rating: 4.7,
      ),
    ];
  }
}
import '../models/product.dart';

class ProductDataSource {
  Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(seconds: 1));

    return const [
      Product(
        id: 1,
        name: 'Smartphone Pro',
        description: 'Un smartphone moderne et performant.',
        price: 250000,
        image: 'assets/images/smartphone.png',
        category: 'Électronique',
        rating: 4.5,
      ),
      Product(
        id: 2,
        name: 'Casque Bluetooth',
        description: 'Casque sans fil avec une excellente qualité sonore.',
        price: 45000,
        image: 'assets/images/headphones.png',
        category: 'Électronique',
        rating: 4.3,
      ),
      Product(
        id: 3,
        name: 'Sac à main',
        description: 'Sac élégant adapté à toutes les occasions.',
        price: 35000,
        image: 'assets/images/bag.png',
        category: 'Mode',
        rating: 4.7,
      ),
      Product(
        id: 4,
        name: 'Montre élégante',
        description: 'Montre moderne avec un design élégant.',
        price: 55000,
        image: 'assets/images/watch.png',
        category: 'Mode',
        rating: 4.6,
      ),
      Product(
        id: 5,
        name: 'Chaussures sport',
        description: 'Chaussures confortables pour le sport et le quotidien.',
        price: 40000,
        image: 'assets/images/shoes.png',
        category: 'Sport',
        rating: 4.4,
      ),
    ];
  }
}
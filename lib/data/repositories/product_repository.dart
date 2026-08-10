import '../datasources/product_datasource.dart';
import '../models/product.dart';

class ProductRepository {
  final ProductDataSource dataSource;

  ProductRepository(this.dataSource);

  Future<List<Product>> getProducts() {
    return dataSource.fetchProducts();
  }
}
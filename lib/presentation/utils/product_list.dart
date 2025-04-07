import 'package:shopping/data/models/Product.dart';

class ProductList {
  static List<Product> tShirtList = [];

  static List<Product> poloShirtList = [];

  static List<Product> casualWear = [];

  // Combine T-Shirt and Polo-Shirt Lists
  static List<Product> get allProducts {
    return [...tShirtList, ...poloShirtList, ...casualWear];
  }
}

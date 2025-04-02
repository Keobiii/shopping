import 'package:shopping/data/models/Product.dart';

class ProductList {
  // static List<Product> allProducts = [

  //   // T-shirt
  //   Product(
  //     id: 1, 
  //     name: 'T-Shirt 1', 
  //     category: 't-shirt', 
  //     image: 'assets/images/t-shirt/img1.png', 
  //     description: 'Lorem Ipsum', 
  //     price: 1800.00, 
  //     quantity: 1,
  //   ),
  //   Product(
  //     id: 1, 
  //     name: 'T-Shirt 2', 
  //     category: 't-shirt', 
  //     image: 'assets/images/t-shirt/img2.png', 
  //     description: 'Lorem Ipsum', 
  //     price: 200.00, 
  //     quantity: 1,
  //   ),
  //   Product(
  //     id: 1, 
  //     name: 'T-Shirt 3', 
  //     category: 't-shirt', 
  //     image: 'assets/images/t-shirt/img3.png', 
  //     description: 'Lorem Ipsum', 
  //     price: 220.00, 
  //     quantity: 1,
  //   ),
  //   Product(
  //     id: 1, 
  //     name: 'T-Shirt 4', 
  //     category: 't-shirt', 
  //     image: 'assets/images/t-shirt/img4.png', 
  //     description: 'Lorem Ipsum', 
  //     price: 240.00, 
  //     quantity: 1,
  //   ),

  //   // Polo-Shirt
  //   Product(
  //     id: 1, 
  //     name: 'Polo-Shirt 1', 
  //     category: 'polo-shirt', 
  //     image: 'assets/images/polo-shirt/img1.png', 
  //     description: 'Lorem Ipsum', 
  //     price: 180.00, 
  //     quantity: 1,
  //   ),   
  //   Product(
  //     id: 1, 
  //     name: 'Polo-Shirt 2', 
  //     category: 'polo-shirt', 
  //     image: 'assets/images/polo-shirt/img2.png', 
  //     description: 'Lorem Ipsum', 
  //     price: 200.00, 
  //     quantity: 1,
  //   ),
  //   Product(
  //     id: 1, 
  //     name: 'Polo-Shirt 3', 
  //     category: 'polo-shirt', 
  //     image: 'assets/images/polo-shirt/img3.png', 
  //     description: 'Lorem Ipsum', 
  //     price: 220.00, 
  //     quantity: 1,
  //   ),
  //   Product(
  //     id: 1, 
  //     name: 'Polo-Shirt 4', 
  //     category: 'polo-shirt', 
  //     image: 'assets/images/polo-shirt/img4.png', 
  //     description: 'Lorem Ipsum', 
  //     price: 240.00, 
  //     quantity: 1,
  //   ), 
  // ];

  static List<Product> tShirtList = [

    // T-shirt
    Product(
      id: 1, 
      name: 'T-Shirt 1', 
      category: 't-shirt', 
      image: 'assets/images/t-shirt/img1.png', 
      description: 'Lorem Ipsum', 
      price: 100.00, 
      quantity: 1,
      totalQuantity: 10
    ),
    Product(
      id: 1, 
      name: 'T-Shirt 2', 
      category: 't-shirt', 
      image: 'assets/images/t-shirt/img2.png', 
      description: 'Lorem Ipsum', 
      price: 200.00, 
      quantity: 1,
      totalQuantity: 10
    ),
    Product(
      id: 1, 
      name: 'T-Shirt 3', 
      category: 't-shirt', 
      image: 'assets/images/t-shirt/img3.png', 
      description: 'Lorem Ipsum', 
      price: 220.00, 
      quantity: 1,
      totalQuantity: 10
    ),
    Product(
      id: 1, 
      name: 'T-Shirt 4', 
      category: 't-shirt', 
      image: 'assets/images/t-shirt/img4.png', 
      description: 'Lorem Ipsum', 
      price: 240.00, 
      quantity: 1,
      totalQuantity: 10
    ),

  ];

  static List<Product> poloShirtList = [

    // Polo-Shirt
    Product(
      id: 1, 
      name: 'Polo-Shirt 10', 
      category: 'polo-shirt', 
      image: 'assets/images/polo-shirt/img1.png', 
      description: 'Lorem Ipsum', 
      price: 100.00, 
      quantity: 1,
      totalQuantity: 10
    ),   
    Product(
      id: 1, 
      name: 'Polo-Shirt 2', 
      category: 'polo-shirt', 
      image: 'assets/images/polo-shirt/img2.png', 
      description: 'Lorem Ipsum', 
      price: 200.00, 
      quantity: 1,
      totalQuantity: 10
    ),
    Product(
      id: 1, 
      name: 'Polo-Shirt 3', 
      category: 'polo-shirt', 
      image: 'assets/images/polo-shirt/img3.png', 
      description: 'Lorem Ipsum', 
      price: 220.00, 
      quantity: 1,
      totalQuantity: 10
    ),
    Product(
      id: 1, 
      name: 'Polo-Shirt 4', 
      category: 'polo-shirt', 
      image: 'assets/images/polo-shirt/img4.png', 
      description: 'Lorem Ipsum', 
      price: 240.00, 
      quantity: 1,
      totalQuantity: 10
    ), 
  ];

  // Combine T-Shirt and Polo-Shirt Lists
  static List<Product> allProducts = [...tShirtList, ...poloShirtList];
}
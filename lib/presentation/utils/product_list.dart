import 'package:shopping/data/models/Product.dart';

class ProductList {
  static List<Product> tShirtList = [
    // T-shirt
    // Product(
    //   id: 1,
    //   name: 'T-Shirt 1',
    //   categoryId: 1,
    //   image: 'assets/images/t-shirt/img1.png',
    //   description: 'Lorem Ipsum',
    //   price: 100.00,
    //   quantity: 1,
    //   totalQuantity: 10,
    // ),
    // Product(
    //   id: 2,
    //   name: 'T-Shirt 2',
    //   categoryId: 1,
    //   image: 'assets/images/t-shirt/img2.png',
    //   description: 'Lorem Ipsum',
    //   price: 200.00,
    //   quantity: 1,
    //   totalQuantity: 10,
    // ),
    // Product(
    //   id: 3,
    //   name: 'T-Shirt 3',
    //   categoryId: 1,
    //   image: 'assets/images/t-shirt/img3.png',
    //   description: 'Lorem Ipsum',
    //   price: 220.00,
    //   quantity: 1,
    //   totalQuantity: 10,
    // ),
  ];

  static List<Product> poloShirtList = [
    // Polo-Shirt
    // Product(
    //   id: 4,
    //   name: 'Polo-Shirt 10',
    //   categoryId: 2,
    //   image: 'assets/images/polo-shirt/img1.png',
    //   description: 'Lorem Ipsum u g',
    //   price: 100.00,
    //   quantity: 1,
    //   totalQuantity: 10,
    // ),
    // Product(
    //   id: 5,
    //   name: 'Polo-Shirt 2',
    //   categoryId: 2,
    //   image: 'assets/images/polo-shirt/img2.png',
    //   description: 'Lorem Ipsum',
    //   price: 200.00,
    //   quantity: 1,
    //   totalQuantity: 10,
    // ),
    // Product(
    //   id: 6,
    //   name: 'Polo-Shirt 3',
    //   categoryId: 2,
    //   image: 'assets/images/polo-shirt/img3.png',
    //   description: 'Lorem Ipsum',
    //   price: 220.00,
    //   quantity: 1,
    //   totalQuantity: 10,
    // ),
    // Product(
    //   id: 7,
    //   name: 'Polo-Shirt 4',
    //   categoryId: 2,
    //   image: 'assets/images/polo-shirt/img4.png',
    //   description: 'Lorem Ipsum',
    //   price: 240.00,
    //   quantity: 1,
    //   totalQuantity: 10,
    // ),
    // Product(
    //   id: 8,
    //   name: 'Polo-Shirt 5',
    //   categoryId: 2,
    //   image: 'assets/images/polo-shirt/img5.png',
    //   description: 'Lorem Ipsum',
    //   price: 240.00,
    //   quantity: 1,
    //   totalQuantity: 10,
    // ),
    // Product(
    //   id: 9,
    //   name: 'Polo-Shirt 6',
    //   categoryId: 2,
    //   image: 'assets/images/polo-shirt/img6.png',
    //   description: 'Lorem Ipsum',
    //   price: 240.00,
    //   quantity: 1,
    //   totalQuantity: 10,
    // ),
    // Product(
    //   id: 10,
    //   name: 'Polo-Shirt 7',
    //   categoryId: 2,
    //   image: 'assets/images/polo-shirt/img7.png',
    //   description: 'Lorem Ipsum',
    //   price: 240.00,
    //   quantity: 1,
    //   totalQuantity: 10,
    // ),
  ];

  static List<Product> casualWear = [
    // Product(
    //   id: 11,
    //   name: "Casual 1",
    //   categoryId: 3,
    //   image: 'assets/images/casual/img1.png',
    //   description: 'Lorem Ipsum',
    //   price: 160.00,
    //   quantity: 1,
    //   totalQuantity: 10,
    // ),
    // Product(
    //   id: 12,
    //   name: "Casual 2",
    //   categoryId: 3,
    //   image: 'assets/images/casual/img2.png',
    //   description: 'Lorem Ipsum',
    //   price: 160.00,
    //   quantity: 1,
    //   totalQuantity: 10,
    // ),
    // Product(
    //   id: 13,
    //   name: "Casual 3",
    //   categoryId: 3,
    //   image: 'assets/images/casual/img3.png',
    //   description: 'Lorem Ipsum',
    //   price: 160.00,
    //   quantity: 1,
    //   totalQuantity: 10,
    // ),
  ];

  // Combine T-Shirt and Polo-Shirt Lists
  static List<Product> allProducts = [
    ...tShirtList,
    ...poloShirtList,
    ...casualWear,
  ];
}

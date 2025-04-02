class Product {
  // properties of each product
  final int id;
  final String name;
  final String category;
  final String image;
  final String description;
  final double price;
  int quantity;
  int totalQuantity;

  // constructor
  // to ensure that each product have this properties
  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.description,
    required this.price,
    required this.quantity,
    required this.totalQuantity
  });
}
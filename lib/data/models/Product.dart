class Product {
  // properties of each product
  int id;
  String name;
  int categoryId;
  String image;
  String description;
  double price;
  int quantity;
  int totalQuantity;

  // constructor
  // to ensure that each product have this properties
  Product({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.image,
    required this.description,
    required this.price,
    required this.quantity,
    required this.totalQuantity,
  });
}

enum ShoppingItem {
  p1("Oversized Shirt", 1099, 'assets/images/img1.png'),
  p2("Nylon Ripstop", 1099, 'assets/images/img1.png'),
  p3("Ripstop Nylon", 1099, 'assets/images/img1.png'),
  p4("Muli-Pocket", 1099, 'assets/images/img1.png');


  final String product_name;
  final double price;
  final String path;

  const ShoppingItem(this.product_name, this.price, this.path);
}
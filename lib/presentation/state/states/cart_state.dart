import 'package:shopping/data/models/Product.dart';

abstract class CartState {
  @override
  List<Object?> get props => [];
}

class CarrtInital extends CartState {
}

class CartLoaded extends CartState {
  final List<Product> cart;

  CartLoaded(this.cart);

  @override
  List<Object?> get props => [cart];
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}
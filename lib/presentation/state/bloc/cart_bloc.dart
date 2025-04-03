import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/data/models/Product.dart';
import 'package:shopping/presentation/state/states/cart_state.dart';

abstract class CartEvent {}

// List of the functions and their constractor
class ToggleCartEvent extends CartEvent {
  final Product product;

  ToggleCartEvent(this.product);
}

class IncrementCartQuantity extends CartEvent {
  final int index;

  IncrementCartQuantity(this.index);
}

class DecrementCartQuantity extends CartEvent {
  final int index;

  DecrementCartQuantity(this.index);
}

// class RemoveCartItemEvent extends CartEvent {
//   final int index;

//   RemoveCartItemEvent(this.index);
// }

class CheckoutEvent extends CartEvent {}

class CheckoutCompleted extends CartState {
  final List<Product> cart;

  CheckoutCompleted(this.cart);
}

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CarrtInital()) {
    // Add Item on the Cart
    on<ToggleCartEvent>((event, emit) {
      List<Product> updatedCart =
          state is CartLoaded
              ? List<Product>.from((state as CartLoaded).cart)
              : [];

      if (updatedCart.contains(event.product)) {
        for (Product element in updatedCart) {
          element.quantity++;

          // print('Quantity: ' + element.quantity.toString());

          // if (element.quantity > element.totalQuantity) {
          //   // Error
          //   emit(CartError("Quantity exceeds available stock"));

          //   return;
          // }
        }
      } else {
        updatedCart.add(event.product);
      }

      emit(CartLoaded(updatedCart));
    });

    // Increment the Item Quantity
    // plus check if the quantity is exceeds to the total quantity
    on<IncrementCartQuantity>((event, emit) {
      if (state is CartLoaded) {
        List<Product> updatedCart = List<Product>.from(
          (state as CartLoaded).cart,
        );
        updatedCart[event.index].quantity++;

        print('Quantity: ' + updatedCart[event.index].quantity.toString());

        if (updatedCart[event.index].quantity >
            updatedCart[event.index].totalQuantity) {
          emit(CartError("Quantity exceeds available stock"));

          if (updatedCart[event.index].quantity <= 1) {
            updatedCart.removeAt(event.index);
          } else {
            updatedCart[event.index].quantity--;
          }

          emit(CartLoaded(updatedCart));
          return;
        }

        emit(CartLoaded(updatedCart));
      }
    });

    // Decrement the Item Quantity
    on<DecrementCartQuantity>((event, emit) {
      if (state is CartLoaded) {
        List<Product> updatedCart = List<Product>.from(
          (state as CartLoaded).cart,
        );

        if (updatedCart[event.index].quantity <= 1) {
          updatedCart.removeAt(event.index);
        } else {
          updatedCart[event.index].quantity--;
        }

        emit(CartLoaded(updatedCart));
      }
    });

    // Removing the Item in Cart
    // on<RemoveCartItemEvent>((event, emit) {
    //   if (state is CartLoaded) {
    //     List<Product> updatedCart = List<Product>.from((state as CartLoaded).cart);
    //     updatedCart.removeAt(event.index);

    //     emit(CartLoaded(updatedCart));
    //   }
    // });

    // Checkout
    on<CheckoutEvent>((event, emit) {
      if (state is CartLoaded) {
        List<Product> updatedCart = List<Product>.from(
          (state as CartLoaded).cart,
        );

        for (Product product in updatedCart) {
          product.totalQuantity -= product.quantity;
          product.quantity = 1;
        }

        updatedCart.clear();

        emit(CartLoaded(updatedCart));
        emit(CheckoutCompleted(updatedCart));
      }
    });
  }

  double getTotalPrice() {
    if (state is CartLoaded) {
      return (state as CartLoaded).cart.fold(
        0.0,
        (total, product) => total + (product.price * product.quantity),
      );
    }

    return 0.0;
  }
}

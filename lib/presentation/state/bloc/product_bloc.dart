import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/data/models/Product.dart';
import 'package:shopping/presentation/state/states/product_state.dart';
import 'package:shopping/presentation/utils/product_list.dart';

sealed class ProductEvent {}

final class AddProductRequest extends ProductEvent {
  final Product product;

  AddProductRequest({required this.product});
}

class ProductUpdateRequest extends ProductEvent {
  final Product updatedProduct;
  ProductUpdateRequest({required this.updatedProduct});
}

class ProductDeleteRequest extends ProductEvent {
  final int id;
  ProductDeleteRequest({required this.id});
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  List<Product> products = [];
  int _nextId = 1;

  ProductBloc() : super(ProductInitial()) {
    on<AddProductRequest>((event, emit) {
      final newProduct = Product(
        id: _nextId++,
        name: event.product.name,
        categoryId: event.product.categoryId,
        image: event.product.image,
        description: event.product.description,
        price: event.product.price,
        quantity: 1,
        totalQuantity: event.product.totalQuantity,
      );

      // Categorize based on `categoryId`
      if (newProduct.categoryId == 1) {
        ProductList.tShirtList.add(newProduct);
      } else if (newProduct.categoryId == 2) {
        ProductList.poloShirtList.add(newProduct);
      } else if (newProduct.categoryId == 3) {
        ProductList.casualWear.add(newProduct);
      }

      products.add(newProduct);
      emit(ProductLoaded(product_model: products));
      print('Emit Reached');
    });

    on<ProductUpdateRequest>((event, emit) {
      print("Attempting Update for Product ID: ${event.updatedProduct.id}");
      final index = products.indexWhere((s) => s.id == event.updatedProduct.id);
      print("Index Found: $index");

      if (index != -1) {
        products[index] = event.updatedProduct;
        print("Updated Product Data: ${products[index]}");
        print("Updated Product List: $products");
        emit(ProductLoaded(product_model: List.of(products)));
      }
    });

    on<ProductDeleteRequest>((event, emit) {
      final productId = event.id;
      final initialLength = products.length;

      products.removeWhere((s) => s.id == productId);

      if (products.length < initialLength) {
        emit(ProductLoaded(product_model: List.from(products)));
      }
    });
  }
}

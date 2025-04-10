import 'package:shopping/data/models/Product.dart';

// abstract class ProductState {
//   @override
//   List<Object?> get props => [];
// }

// class ProductInital extends ProductState {}

// class ProductLoaded extends ProductState {
//   final List<Product> product;
//   final Product? selectedProduct;

//   ProductLoaded(this.product);

//   @override
//   List<Object?> get props => [product];
// }

// class ProductState {
//   final List<Product> products;
//   final Product? selectedProduct;

//   ProductState({required this.products, this.selectedProduct});
// }

// abstract class ProductFormState {}

// class ProductFormInitial extends ProductFormState {}

// class ProductFormLoaded extends ProductFormState {
//   final List<Product> products;
//   final Product? selectedProduct;
//   final bool isEditing;

//   ProductFormLoaded({
//     required this.products,
//     this.selectedProduct,
//     this.isEditing = false,
//   });

//   ProductFormLoaded copyWith({
//     List<Product>? products,
//     Product? selectedProduct,
//     bool? isEditing,
//   }) {
//     return ProductFormLoaded(
//       products: products ?? this.products,
//       selectedProduct: selectedProduct ?? this.selectedProduct,
//       isEditing: isEditing ?? this.isEditing,
//     );
//   }
// }

sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<Product> product_model;

  ProductLoaded({required this.product_model});
}

final class UpdateProductData extends ProductState {
  final Product updatedProduct;
  UpdateProductData({required this.updatedProduct});
}

final class ErrorState extends ProductState {
  final String error;

  ErrorState({required this.error});
}

final class IsLoading extends ProductState {}

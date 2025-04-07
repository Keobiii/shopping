import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/presentation/pages/product/add_product.dart';
import 'package:shopping/presentation/pages/product/edit_product.dart';
import 'package:shopping/presentation/state/bloc/product_bloc.dart';
import 'package:shopping/presentation/state/states/product_state.dart';

class ViewProduct extends StatelessWidget {
  const ViewProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Student List')),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          // if (state is DeleteStudentData) {
          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data Delete')));
          // }
        },
        builder: (context, state) {
          return Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => AddProduct()));
                },
                child: Text('Add Product'),
              ),
              // Wrapping BlocBuilder with Expanded to avoid unbounded height error
              Expanded(
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoaded) {
                      final products = state.product_model;
                      if (products.isEmpty) {
                        return Center(child: Text('No product added.'));
                      }

                      return ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '#${product.id}',
                                style: TextStyle(fontSize: 12),
                              ),
                              // Data
                              Column(
                                children: [
                                  Text(
                                    '${product.name}',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    '\$' +
                                        '${product.price} - Qty: ${product.quantity}',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder:
                                              (context) => EditProduct(
                                                productId: product.id,
                                              ),
                                        ),
                                      );
                                    },
                                    child: Text('Edit'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<ProductBloc>().add(
                                        ProductDeleteRequest(id: product.id),
                                      );
                                    },
                                    child: Text('Delete'),
                                  ),
                                ],
                              ),
                              // Actions
                            ],
                          );
                        },
                      );
                    }
                    return Center(child: Text('No product available.'));
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

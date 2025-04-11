import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/presentation/pages/product/add_product.dart';
import 'package:shopping/presentation/pages/product/edit_product.dart';
import 'package:shopping/presentation/state/bloc/product_bloc.dart';
import 'package:shopping/presentation/state/states/product_state.dart';
import 'package:shopping/presentation/utils/Palette.dart';
import 'package:shopping/presentation/widgets/appBar.dart';

class ViewProduct extends StatelessWidget {
  const ViewProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Product List"),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          // if (state is DeleteStudentData) {
          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data Delete')));
          // }
        },
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddProduct()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 252, 228, 14),
                      side: const BorderSide(color: Colors.black, width: 1),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      'Add Product',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
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
                          final isDivisible = index % 2 == 0;
                          return Container(
                            color:
                                isDivisible
                                    ? const Color.fromARGB(255, 27, 27, 36)
                                    : Colors.transparent,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Text(
                                  //   '#${product.id}',
                                  //   style: TextStyle(fontSize: 12),
                                  // ),
                                  // Data
                                  Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        // decoration: BoxDecoration(
                                        //   color: const Color.fromARGB(
                                        //     255,
                                        //     97,
                                        //     97,
                                        //     97,
                                        //   ),
                                        //   borderRadius: BorderRadius.circular(
                                        //     10,
                                        //   ),
                                        // ),
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundImage: AssetImage(
                                            product.image,
                                          ),
                                          backgroundColor: Colors.grey.shade100,
                                        ),

                                        // Image.asset(
                                        //   product.image,
                                        //   fit: BoxFit.contain,
                                        // ),
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${product.name}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            'Qty: ${product.quantity}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
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
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.yellowAccent,
                                        ),
                                        child: Text(
                                          'Edit',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          showDialog<String>(
                                            context: context,
                                            builder:
                                                (
                                                  BuildContext context,
                                                ) => AlertDialog(
                                                  title: const Text('Warning!'),
                                                  content: const Text(
                                                    'Do you want to delete this product?',
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed:
                                                          () => Navigator.pop(
                                                            context,
                                                            'Cancel',
                                                          ),
                                                      child: const Text(
                                                        'Cancel',
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        context
                                                            .read<ProductBloc>()
                                                            .add(
                                                              ProductDeleteRequest(
                                                                id: product.id,
                                                              ),
                                                            );

                                                        Navigator.pop(
                                                          context,
                                                          'Confirm',
                                                        );
                                                      },
                                                      child: const Text(
                                                        'Confirm',
                                                      ), // Updated text
                                                    ),
                                                  ],
                                                ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.redAccent,
                                        ),
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Actions
                                ],
                              ),
                            ),
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

  // Widget build(BuildContext context) {
  //   return
  // }
}

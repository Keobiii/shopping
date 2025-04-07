import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/presentation/state/bloc/product_bloc.dart';
import 'package:shopping/presentation/state/states/product_state.dart';
import 'package:shopping/presentation/utils/category.dart';
import 'package:shopping/presentation/utils/product_list.dart';
import 'package:shopping/presentation/widgets/product_category.dart';
import 'package:shopping/presentation/widgets/product_grid.dart';

class ProductsUI extends StatefulWidget {
  const ProductsUI({super.key});

  @override
  State<ProductsUI> createState() => _ProductsUIState();
}

class _ProductsUIState extends State<ProductsUI> {
  int isSelected = 0;
  final List<Map<String, dynamic>> dataList = categories;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Our Products',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15),
        // Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                dataList.map((item) {
                  return ProductCategory(
                    index: item['id'],
                    name: item['name'].toString().toUpperCase(),
                    selectedIndex: isSelected,
                    onTap: () {
                      setState(() {
                        isSelected = item['id'];
                      });
                    },
                  );
                }).toList(),
          ),
        ),
        const SizedBox(height: 20),

        // Product Grid
        // isSelected == 0
        //     ? ProductGrid(products: ProductList.allProducts)
        //     : isSelected == 1
        //     ? ProductGrid(products: ProductList.tShirtList)
        //     : isSelected == 2
        //     ? ProductGrid(products: ProductList.poloShirtList)
        //     : ProductGrid(products: ProductList.casualWear),
        Container(
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoaded) {
                final products = state.product_model;
                print("State changed! Products updated.");
                if (products.isEmpty) {
                  return Center(child: Text('No Item Added'));
                }

                // return ProductGrid(products: products);
                return isSelected == 0
                    ? ProductGrid(
                      products: state.product_model,
                    ) // Use updated Bloc state
                    : isSelected == 1
                    ? ProductGrid(
                      products:
                          state.product_model
                              .where((p) => p.categoryId == 1)
                              .toList(),
                    )
                    : isSelected == 2
                    ? ProductGrid(
                      products:
                          state.product_model
                              .where((p) => p.categoryId == 2)
                              .toList(),
                    )
                    : ProductGrid(
                      products:
                          state.product_model
                              .where((p) => p.categoryId == 3)
                              .toList(),
                    );
              }
              return Center(child: Text('No Product Available'));
            },
          ),
        ),
      ],
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/data/models/Product.dart';
import 'package:shopping/presentation/state/bloc/product_bloc.dart';
import 'package:shopping/presentation/utils/category.dart';
import 'package:shopping/presentation/utils/product_asset.dart';
import 'package:shopping/presentation/utils/product_list.dart';
import 'package:shopping/presentation/widgets/appBar.dart';
import 'package:shopping/presentation/widgets/bottom_navigation.dart';
import 'package:shopping/presentation/widgets/textfield.dart';

class EditProduct extends StatefulWidget {
  final int productId;
  const EditProduct({super.key, required this.productId});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _formKey = GlobalKey<FormState>();

  bool isEditingMode = false;

  final _editProductIDController = TextEditingController();
  final _editProductNameController = TextEditingController();
  final _editDescriptionController = TextEditingController();
  final _editQuantityController = TextEditingController();
  final _editPriceController = TextEditingController();

  // Dropdown items for categories
  List<DropdownMenuItem<String>> get dropdownItems {
    List<Map<String, dynamic>> filteredCategories =
        categories.where((item) => item['id'] != 0).toList();

    return filteredCategories.map((item) {
      return DropdownMenuItem(
        child: Text(item['name'].toString()),
        value: item['id'].toString(),
      );
    }).toList();
  }

  String? selectedValue = null;

  @override
  Widget build(BuildContext context) {
    final productBloc = context.read<ProductBloc>();
    final productList = productBloc.products;

    final product = productList.firstWhere((s) => s.id == widget.productId);

    _editProductIDController.text = product.id.toString();
    _editProductNameController.text = product.name;
    _editDescriptionController.text = product.description;
    _editQuantityController.text = product.totalQuantity.toString();
    _editPriceController.text = product.price.toString();

    selectedValue = product.categoryId.toString();

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_EditProductForm(context)],
          ),
        ),
      ),
    );
  }

  Form _EditProductForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Update Product',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 50),

          // CustomTextFormField(
          //   controller: _editProductIDController,
          //   labelText: 'Product ID',
          //   icon: Icons.person_outline_outlined,
          //   keyboardType: TextInputType.text,
          //   validator: (value) {
          //     if (value == null || value.toString().isEmpty) {
          //       return 'Please enter some text';
          //     }
          //     return null;
          //   },
          // ),
          CustomTextFormField(
            controller: _editProductNameController,
            labelText: 'Product Name',
            icon: Icons.person_outline_outlined,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.toString().isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),

          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Category',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                ),

                validator:
                    (value) => value == null ? "Select a category" : null,
                dropdownColor: Colors.black,
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                items: dropdownItems,
                style: TextStyle(color: Colors.white),
              ),

              SizedBox(height: 20),
              CustomTextFormField(
                controller: _editDescriptionController,
                labelText: 'Description',
                icon: Icons.person_outline_outlined,
                keyboardType: TextInputType.text,
                maxLiness: null,
                validator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),
              CustomTextFormField(
                controller: _editPriceController,
                isNumber: true,
                labelText: 'Price',
                icon: Icons.person_outline_outlined,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),
              CustomTextFormField(
                controller: _editQuantityController,
                isNumber: true,
                labelText: 'Quantity',
                icon: Icons.person_outline_outlined,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 150,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final price_ = _editPriceController.text;
                            var finalPrice;

                            final quantity_ = _editQuantityController.text;
                            var finalQuan;

                            try {
                              finalPrice = double.parse(price_);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Price Error: " + e.toString()),
                                ),
                              );
                              return;
                            }

                            try {
                              finalQuan = int.parse(quantity_);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Quantity Error: " + e.toString(),
                                  ),
                                ),
                              );
                              return;
                            }

                            if (selectedValue == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Please select a category"),
                                ),
                              );
                              return;
                            }

                            int categoryId = int.parse(selectedValue!);

                            List<Product> categoryList;
                            switch (categoryId) {
                              case 1:
                                categoryList = ProductList.tShirtList;
                                break;
                              case 2:
                                categoryList = ProductList.poloShirtList;
                                break;
                              case 3:
                                categoryList = ProductList.casualWear;
                                break;
                              default:
                                throw Exception('Invalid categoryId');
                            }

                            final product = Product(
                              id: widget.productId,
                              name: _editProductNameController.text,
                              categoryId: categoryId,
                              image: 'assets/images/casual/img2.png',
                              description: _editDescriptionController.text,
                              price: finalPrice,
                              quantity: 1,
                              totalQuantity: finalQuan,
                            );

                            context.read<ProductBloc>().add(
                              ProductUpdateRequest(updatedProduct: product),
                            );

                            // Clear inputs
                            _editProductIDController.clear();
                            _editProductNameController.clear();
                            _editQuantityController.clear();
                            _editDescriptionController.clear();
                            _editPriceController.clear();
                            setState(() {
                              selectedValue = null;
                            });

                            Navigator.of(context).pop();
                          }
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFCFCFF),
                          side: const BorderSide(
                            color: Color.fromARGB(255, 160, 160, 160),
                            width: 1,
                          ),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Text(
                          'Update Product',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 30),

                    ElevatedButton(
                      onPressed: () {
                        _editProductIDController.text = "";
                        _editProductNameController.text = "";
                        _editQuantityController.text = "";
                        _editDescriptionController.text = "";
                        _editPriceController.text = "";
                        selectedValue = null;

                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 187, 187, 187),
                        side: const BorderSide(
                          color: Color.fromARGB(255, 160, 160, 160),
                          width: 1,
                        ),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

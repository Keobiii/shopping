import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/data/models/Product.dart';
import 'package:shopping/presentation/state/bloc/product_bloc.dart';
import 'package:shopping/presentation/utils/category.dart';
import 'package:shopping/presentation/utils/product_asset.dart';
import 'package:shopping/presentation/utils/product_list.dart';
import 'package:shopping/presentation/widgets/appBar.dart';
import 'package:shopping/presentation/widgets/textfield.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  bool isEditingMode = false;

  final _productIDController = TextEditingController();
  final _productNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();

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
    return Scaffold(
      appBar: const CustomAppBar(title: "Hello, Kerby!"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_addProductForm(context)],
          ),
        ),
      ),
    );
  }

  Form _addProductForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Product',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 50),

          // CustomTextFormField(
          //   controller: _productIDController,
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
            controller: _productNameController,
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
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator:
                    (value) => value == null ? "Select a category" : null,
                dropdownColor: Colors.white,
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                items: dropdownItems,
              ),

              SizedBox(height: 20),
              CustomTextFormField(
                controller: _descriptionController,
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
                controller: _priceController,
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
                controller: _quantityController,
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
                    ElevatedButton(
                      onPressed: () {
                        final price_ = _priceController.text;
                        var finalPrice;

                        final quantity_ = _quantityController.text;
                        var finalQuan;

                        try {
                          finalPrice = double.parse(price_);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Price Error: " + e.toString()),
                            ),
                          );
                        }

                        try {
                          finalQuan = int.parse(quantity_);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Quantity Error: " + e.toString()),
                            ),
                          );
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
                          id: 0,
                          name: _productNameController.text,
                          categoryId: categoryId,
                          image: 'assets/images/casual/img2.png',
                          description: _descriptionController.text,
                          price: finalPrice,
                          quantity: 1,
                          totalQuantity: finalQuan,
                        );
                        context.read<ProductBloc>().add(
                          AddProductRequest(product: product),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        elevation: 2.0,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Add Product',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        elevation: 2.0,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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

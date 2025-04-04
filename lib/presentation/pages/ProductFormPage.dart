import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopping/data/models/Product.dart';
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

  var _productId;
  var _productName;
  var _description;
  var _quantity;
  var _price;

  bool isEditingMode = false;

  final _productIDController = TextEditingController();
  final _productNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();

  void _updateUserForm() {
    setState(() {
      _productId = _productIDController.text;
      _productName = _productNameController.text;
      _description = _descriptionController.text;
      _quantity = _quantityController.text;
      _price = _priceController.text;
    });
  }

  // List<DropdownMenuItem<String>> get dropdownItems {
  //   // getting categories list except for the id = 0
  //   List<Map<String, dynamic>> filteredCategories =
  //       categories.where((item) => item['id'] != 0).toList();

  //   // Dropdown menu
  //   List<DropdownMenuItem<String>> menuItems =
  //       filteredCategories.map((item) {
  //         return DropdownMenuItem(
  //           child: Text(item['name'].toString()),
  //           value: item['id'].toString(),
  //         );
  //       }).toList();

  //   return menuItems;
  // }

  // Dynamic getter for allProducts
  List<Product> get allProducts {
    return [
      ...ProductList.tShirtList,
      ...ProductList.poloShirtList,
      ...ProductList.casualWear,
    ];
  }

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

  // final List<Product> allProducts = [
  //   ...ProductList.tShirtList,
  //   ...ProductList.poloShirtList,
  //   ...ProductList.casualWear,
  // ];

  // Variable to hold the selected product
  Product? selectedProduct;

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
            children: [_getProductData(), _addProductForm(context)],
          ),
        ),
      ),
    );
  }

  Form _getProductData() {
    return Form(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select a Product:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<Product>(
                decoration: InputDecoration(border: OutlineInputBorder()),
                hint: Text("Choose a product"),
                value: selectedProduct, // Initial value of dropdown
                onChanged: (Product? newValue) {
                  setState(() {
                    isEditingMode = true;
                    selectedProduct = newValue;

                    // Update form fields dynamically
                    _productIDController.text = newValue?.id.toString() ?? '';
                    _productNameController.text = newValue?.name ?? '';
                    _descriptionController.text = newValue?.description ?? '';
                    _priceController.text = newValue?.price.toString() ?? '';
                    _quantityController.text =
                        newValue?.totalQuantity.toString() ?? '';
                    selectedValue = newValue?.categoryId.toString() ?? '';
                  });
                },
                items:
                    allProducts.map((product) {
                      return DropdownMenuItem<Product>(
                        value: product,
                        child: Text(product.name),
                      );
                    }).toList(),
              ),
              SizedBox(height: 20),
              // Show selected product details
              // if (selectedProduct != null) ...[
              //   Text(
              //     "Product Details:",
              //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //   ),
              //   SizedBox(height: 10),
              //   Text("ID: ${selectedProduct!.id}"),
              //   Text("Name: ${selectedProduct!.name}"),
              //   Text(
              //     "Category: ${_getCategoryName(selectedProduct!.categoryId)}",
              //   ),
              //   Text("Description: ${selectedProduct!.description}"),
              //   Text("Price: ${selectedProduct!.price}"),
              //   Text("Quantity: ${selectedProduct!.quantity}"),
              //   Text("Image: ${selectedProduct!.image}"),
              // ],
            ],
          ),
        ],
      ),
    );
  }

  // get category name by ID
  String _getCategoryName(int categoryId) {
    switch (categoryId) {
      case 1:
        return "T-Shirt";
      case 2:
        return "Polo-Shirt";
      case 3:
        return "Casual Wear";
      default:
        return "Unknown";
    }
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
          isEditingMode
              ? CustomTextFormField(
                controller: _productIDController,
                labelText: 'Product ID',
                icon: Icons.person_outline_outlined,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              )
              : SizedBox(height: 0),

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
                        if (_formKey.currentState!.validate()) {
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
                                content: Text(
                                  "Quantity Error: " + e.toString(),
                                ),
                              ),
                            );
                          }

                          // categoryId based on selectedValue
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

                          // If editing an existing product, update it
                          if (isEditingMode && selectedProduct != null) {
                            selectedProduct!.name = _productNameController.text;
                            selectedProduct!.categoryId = categoryId;
                            selectedProduct!.description =
                                _descriptionController.text;
                            selectedProduct!.price = finalPrice;
                            selectedProduct!.totalQuantity = finalQuan;
                          } else {
                            String getRandomImageFromCategory(int categoryId) {
                              final random = Random();
                              List<String>? categoryAssets;

                              switch (categoryId) {
                                case 1:
                                  categoryAssets = ProductAssets.tShirtAssets;
                                  break;
                                case 2:
                                  categoryAssets =
                                      ProductAssets.poloShirtAssets;
                                  break;
                                case 3:
                                  categoryAssets = ProductAssets.casualAssets;
                                  break;
                                default:
                                  throw Exception('Invalid category ID');
                              }

                              // Randomly pick an image from the category
                              return categoryAssets[random.nextInt(
                                categoryAssets.length,
                              )];
                            }

                            // Choose a random image from category assets
                            String randomImage = getRandomImageFromCategory(
                              categoryId,
                            );

                            int index = allProducts.length;
                            Product newProduct = Product(
                              id: index + 1,
                              name: _productNameController.text,
                              categoryId: categoryId,
                              image: randomImage,
                              description: _descriptionController.text,
                              price: finalPrice,
                              quantity: 1,
                              totalQuantity: finalQuan,
                            );

                            categoryList.add(newProduct);
                          }

                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isEditingMode
                                    ? "Product updated successfully!"
                                    : "Product added successfully!",
                              ),
                            ),
                          );

                          // Clear the forms
                          _productNameController.clear();
                          _descriptionController.clear();
                          _quantityController.clear();
                          _priceController.clear();
                          setState(() {
                            selectedValue = null;
                            isEditingMode = false;
                          });
                        } else {
                          // errors
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please fill out all fields"),
                            ),
                          );
                        }
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
                            isEditingMode ? 'Update Product' : 'Add Product',
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
                      onPressed: () {
                        _productNameController.clear();
                        _descriptionController.clear();
                        _quantityController.clear();
                        _priceController.clear();
                        setState(() {
                          selectedValue = null;
                          isEditingMode = false;
                        });
                      },
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

                    isEditingMode
                        ? ElevatedButton(
                          onPressed: () {
                            // categoryId based on selectedValue
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

                            if (selectedProduct != null) {
                              categoryList.remove(selectedProduct);

                              _productNameController.clear();
                              _descriptionController.clear();
                              _quantityController.clear();
                              _priceController.clear();
                              setState(() {
                                selectedValue = null;
                                isEditingMode = false;
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Product Deleted")),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            elevation: 2.0,
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Text(
                            'Delete',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )
                        : SizedBox(height: 0),
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

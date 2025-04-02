import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopping/presentation/utils/product_list.dart';
import 'package:shopping/presentation/widgets/appBar.dart';
import 'package:shopping/presentation/widgets/product_category.dart';
import 'package:shopping/presentation/widgets/product_grid.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int isSelected = 0;
  @override
  Widget build(BuildContext context) {
   
    print('Selected index: ' + isSelected.toString());
    return Scaffold(
      appBar: const CustomAppBar(title: "Hello, Kerby!"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _searchBar(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Our Products',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  // Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // _buildProductCategory(index: 0, name: 'All Products'),
                        // _buildProductCategory(index: 1, name: 'T-Shirt'),
                        // _buildProductCategory(index: 2, name: 'Polo-Shirt'),
                        ProductCategory(
                          index: 0,
                          name: 'All Products',
                          selectedIndex: isSelected,
                          onTap: () {
                            setState(() {
                              isSelected = 0;
                            });
                          },
                        ),
                        ProductCategory(
                          index: 1,
                          name: 'T-Shirt',
                          selectedIndex: isSelected,
                          onTap: () {
                            setState(() {
                              isSelected = 1;
                            });
                          },
                        ),
                        ProductCategory(
                          index: 2,
                          name: 'Polo-Shirt',
                          selectedIndex: isSelected,
                          onTap: () {
                            setState(() {
                              isSelected = 2;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
        
                  // Product Grid
                  isSelected == 0
                      ? ProductGrid(products: ProductList.allProducts)
                      : isSelected == 1
                          ? ProductGrid(products: ProductList.tShirtList)
                          : ProductGrid(products: ProductList.poloShirtList),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


    Container _searchBar() {
    return Container(
          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xFF1d1617).withOpacity(0.11),
                blurRadius: 40,
                spreadRadius: 0.0
              )
            ]
          ),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(15),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  'assets/vectors/search.svg',
                  colorFilter: ColorFilter.mode(
                    Colors.grey,
                    BlendMode.srcIn
                  ),
                ),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  'assets/vectors/filter.svg',
                  colorFilter: ColorFilter.mode(
                    Colors.grey,
                    BlendMode.srcIn
                  ),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none
              )
            ),
          ),
        );
  }

}
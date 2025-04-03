import 'dart:async';

import 'package:shopping/presentation/pages/details/CartDetailsPage.dart';
import 'package:shopping/presentation/pages/details/ProductDetailsPage.dart';
import 'package:shopping/presentation/utils/banner_image.dart';
import 'package:shopping/presentation/utils/carousel_image.dart';
import 'package:shopping/presentation/utils/product_list.dart';
import 'package:shopping/presentation/widgets/appBar.dart';
import 'package:shopping/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopping/presentation/widgets/product_category.dart';
import 'package:shopping/presentation/widgets/product_grid.dart';

List<Widget> carouselItem =
    images
        .map(
          (bannerImage) => Container(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(bannerImage, fit: BoxFit.fill),
              ),
            ),
          ),
        )
        .toList();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int isSelected = 0;
  @override
  Widget build(BuildContext context) {
    // Controller of Page View
    // we want to achieve a automically scroll
    // inital controller and the inital value is to be set to 0 (first image)
    // final PageController _pageController = PageController(initialPage: 0);
    // int currentPage = 0;
    // late Timer timer;

    // @override
    // void initState() {
    //   super.initState();

    //   // Print statements for debugging
    //   print('Banner Image Length: ' + BannerImage.values.length.toString());
    //   print('Images List Length: ' + images.length.toString());

    //   // Initialize timer
    //   timer = Timer.periodic(const Duration(seconds: 2), (timer) {
    //     // Make sure the widget is still mounted before calling setState
    //     if (mounted) {
    //       setState(() {
    //         // Ensure currentPage doesn't exceed the index bounds
    //         if (currentPage < images.length - 1) {
    //           currentPage++;
    //         } else {
    //           currentPage = 0;
    //         }
    //         // Print the currentPage value for debugging
    //         print('Current Page: $currentPage');

    //         // Animate to the next page
    //         _pageController.animateToPage(
    //           currentPage,
    //           duration: const Duration(milliseconds: 200),
    //           curve: Curves.easeIn,
    //         );
    //       });
    //     } else {
    //       print("Timer fired but widget is no longer mounted.");
    //     }
    //   });
    // }

    // @override
    // void dispose() {
    //   // Cancel the timer when the widget is disposed
    //   timer.cancel();
    //   super.dispose();
    // }

    return Scaffold(
      appBar: const CustomAppBar(title: "Hello, Kerby!"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _caoursel(context),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Our Products',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
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
                          name: 'All',
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
            ),
          ],
        ),
      ),
    );
  }

  // _buildProductCategory({required int index, required String name}) =>
  // GestureDetector(
  //   onTap: () {
  //     setState(() {
  //       isSelected = index;
  //     });
  //   },
  //   child: Container(
  //     width: 100,
  //     height: 40,
  //     margin: const EdgeInsets.only(top: 10, right: 10),
  //     alignment: Alignment.center,
  //     decoration: BoxDecoration(
  //       color: isSelected == index ? Colors.black : Colors.transparent,
  //       borderRadius: BorderRadius.circular(50),
  //       border: Border.all(color: const Color.fromARGB(255, 90, 90, 90))
  //     ),
  //     child: Text(
  //       name,
  //       style: TextStyle(
  //         color: isSelected == index ? Colors.white : Colors.black
  //       ),
  //     ),
  //   ),
  // );

  // // All Product Grid
  // _buildAllProudcts() => GridView.builder(
  //   shrinkWrap: true, // ✅allow the grid to take space as needed
  //   physics: const NeverScrollableScrollPhysics(), // ✅ preventing grid from scolling seperate
  //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //     crossAxisCount: 2, // 2 column per row
  //     childAspectRatio: (100 / 150), // width and height ratio
  //     crossAxisSpacing: 12, // horizontal spacing
  //     mainAxisSpacing: 12, // vertical spacing
  //   ),
  //   itemCount: ProductList.allProducts.length,
  //   itemBuilder: (context, index) {
  //     final allProducts = ProductList.allProducts[index];
  //     return GestureDetector(
  //       onTap: () {
  //         Navigator.push(
  //           context, MaterialPageRoute(
  //             builder: (context) =>
  //               ProductDetailsPage(product: allProducts,),
  //           ),
  //         );
  //       },
  //       child: ProductCard(
  //         product: allProducts
  //       )
  //     );
  //   },
  // );

  // // T-Shirt Grid
  // _buildTShirtProudcts() => GridView.builder(
  //   shrinkWrap: true, // ✅allow the grid to take space as needed
  //   physics: const NeverScrollableScrollPhysics(), // ✅ preventing grid from scolling seperate
  //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //     crossAxisCount: 2, // 2 column per row
  //     childAspectRatio: (100 / 150), // width and height ratio
  //     crossAxisSpacing: 12, // horizontal spacing
  //     mainAxisSpacing: 12, // vertical spacing
  //   ),
  //   itemCount: ProductList.tShirtList.length,
  //   itemBuilder: (context, index) {
  //     final tshirtList = ProductList.tShirtList[index];
  //     return ProductCard(product: tshirtList);
  //   },
  // );

  //   // Polo-Shirt Grid
  // _buildPShirtProudcts() => GridView.builder(
  //   shrinkWrap: true, // ✅allow the grid to take space as needed
  //   physics: const NeverScrollableScrollPhysics(), // ✅ preventing grid from scolling seperate
  //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //     crossAxisCount: 2, // 2 column per row
  //     childAspectRatio: (100 / 150), // width and height ratio
  //     crossAxisSpacing: 12, // horizontal spacing
  //     mainAxisSpacing: 12, // vertical spacing
  //   ),
  //   itemCount: ProductList.poloShirtList.length,
  //   itemBuilder: (context, index) {
  //     final poloShirtList = ProductList.poloShirtList[index];
  //     return ProductCard(product: poloShirtList);
  //   },
  // );

  Container _caoursel(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      width: double.infinity,
      child: Stack(
        // children: [
        //   PageView(
        //     controller: _pageController,
        //     children: carouselItem,
        //   )
        // ],
        children: [
          PageView(
            // controller: _pageController,
            children: [
              for (var bannerItem in BannerImage.values)
                CaourselItem(bannerItem.imageAsset),
            ],
          ),
        ],
      ),
    );
  }

  Widget CaourselItem(bannerImage) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(bannerImage, fit: BoxFit.fill),
        ),
      ),
    );
  }

  // Container _searchBar() {
  //   return Container(
  //         margin: EdgeInsets.only(top: 20, left: 20, right: 20),
  //         decoration: BoxDecoration(
  //           boxShadow: [
  //             BoxShadow(
  //               color: Color(0xFF1d1617).withOpacity(0.11),
  //               blurRadius: 40,
  //               spreadRadius: 0.0
  //             )
  //           ]
  //         ),
  //         child: TextField(
  //           decoration: InputDecoration(
  //             filled: true,
  //             fillColor: Colors.white,
  //             contentPadding: EdgeInsets.all(15),
  //             prefixIcon: Padding(
  //               padding: const EdgeInsets.all(12),
  //               child: SvgPicture.asset(
  //                 'assets/vectors/search.svg',
  //                 colorFilter: ColorFilter.mode(
  //                   Colors.grey,
  //                   BlendMode.srcIn
  //                 ),
  //               ),
  //             ),
  //             suffixIcon: Padding(
  //               padding: const EdgeInsets.all(12),
  //               child: SvgPicture.asset(
  //                 'assets/vectors/filter.svg',
  //                 colorFilter: ColorFilter.mode(
  //                   Colors.grey,
  //                   BlendMode.srcIn
  //                 ),
  //               ),
  //             ),
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(15),
  //               borderSide: BorderSide.none
  //             )
  //           ),
  //         ),
  //       );
  // }

  // AppBar appBar() {
  //   return AppBar(
  //     title: Text(
  //       'Hello, Kerby!',
  //       style: TextStyle(
  //         color: Colors.black,
  //         fontSize: 18,
  //         fontWeight: FontWeight.bold
  //       ),
  //     ),
  //     backgroundColor: Colors.white,
  //     elevation: 0,
  //     centerTitle: false,
  //     actions: [
  //       GestureDetector(
  //         onTap: (){
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => const CartListPage(),
  //             )
  //           );
  //         },
  //         child: Container(
  //           margin: EdgeInsets.all(10),
  //           alignment: Alignment.center,
  //           width: 37,
  //           child: SvgPicture.asset(
  //             'assets/vectors/cart.svg',
  //             height: 20,
  //             width: 20,
  //           ),
  //           decoration: BoxDecoration(
  //             color: Color(0xFFf7f8f8),
  //             borderRadius: BorderRadius.circular(10)
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}

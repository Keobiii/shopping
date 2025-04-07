import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopping/presentation/state/bloc/product_bloc.dart';
import 'package:shopping/presentation/state/states/product_state.dart';
import 'package:shopping/presentation/utils/category.dart';
import 'package:shopping/presentation/utils/product_list.dart';
import 'package:shopping/presentation/widgets/appBar.dart';
import 'package:shopping/presentation/widgets/product_category.dart';
import 'package:shopping/presentation/widgets/product_grid.dart';
import 'package:shopping/presentation/widgets/products_ui.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int isSelected = 0;
  final List<Map<String, dynamic>> dataList = categories;
  @override
  Widget build(BuildContext context) {
    print('Selected index: ' + isSelected.toString());
    return Scaffold(
      appBar: const CustomAppBar(title: "Hello, Kerby!"),
      backgroundColor: Colors.white,
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _searchBar(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ProductsUI(),
                ),
              ],
            ),
          );
        },
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
            spreadRadius: 0.0,
          ),
        ],
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
              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              'assets/vectors/filter.svg',
              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

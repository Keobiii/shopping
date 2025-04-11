import 'dart:async';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopping/presentation/pages/details/CartDetailsPage.dart';
import 'package:shopping/presentation/pages/details/ProductDetailsPage.dart';
import 'package:shopping/presentation/utils/banner_image.dart';
import 'package:shopping/presentation/utils/carousel_image.dart';
import 'package:shopping/presentation/utils/category.dart';
import 'package:shopping/presentation/utils/product_list.dart';
import 'package:shopping/presentation/widgets/appBar.dart';
import 'package:shopping/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopping/presentation/widgets/product_category.dart';
import 'package:shopping/presentation/widgets/product_grid.dart';
import 'package:shopping/presentation/widgets/products_ui.dart';

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
  late PageController _pageController;
  Timer? _timer;
  int _currentIndex = 0;
  String? data;

  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    final _myBox = Hive.box('mybox');
    data = _myBox.get(2);

    _pageController = PageController();

    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentIndexNotifier.value < BannerImage.values.length - 1) {
        _currentIndexNotifier.value++;
      } else {
        _currentIndexNotifier.value = 0;
      }

      _pageController.animateToPage(
        _currentIndexNotifier.value,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  int isSelected = 0;
  final List<Map<String, dynamic>> dataList = categories;
  @override
  Widget build(BuildContext context) {
    print('Hive Data: $data');
    return Scaffold(
      appBar: const CustomAppBar(title: "Hello, Kerby!"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _carousel(context),
            Padding(padding: const EdgeInsets.all(20.0), child: ProductsUI()),
          ],
        ),
      ),
    );
  }

  Container _carousel(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      width: double.infinity,
      child: ValueListenableBuilder<int>(
        valueListenable: _currentIndexNotifier,
        builder: (context, currentIndex, child) {
          return PageView(
            controller: _pageController,
            onPageChanged: (index) {
              _currentIndexNotifier.value = index;
            },
            children: [
              for (var bannerItem in BannerImage.values)
                CaourselItem(bannerItem.imageAsset),
            ],
          );
        },
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
}

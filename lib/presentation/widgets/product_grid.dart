import 'package:flutter/material.dart';
import 'package:shopping/presentation/pages/details/ProductDetailsPage.dart';
import 'package:shopping/presentation/widgets/product_card.dart';

class ProductGrid extends StatelessWidget {
  final List products;
  final bool isNavigable;

  ProductGrid({required this.products, this.isNavigable = true});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (100 / 140),
        crossAxisSpacing: 12,
        mainAxisSpacing: 0,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap:
              isNavigable
                  ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ProductDetailsPage(product: product),
                      ),
                    );
                  }
                  : null,
          child: ProductCard(product: product),
        );
      },
    );
  }
}

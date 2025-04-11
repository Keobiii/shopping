import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/data/models/Product.dart';
import 'package:shopping/data/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:shopping/presentation/state/bloc/cart_bloc.dart';
import 'package:shopping/presentation/state/bloc/favorite_bloc.dart';
import 'package:shopping/presentation/state/states/cart_state.dart';
import 'package:shopping/presentation/state/states/favorite_state.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    // final provider = FavoriteProvider.of(context);

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 160,
            width: 150,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 227, 227, 227),
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 150,
                  width: 130,
                  child: Image.asset(widget.product.image, fit: BoxFit.contain),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  // child: GestureDetector(
                  //       onTap: (){
                  //         provider.toggleFavorite(widget.product);
                  //       },
                  //       child: Icon(
                  //         provider.isExist(widget.product)
                  //         ? Icons.favorite
                  //         : Icons.favorite_border_outlined,
                  //         color: Colors.red,
                  //       ),
                  //     ),
                  child: BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, state) {
                      final favorites =
                          state is FavoriteLoaded ? state.favorites : [];
                      final isFavorite = favorites.contains(widget.product);

                      return Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 4,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            context.read<FavoriteBloc>().add(
                              ToggleFavoriteEvent(widget.product),
                            );
                          },
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 15),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 150,
                child: Text(
                  widget.product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 150,
                child: Text(
                  '\$'
                  '${widget.product.price}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

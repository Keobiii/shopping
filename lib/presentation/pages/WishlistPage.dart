import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/data/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shopping/presentation/pages/details/ProductDetailsPage.dart';
import 'package:shopping/presentation/state/bloc/favorite_bloc.dart';
import 'package:shopping/presentation/state/states/favorite_state.dart';
import 'package:shopping/presentation/widgets/appBar.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    // final provider  = FavoriteProvider.of(context);
    // final favoriteList = provider.favorites;
    return Scaffold(
      appBar: const CustomAppBar(title: "Hello, Kerby!"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Row(
              children: const [
                Text(
                  "WishList",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              if (state is FavoriteLoaded) {
                final favorites = state.favorites;

                if (favorites.isEmpty) {
                  return const Center(
                    child: Text(
                      'No favorites added yet.',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      final product = favorites[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Dismissible(
                          key: Key(product.id.toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (direction) {
                            // Handle the dismiss action here
                            context.read<FavoriteBloc>().add(
                              ToggleFavoriteEvent(product),
                            ); // Removes from Bloc state
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.name} removed'),
                              ),
                            );
                          },
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => ProductDetailsPage(product: favoriteList[index]),
                              //   ),
                              // );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          ProductDetailsPage(product: product),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Left: ${product.totalQuantity}',
                                overflow: TextOverflow.ellipsis,
                              ),

                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(product.image),
                                backgroundColor: Colors.grey.shade100,
                              ),
                              trailing: Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: Text(
                    'No favorites added yet.',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

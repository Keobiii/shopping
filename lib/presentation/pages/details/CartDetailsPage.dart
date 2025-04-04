import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/core/error/ErrorDialog.dart';
import 'package:shopping/data/providers/cart_provider.dart';
import 'package:shopping/data/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shopping/presentation/pages/HomePage.dart';
import 'package:shopping/presentation/state/bloc/cart_bloc.dart';
import 'package:shopping/presentation/state/states/cart_state.dart';
import 'package:shopping/presentation/widgets/bottom_navigation.dart';

class CartListPage extends StatefulWidget {
  const CartListPage({super.key});

  @override
  State<CartListPage> createState() => _CartListPageState();
}

class _CartListPageState extends State<CartListPage> {
  @override
  Widget build(BuildContext context) {
    // final provider  = CartProvider.of(context);
    // final cartList = provider.cart;

    _buildProductQuantity(IconData icon, int index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            icon == Icons.add
                ? context.read<CartBloc>().add(IncrementCartQuantity(index))
                : context.read<CartBloc>().add(DecrementCartQuantity(index));
          });
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromARGB(255, 255, 255, 255),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: Icon(icon, size: 20),
        ),
      );
    }

    // print("Cart List: " + cartList.toString());
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.white,
        elevation: 1.0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Row(
              children: [
                Text(
                  "Cart",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          BlocListener<CartBloc, CartState>(
            listener: (context, state) {
              if (state is CartError) {
                showDialog(
                  context: context,
                  builder:
                      (context) =>
                          ErrorDialog(title: "Error", message: state.message),
                );
              }
            },
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoaded) {
                  final carts = state.cart;

                  if (carts.isEmpty) {
                    return const Center(child: Text('No Item added yet.'));
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: carts.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Dismissible(
                            key: Key(carts[index].id.toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (direction) {
                              carts.removeAt(index);
                              setState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Item removed from cart'),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(
                                carts[index].name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '\$${carts[index].price}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Left: ${carts[index].totalQuantity}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(carts[index].image),
                                backgroundColor: Colors.grey.shade100,
                              ),
                              trailing: Container(
                                width: 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildProductQuantity(Icons.add, index),
                                    Text(
                                      '${carts[index].quantity}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    _buildProductQuantity(Icons.remove, index),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text('No Item added yet.'));
                }
              },
            ),
          ),
        ],
      ),

      bottomSheet: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CheckoutCompleted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigationScreen()),
              (route) => false,
            );
          }
        },
        child: BottomAppBar(
          color: Colors.white,
          child: ElevatedButton.icon(
            onPressed: () {
              context.read<CartBloc>().add(CheckoutEvent());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Thank you for buying!')),
              );
            },
            label: Text(
              '\$ ${context.read<CartBloc>().getTotalPrice().toStringAsFixed(2)} Check Out',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: Colors.black, width: 2),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

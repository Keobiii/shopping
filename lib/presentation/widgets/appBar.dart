import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopping/presentation/pages/details/CartDetailsPage.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 1.0,
      centerTitle: false,
      actions: [
        GestureDetector(
          onTap: (){
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => const CartListPage(),
              )
            );
          },
          child: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            child: SvgPicture.asset(
              'assets/vectors/cart.svg',
              height: 20,
              width: 20,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFf7f8f8),
              borderRadius: BorderRadius.circular(10)
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
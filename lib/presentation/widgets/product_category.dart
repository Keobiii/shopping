import 'package:flutter/material.dart';

class ProductCategory extends StatelessWidget {
  final int index;
  final String name;
  final int selectedIndex;
  final Function onTap;

  ProductCategory({
    required this.index,
    required this.name,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 100,
        height: 40,
        margin: const EdgeInsets.only(top: 10, right: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selectedIndex == index ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: const Color.fromARGB(255, 90, 90, 90)),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: selectedIndex == index ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

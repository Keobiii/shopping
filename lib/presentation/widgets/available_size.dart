import 'package:flutter/material.dart';

class AvailableSize extends StatelessWidget {
  final int index; 
  final String size; 
  final int selectedIndex; 
  final ValueChanged<int> onSelected; 

  const AvailableSize({
    super.key,
    required this.index,
    required this.size,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedIndex; 

    return GestureDetector(
      onTap: () {
        onSelected(index);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16.0),
        width: 40,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: const Color.fromARGB(255, 90, 90, 90)),
        ),
        child: Text(
          size,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

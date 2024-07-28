import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final List<String> iconPaths;
  final Function(int) onItemTapped;

  BottomNavBar({
    required this.selectedIndex,
    required this.iconPaths,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF5CBBE3),
              Color(0xFF02384F),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10), // Correct place for borderRadius
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(iconPaths.length, (index) {
            final bool isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () => onItemTapped(index),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF5CBBE3) : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(
                  iconPaths[index],
                  color: isSelected ? Colors.white : Colors.black,
                  width: 24.0,
                  height: 24.0,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
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
    // Get the screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.01, // 1% of screen height
        horizontal: screenWidth * 0.04, // 4% of screen width
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF5BB9AE),
              Color(0xFF5BB9AE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(screenWidth * 0.025), // 2.5% of screen width
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(iconPaths.length, (index) {
            final bool isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () => onItemTapped(index),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.012, // 1.2% of screen height
                  horizontal: screenWidth * 0.04, // 4% of screen width
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF81BEB7) :
                  Colors.transparent,
                  borderRadius: BorderRadius.circular(screenWidth * 0.025), // 2.5% of screen width
                ),
                child: SvgPicture.asset(
                  iconPaths[index],
                  color: isSelected ? Colors.white : Colors.black,
                  width: screenWidth * 0.06, // 6% of screen width
                  height: screenWidth * 0.06, // 6% of screen width
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

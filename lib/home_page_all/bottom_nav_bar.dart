import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopNavBar extends StatelessWidget {
  final int selectedIndex;
  final List<String> iconPaths;
  final Function(int) onItemTapped;

  TopNavBar({
    required this.selectedIndex,
    required this.iconPaths,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(iconPaths.length, (index) {
              final bool isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () => onItemTapped(index),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                      colors: [
                        Color(0xFF5BB9AE),
                        Color(0xFF81BEB7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                        : null,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SvgPicture.asset(
                    iconPaths[index],
                    color: isSelected ? Colors.white : Colors.black,
                    width: 24,
                    height: 24,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
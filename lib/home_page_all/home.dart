import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'page1.dart';
import 'page2.dart';
import 'page3.dart';
import 'page4.dart';
import 'bottom_nav_bar.dart';
import 'homepage.dart';
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<String> _iconPaths = [
    'assets/icons/ic1.svg',
    'assets/icons/ic2.svg',
    'assets/icons/ic11.svg',
    'assets/icons/ic4.svg',
  ];

  final List<Widget> _screens = [
    Homepage(),
    DailyContent(),
    MonthlyContent(),
    YearlyContent(),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent, // Makes the app bar transparent
          elevation: 0,
          title: Row(
            children: [
              CircleAvatar(
                child: IconButton(
                  icon: Icon(Icons.person, color: Colors.black),
                  onPressed: () {
                    // Handle icon button press
                  },
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مرحبا, يوسف',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Changa',
                    ),
                  ),
                  Text(
                    'اهلا بك',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () {
                // Handle notification button press
              },
              child: SvgPicture.asset(
                'assets/icons/ic0.svg', // Path to your SVG file
                color: Colors.black, // Set the color if needed
                width: 30.0, // Adjust size as needed
                height: 30.0,
              ),
            ),
            SizedBox(width: 16.0), // Optional spacing between icons
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: _screens,
        ),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: _selectedIndex,
          iconPaths: _iconPaths, // Pass the icon paths
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}



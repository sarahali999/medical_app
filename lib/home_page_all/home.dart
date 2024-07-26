import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'homepage.dart';
import 'page1.dart';
import 'page2.dart';
import 'page3.dart';
import 'bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  final PageController pageController = PageController();
  final List<String> iconPaths = [
    'assets/icons/ic1.svg',
    'assets/icons/ic2.svg',
    'assets/icons/ic11.svg',
    'assets/icons/ic4.svg',
  ];
  final List<Widget> screens = [
    Homepage(),
    DailyContent(),
    MonthlyContent(),
    YearlyContent(),
  ];

  void onPageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onItemTapped(int index) {
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: onPageChanged,
                children: screens,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: selectedIndex,
          iconPaths: iconPaths,
          onItemTapped: onItemTapped,
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
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
            Spacer(),
            CircleAvatar(
              radius: 20, // ضبط نصف قطر الدائرة
              backgroundColor: Colors.transparent,
              child: Container(
                width: 100,  // العرض
                height: 40,  // الطول
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF5CBBE3), Color(0xFF04384F)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: GestureDetector(
                  onTap: () {
                    // Handle notification button press
                  },
                  child: SvgPicture.asset(
                    'assets/icons/ic0.svg',
                    color: Colors.black,
                    width: 30.0,
                    height: 30.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

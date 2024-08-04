import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Notifications_Page.dart';
import 'homepage.dart';
import 'page1.dart';
import 'page2.dart';
import 'page3.dart';
import 'bottom_nav_bar.dart';
import '../languages/lang.dart';

class MainScreen extends StatefulWidget {
  final Language selectedLanguage;

  MainScreen({required this.selectedLanguage});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  final PageController pageController = PageController();
  final List<String> iconPaths = [
    'assets/icons/ic1.svg',
    'assets/icons/ic2.svg',
    'assets/icons/call.svg',
    'assets/icons/ic4.svg',
  ];

  @override
  Widget build(BuildContext context) {
    // Initialize screens inside the build method
    final List<Widget> screens = [
      Homepage(selectedLanguage: widget.selectedLanguage),
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

    // Use Directionality based on selectedLanguage
    return Directionality(
      textDirection: widget.selectedLanguage == Language.Arabic ||
          widget.selectedLanguage == Language.Persian ||
          widget.selectedLanguage == Language.Kurdish
          ? TextDirection.rtl
          : TextDirection.ltr,
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
              backgroundColor: Color(0xFF5CBBE3),
              child: IconButton(
                icon: Icon(Icons.person, color: Colors.white),
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
                  _getGreeting(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _getWelcomeMessage(),
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ],
            ),
            Spacer(),
            Transform.scale(
              scale: 1.2,
              child: Container(
                width: 45,
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFF5CBBE3),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    customBorder: CircleBorder(),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationsPage(),
                        ),
                      );
                    },
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/ic0.svg',
                        color: Colors.white,
                        width: 30.0,
                        height: 30.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getGreeting() {
    switch (widget.selectedLanguage) {
      case Language.Arabic:
        return 'مرحبا, يوسف';
      case Language.Persian:
        return 'سلام یوسف';
      case Language.Kurdish:
        return 'سڵاو یوسف';
      default:
        return 'Hello Yousuf';
    }
  }

  String _getWelcomeMessage() {
    switch (widget.selectedLanguage) {
      case Language.Arabic:
        return 'اهلا بك';
      case Language.Persian:
        return 'هی تو';
      case Language.Kurdish:
        return 'چۆنی؛سڵاوت لێبێت';
      default:
        return 'Hey, you';
    }
  }
}

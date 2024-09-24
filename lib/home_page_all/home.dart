import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Notifications_Page.dart';
import 'homepage.dart';
import 'page1.dart';
import 'page2.dart';
import 'page3.dart';
import 'bottom_nav_bar.dart';
import '../languages/lang.dart';

class ScaleRoute extends PageRouteBuilder {
  final Widget page;
  ScaleRoute({required this.page})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = 0.0;
      var end = 1.0;
      var curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );

      return ScaleTransition(
        scale: animation.drive(tween),
        child: child,
      );
    },
  );
}

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
    final List<Widget> screens = [
      Homepage(selectedLanguage: widget.selectedLanguage),
      QrCode(),
      Quicksupportnumbers(),
      UserProfile(),
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

    return Directionality(
      textDirection: widget.selectedLanguage == Language.Arabic ||
          widget.selectedLanguage == Language.Persian ||
          widget.selectedLanguage == Language.Kurdish
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        body: Column(
          children: [
            _buildAppBar(context),
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

  Widget _buildAppBar(BuildContext context) {
    // Get the screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04), // 4% of screen width
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFF5BB9AE),
              radius: screenWidth * 0.06, // 6% of screen width
              child: IconButton(
                icon: Icon(Icons.person, color: Colors.white),
                iconSize: screenWidth * 0.05, // 5% of screen width
                onPressed: () {},
              ),
            ),
            SizedBox(width: screenWidth * 0.03), // 3% of screen width
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getGreeting(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.04, // 4% of screen width
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _getWelcomeMessage(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.03, // 3% of screen width
                  ),
                ),
              ],
            ),
            Spacer(),
            Transform.scale(
              scale: 1.2,
              child: Container(
                width: screenWidth * 0.12, // 12% of screen width
                height: screenWidth * 0.12, // 12% of screen width
                decoration: BoxDecoration(
                  color: Color(0xFF5BB9AE),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: screenWidth * 0.01, // 1% of screen width
                      blurRadius: screenWidth * 0.02, // 2% of screen width
                      offset: Offset(0, screenHeight * 0.005), // 0.5% of screen height
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
                        ScaleRoute(page: Publicnotices()),
                      );
                    },
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/ic0.svg',
                        color: Colors.white,
                        width: screenWidth * 0.08, // 8% of screen width
                        height: screenWidth * 0.08, // 8% of screen width
                      ),
                    ),
                  ),
                ),
              ),
            )
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
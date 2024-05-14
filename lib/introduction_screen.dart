import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'login_reg.dart';
import 'home_page.dart';

class IntroScreen extends StatelessWidget {
  final Language selectedLanguage;

  const IntroScreen({Key? key, required this.selectedLanguage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            bodyWidget: Column(
              children: [
                Lottie.asset(
                  'assets/lottie/3.json',
                  width: 400,
                  height: 400,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: 20),
                Text(
                  "برنامجك الطبي الاول",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Darine-Regular',
                    fontSize: 20,


                    shadows: [
                      Shadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: Offset(1, 1),
                      )
                    ],
                  ),
                ),
              ],
            ),
            titleWidget: Text(
              "برنامجك الطبي الاول",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Darine-Regular',
                  fontWeight: FontWeight.bold,
                fontSize: 20,

              ),
            ),
          ),
          PageViewModel(
            bodyWidget: Column(
              children: [
                Lottie.asset(
                  'assets/lottie/4.json',
                  width: 400,
                  height: 400,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "برنامجك الطبي الاول",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Darine-Regular',
    fontWeight: FontWeight.bold,
                      fontSize: 20,

                      shadows: [
                        Shadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                          offset: Offset(1, 1),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            titleWidget: Text(
              "دليل طبي",
            style: TextStyle(
    color: Colors.black,
    fontFamily: 'Darine-Regular',
                fontWeight: FontWeight.bold,
              fontSize: 20,

            ),
            ),
          ),
          PageViewModel(
            bodyWidget: Column(
              children: [
                Lottie.asset(
                  'assets/lottie/2.json',
                  width: 400,
                  height: 400,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "برنامجك الطبي الاول",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Darine-Regular',
    fontWeight: FontWeight.bold,
                      fontSize: 20,

                      shadows: [
                        Shadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                          offset: Offset(1, 1),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            titleWidget: Text(
              "دليل طبي",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Darine-Regular',
                  fontWeight: FontWeight.bold,
                fontSize: 20,

              ),
            ),
          ),
        ],
        onDone: () {
          print("Done is clicked");
          // Navigate to the WelcomeScreen when Done is clicked
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen(selectedLanguage: selectedLanguage)),
          );
        },
        showSkipButton: true,
        showNextButton: true,
        nextFlex: 1,
        dotsFlex: 2,
        skipFlex: 1,
        animationDuration: 1000,
        curve: Curves.fastOutSlowIn,
        dotsDecorator: DotsDecorator(
          spacing: EdgeInsets.all(5),
          activeColor: Color(0xff20D5B2),
          activeSize: Size(20, 10),
          size: Size.square(10),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        skip: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF00897B),
                Color(0xFF80CBC4),
              ],
            ),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 40,
                offset: Offset(4, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              "تخطي",
              style: TextStyle(color: Colors.white, fontFamily: 'Darine-Regular', fontWeight: FontWeight.bold,fontSize: 14,
              ),
            ),
          ),
        ),
        next: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: LinearGradient(
              colors: [
                Color(0xFF00897B),
                Color(0xFF80CBC4),
              ],
            ),
          ),
          child: Center(
            child: Icon(
              Icons.navigate_next,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
        done: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF00897B),
                Color(0xFF80CBC4),
              ],
            ),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 40,
                offset: Offset(4, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              "تم",
              style: TextStyle(
              color: Colors.white,
              fontFamily: 'Darine-Regular',
                  fontWeight: FontWeight.bold,
                fontSize: 14,

              ),
            ),
          ),
        ),
      ),
    );
  }
}

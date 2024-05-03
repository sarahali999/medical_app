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
                  "Earn a kwikbuck by selling products, providing services or completing tasks",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade500, shadows: [
                    Shadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      offset: Offset(1, 1),
                    )
                  ]),
                ),
              ],
            ),
            footer: Text("this is footer"),
            titleWidget: Text(
              "this is custom title",
              style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
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
                    "Instantly connect with Buyers & Sellers near you",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade500, shadows: [
                      Shadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: Offset(1, 1),
                      )
                    ]),
                  ),
                ),
              ],
            ),
            title: "Save Time",
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
                    "Work when you want & earn what you need",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade500, shadows: [
                      Shadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: Offset(1, 1),
                      )
                    ]),
                  ),
                ),
              ],
            ),
            title: "Enjoy Freedom",
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
            color: Color(0xff20D5B2),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 10,
                offset: Offset(4, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              "Skip",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        next: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Color(0xff20D5B2), width: 2),
          ),
          child: Center(
            child: Icon(
              Icons.navigate_next,
              size: 30,
              color: Color(0xff20D5B2),
            ),
          ),
        ),
        done: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Color(0xff20D5B2),
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
              "Done",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicapp/phones/PhoneNumberInputPage.dart';
import '../LoadingScreen.dart';
import '../forms/Introductionpers.dart';
import '../languages/lang.dart';

class WelcomeScreen extends StatelessWidget {
  final Language selectedLanguage;

  const WelcomeScreen({Key? key, required this.selectedLanguage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen height
    double screenHeight = MediaQuery.of(context).size.height;

    // Define button heights as 7% of screen height
    double buttonHeight = screenHeight * 0.07;

    // Define SizedBox heights as 3% of screen height
    double sizedBoxHeight = screenHeight * 0.03;

    String loginText = '';
    String registerText = '';

    switch (selectedLanguage) {
      case Language.Arabic:
        loginText = 'تسجيل دخول';
        registerText = 'تسجيل جديد';
        break;
      case Language.English:
        loginText = 'Sign In';
        registerText = 'Sign Up';
        break;
      case Language.Persian:
        loginText = 'ورود';
        registerText = 'ثبت نام';
        break;
      case Language.Kurdish:
        loginText = 'چوونەژوورەوە';
        registerText = 'تۆمارکردن';
        break;
      case Language.Turkmen:
        loginText = 'Giriş';
        registerText = 'Hasap aç';
        break;
    }

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF5BB9AE),
        ),
        child: Column(
          children: [
            // إضافة صورة SVG هنا
            Padding(
              padding: const EdgeInsets.only(top: 175.0), // مسافة أعلى الصورة
              child: SvgPicture.asset(
                'assets/icons/phone.svg', // مسار الصورة
                height: 175, // ارتفاع الصورة
                width: 175, // عرض الصورة
              ),
            ),
            SizedBox(height: screenHeight * 0.1), // تعديل المسافة بعد الصورة
            Text(
              selectedLanguage == Language.Arabic ? 'تسجيل الزائر' :
              selectedLanguage == Language.English ? 'Visitor Registration' :
              selectedLanguage == Language.Persian ? 'ثبت نام بازدیدکننده' :
              selectedLanguage == Language.Kurdish ? 'خواردنی سەردان' :
              selectedLanguage == Language.Turkmen ? 'Çişmäniň girişi' : '',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: sizedBoxHeight),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoadingScreen(
                      onLoaded: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MyPhone(selectedLanguage: selectedLanguage)),
                        );
                      },
                    ),
                  ),
                );
              },
              child: Container(
                height: buttonHeight, // 7% of screen height
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    loginText,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontFamily: "Zain"
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: sizedBoxHeight), // 3% of screen height
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoadingScreen(
                      onLoaded: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PatientInfoIntroScreen(selectedLanguage: selectedLanguage),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              child: Container(
                height: buttonHeight, // 7% of screen height
                width: 320,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    registerText,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

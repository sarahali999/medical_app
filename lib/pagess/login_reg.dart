import 'package:flutter/material.dart';
import 'package:medicapp/phones/PhoneNumberInputPage.dart';
import '../forms/Introductionpers.dart';
import '../languages/lang.dart';

class WelcomeScreen extends StatelessWidget {
  final Language selectedLanguage;

  const WelcomeScreen({Key? key, required this.selectedLanguage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String loginText = '';
    String registerText = '';

    // Define text for each language
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
          color: Color(0xFF5CBBE3),
        ),
        child: Column(
          children: [
            const SizedBox(height: 200), // Adjusted from Padding to SizedBox
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
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPhone(selectedLanguage: selectedLanguage)),
                );
              },
              child: Container(
                height: 53,
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
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientInfoIntroScreen(selectedLanguage: selectedLanguage),
                  ),
                );
              },
              child: Container(
                height: 53,
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
            const Spacer(), // Ensures space is distributed at the bottom
          ],
        ),
      ),
    );
  }
}

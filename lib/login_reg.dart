import 'package:flutter/material.dart';
import 'package:medicapp/PhoneNumberInputPage.dart';
import 'package:medicapp/personal_info.dart';
import 'home_page.dart';

class WelcomeScreen extends StatelessWidget {
  final Language selectedLanguage;

  const WelcomeScreen({Key? key, required this.selectedLanguage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFF00897B),
                  Color(0xFF80CBC4),
                ]
            )
        ),
        child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 200.0),
              ),
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontFamily: 'Dancing Script',
                    fontSize: 50,
                    color: Colors.white
                ),
              ),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyPhone()),
                  );
                },

                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Center(
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PersonalInfoPage(selectedLanguage: selectedLanguage)),
                  );
                },
                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Center(
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ]
        ),
      ),
    );
  }
}

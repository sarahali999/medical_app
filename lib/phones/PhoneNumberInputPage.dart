import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../LoadingScreen.dart';
import '../home_page_all/home.dart';
import '../languages/lang.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyPhone extends StatefulWidget {
  final Language selectedLanguage;
  const MyPhone({Key? key, required this.selectedLanguage}) : super(key: key);
  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<String?> login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final phoneNumber = phoneController.text.trim();
    final password = passwordController.text.trim();

    if (phoneNumber.isEmpty || password.isEmpty) {
      _showMessage('Phone number and password cannot be empty.');
      return null;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://medicalpoint-api.tatwer.tech/api/Login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phoneNumber': phoneNumber,
          'password': password,
        }),
      );

      print(response);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['error'] == false) {
          final token = jsonResponse['data']['token'];
          await prefs.setString('token', token);
          return token;
        } else {
          _showMessage(jsonResponse['message']);
        }
      } else {
        _showMessage(
            'Failed to connect to the server. Code: ${response.statusCode}');
      }
    } catch (error) {
      _showMessage('An error occurred. Please try again.');
    } finally {
      setState(() {
        isLoading = false;
      });
    }

    return null;
  }

  void _showMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String verificationText = '';
    String phoneHintText = '';
    String passwordHintText = '';
    String loginButtonText = '';
    String loginInstructionText = '';

    switch (widget.selectedLanguage) {
      case Language.Arabic:
        verificationText = 'ادخل رقم الهاتف وكلمة المرور قبل البدء';
        phoneHintText = 'رقم الهاتف';
        passwordHintText = 'كلمة المرور';
        loginButtonText = 'تسجيل الدخول';
        break;
      case Language.English:
        verificationText = 'Phone Number Verification';
        phoneHintText = 'Phone Number';
        passwordHintText = 'Password';
        loginButtonText = 'Login';
        break;
      case Language.Persian:
        verificationText = 'تأیید شماره تلفن';
        phoneHintText = 'شماره تلفن';
        passwordHintText = 'کلمه عبور';
        loginButtonText = 'ورود';
        break;
      case Language.Kurdish:
        verificationText = 'پشت ژمارەی مۆبایل';
        phoneHintText = 'ژمارەی مۆبایل';
        passwordHintText = 'وشەی نهێنی';
        loginButtonText = 'چوونەژوورەوە';
        break;
      case Language.Turkmen:
        verificationText = 'Telefon belgisini tassykla';
        phoneHintText = 'Telefon belgisi';
        passwordHintText = 'Açar söz';
        loginButtonText = 'Giriş';
        break;
    }

    return Scaffold(
        body: SingleChildScrollView(
        child: Directionality( // Add Directionality here
        textDirection: widget.selectedLanguage == Language.Arabic ||
        widget.selectedLanguage == Language.Persian ||
        widget.selectedLanguage == Language.Kurdish
        ? TextDirection.rtl
            : TextDirection.ltr,
        child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
    alignment: Alignment.center,
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
    SvgPicture.asset(
    'assets/icons/ph6.svg',
    height: 150,
    width: 150,
    ),
    SizedBox(height: 40),
    Text(
    verificationText,
    style: TextStyle(
    fontSize: 22,
    color: Colors.black,
    ),
    ),
              SizedBox(height: 1),
              Text(
                loginInstructionText,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              IntlPhoneField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: phoneHintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                initialCountryCode: 'IQ',
                onChanged: (phone) {
                  // Handle phone number change
                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: passwordHintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF5BB9AE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                    final token = await login();
                    if (token != null) {
                      print('Token: $token');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LoadingScreen(
                                onLoaded: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MainScreen(
                                            selectedLanguage: widget
                                                .selectedLanguage,
                                          ),
                                    ),
                                  );
                                },
                              ),
                        ),
                      );
                    }
                  },
                  child: isLoading
                      ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : Text(
                    loginButtonText,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.05),
            ],
          ),
        ),
      ),
        )
        );

  }
}
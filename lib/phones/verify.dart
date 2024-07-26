import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../home_page_all/home.dart';
import 'PhoneNumberInputPage.dart';
import '../languages/lang.dart';
class MyVerify extends StatefulWidget {
  final Language selectedLanguage;
  const MyVerify({Key? key, required this.selectedLanguage}) : super(key: key);
  @override
  State<MyVerify> createState() => _MyVerifyState();
}
class _MyVerifyState extends State<MyVerify> {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
        fontFamily: 'Changa-VariableFont_wght',
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );


    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/o.jpeg',
                width: 300,
                height: 300,
              ),
              SizedBox(
                height: 1,
              ),
              Text(
                widget.selectedLanguage == Language.Arabic
                    ? "التحقق من رقم الهاتف"
                    : widget.selectedLanguage == Language.Persian
                    ? "تأیید شماره تلفن"
                    : widget.selectedLanguage == Language.English
                    ? "Verify Phone Number"
                    : widget.selectedLanguage == Language.Kurdish
                    ? "پشتیوانیی شمارەی تلفن"
                    : "Unsupported Language",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Changa-VariableFont_wght',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.selectedLanguage == Language.Arabic
                    ? "نحن بحاجة إلى تسجيل هاتفك دون البدء!"
                    : widget.selectedLanguage == Language.Persian
                    ? "ما باید تلفن شما را ثبت کنیم قبل از شروع!"
                    : widget.selectedLanguage == Language.English
                    ? "We need to register your phone before getting started!"
                    : widget.selectedLanguage == Language.Kurdish
                    ? "پێویستی بە رەکەوتنی موبایلەکەت پێش دەستپێدراو بنێریت!"
                    : "Unsupported Language",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Changa-VariableFont_wght',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF5CBBE3),
                    onPrimary: Color(0xFF5CBBE3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () { Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(),

                    ),
                  );},
                  child: Text(
                    widget.selectedLanguage == Language.Arabic
                        ? "دخول"
                        : widget.selectedLanguage == Language.Persian
                        ? "تأیید شماره تلفن"
                        : widget.selectedLanguage == Language.English
                        ? "Verify Phone Number"
                        : widget.selectedLanguage == Language.Kurdish
                        ? "پشتیوانیی شمارەی تلفن"
                        : "Unsupported Language",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Changa-VariableFont_wght',
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyPhone(selectedLanguage: widget.selectedLanguage),
                        ),
                      );
                    },
                    child: Text(
                      widget.selectedLanguage == Language.Arabic
                          ? "تعديل رقم الهاتف؟"
                          : widget.selectedLanguage == Language.Persian
                          ? "ویرایش شماره تلفن؟"
                          : widget.selectedLanguage == Language.English
                          ? "Edit Phone Number?"
                          : widget.selectedLanguage == Language.Kurdish
                          ? "ژمارەی تلفن بگۆڕە؟"
                          : "Unsupported Language",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Changa-VariableFont_wght',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      );
  }
}
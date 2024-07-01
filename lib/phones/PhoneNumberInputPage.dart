import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'verify.dart';
import '../languages/lang.dart';

class MyPhone extends StatefulWidget {

  final Language selectedLanguage;

  const MyPhone({Key? key, required this.selectedLanguage}) : super(key: key);

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countryController = TextEditingController();

  @override
  void initState() {
    countryController.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String verificationText = '';
    String phoneHintText = '';

    // Access selectedLanguage from the widget object
    switch (widget.selectedLanguage) {
      case Language.Arabic:
        verificationText = 'التحقق من رقم الهاتف';
        phoneHintText = 'رقم الهاتف';
        break;
      case Language.English:
        verificationText = 'Phone Number Verification';
        phoneHintText = 'Phone Number';
        break;
      case Language.Persian:
        verificationText = 'تأیید شماره تلفن';
        phoneHintText = 'شماره تلفن';
        break;
      case Language.Kurdish:
        verificationText = 'پشت ژمارەی مۆبایل';
        phoneHintText = 'ژمارەی مۆبایل';
        break;
      case Language.Turkmen:
        verificationText = 'Telefon belgisini tassykla';
        phoneHintText = 'Telefon belgisi';
        break;
    }

    return Scaffold(
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
                verificationText,
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
                    ? "نحن بحاجة إلى تسجيل هاتفك قبل البدء!"
                    : widget.selectedLanguage == Language.Persian
                    ? "ما نیاز به ثبت شماره تلفن شما داریم قبل از شروع!"
                    : widget.selectedLanguage == Language.English
                    ? "We need to register your phone before starting!"
                    : widget.selectedLanguage == Language.Kurdish
                    ? "پێویستیمان بەرەوپێشتیی ژمارەی تەلەفۆنەکەت بکەین پێش دەستپێکردن!"
                    : "",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Changa-VariableFont_wght',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              IntlPhoneField(
                decoration: InputDecoration(
                  labelText: phoneHintText,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                initialCountryCode: 'IN',
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyVerify(
                              selectedLanguage: widget.selectedLanguage)),
                    );
                  },
                  child: Text(
                    widget.selectedLanguage == Language.Arabic
                        ? "أرسل الرمز"
                        : widget.selectedLanguage == Language.Persian
                        ? "ارسال کد"
                        : widget.selectedLanguage == Language.English
                        ? "Send Code"
                        : widget.selectedLanguage == Language.Kurdish
                        ? "کۆد بنێرە"
                        : "",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Changa-VariableFont_wght',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

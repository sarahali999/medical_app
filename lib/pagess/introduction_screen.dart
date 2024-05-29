import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import '../languages/lang.dart';
import 'login_reg.dart';

class IntroScreen extends StatefulWidget {
  final Language selectedLanguage;

  const IntroScreen({Key? key, required this.selectedLanguage}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  Language selectedLanguage = Language.Arabic; // Initial language

  void _handleLanguageChange(Language language) {
    setState(() {
      selectedLanguage = language;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var textDirection = selectedLanguage == Language.Arabic ||
        selectedLanguage == Language.Persian ||
        selectedLanguage == Language.Kurdish
        ? TextDirection.rtl
        : TextDirection.ltr;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        width: 250,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF00897B),
              ),
              child: Text(
                selectedLanguage == Language.Arabic ? 'اختيار اللغة' :
                selectedLanguage == Language.English ? 'Language Selection' :
                selectedLanguage == Language.Persian ? 'انتخاب زبان' :
                selectedLanguage == Language.Kurdish ? 'هەڵبژاردنی زمان' : "",
                textDirection: widget.selectedLanguage == Language.Arabic ||
                    widget.selectedLanguage == Language.Persian ||
                    widget.selectedLanguage == Language.Kurdish
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                style: TextStyle(

                  color: Colors.white,
                  fontFamily: 'Changa-VariableFont_wght',
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('العربية'),
              onTap: () => _handleLanguageChange(Language.Arabic),
            ),
            ListTile(
              title: Text('فارسی'),
              onTap: () => _handleLanguageChange(Language.Persian),
            ),
            ListTile(
              title: Text('English'),
              onTap: () => _handleLanguageChange(Language.English),
            ),
            ListTile(
              title: Text('کوردی'),
              onTap: () => _handleLanguageChange(Language.Kurdish),
            ),
            ListTile(
              title: Text('Türkmençe'),
              onTap: () => _handleLanguageChange(Language.Turkmen),
            ),
          ],
        ),
      ),
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            bodyWidget: Column(
              children: [
                Lottie.asset(
                  'assets/lottie/3.json',
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.4,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: 50),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    selectedLanguage == Language.Arabic
                        ? "دليلك الطبي\nلكل احتياجاتك خلال الرحلة"
                        : selectedLanguage == Language.Persian
                        ? "راهنمای پزشکی شما\nبرای تمام نیازهای شما در طول سفر"
                        : selectedLanguage == Language.English
                        ? "Your Medical Guide\nFor all your needs during the journey"
                        : selectedLanguage == Language.Kurdish
                        ? "رێنمای پزیشكیتان\nبۆ هەمو خواستنەکانتان لە کاتی گەشت"
                        : "",
                    textDirection: widget.selectedLanguage == Language.Arabic ||
                        widget.selectedLanguage == Language.Persian ||
                        widget.selectedLanguage == Language.Kurdish
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Changa-VariableFont_wght',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
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
            titleWidget: Align(
              alignment: Alignment.topRight,
              child: Text(
                selectedLanguage == Language.Arabic
                    ? "برنامجك الطبي الاول"
                    : selectedLanguage == Language.Persian
                    ? "نخستین برنامه پزشکی شما"
                    : selectedLanguage == Language.English
                    ? "Your First Medical Program"
                    : selectedLanguage == Language.Kurdish
                    ? "یەکەم برنامەی پزیشکیت"
                    : "",

                textDirection: widget.selectedLanguage == Language.Arabic ||
                    widget.selectedLanguage == Language.Persian ||
                    widget.selectedLanguage == Language.Kurdish
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Changa-VariableFont_wght',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          PageViewModel(

            bodyWidget: Column(

              children: [
                Lottie.asset(
                  'assets/lottie/4.json',
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.4,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: 50),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    selectedLanguage == Language.Arabic
                        ? "دليلك الطبي\nلكل احتياجاتك خلال الرحلة"
                        : selectedLanguage == Language.Persian
                        ? "راهنمای پزشکی شما\nبرای تمام نیازهای شما در طول سفر"
                        : selectedLanguage == Language.English
                        ? "Your Medical Guide\nFor all your needs during the journey"
                        : selectedLanguage == Language.Kurdish
                        ? "رێنمای پزیشكیتان\nبۆ هەمو خواستنەکانتان لە کاتی گەشت"
                        : "",
                    textDirection: widget.selectedLanguage == Language.Arabic ||
                        widget.selectedLanguage == Language.Persian ||
                        widget.selectedLanguage == Language.Kurdish
                        ? TextDirection.rtl
                        : TextDirection.ltr,                        style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Changa-VariableFont_wght',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
            titleWidget: Align(
              alignment: Alignment.topRight,
              child: Text(
                selectedLanguage == Language.Arabic
                    ? "برنامجك الطبي الاول"
                    : selectedLanguage == Language.Persian
                    ? "نخستین برنامه پزشکی شما"
                    : selectedLanguage == Language.English
                    ? "Your First Medical Program"
                    : selectedLanguage == Language.Kurdish
                    ? "یەکەم برنامەی پزیشکیت"
                    : "",
                textDirection: widget.selectedLanguage == Language.Arabic ||
                    widget.selectedLanguage == Language.Persian ||
                    widget.selectedLanguage == Language.Kurdish
                    ? TextDirection.rtl
                    : TextDirection.ltr,                    style: TextStyle(
                color: Colors.black,
                fontFamily: 'Changa-VariableFont_wght',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
          ),
          PageViewModel(
            bodyWidget: Column(
              children: [
                Lottie.asset(
                  'assets/lottie/2.json',
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.4,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: 50),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    selectedLanguage == Language.Arabic
                        ? "دليلك الطبي\nلكل احتياجاتك خلال الرحلة"
                        : selectedLanguage == Language.Persian
                        ? "راهنمای پزشکی شما\nبرای تمام نیازهای شما در طول سفر"
                        : selectedLanguage == Language.English
                        ? "Your Medical Guide\nFor all your needs during the journey"
                        : selectedLanguage == Language.Kurdish
                        ? "رێنمای پزیشكیتان\nبۆ هەمو خواستنەکانتان لە کاتی گەشت"
                        : "",
                    textDirection: widget.selectedLanguage == Language.Arabic ||
                        widget.selectedLanguage == Language.Persian ||
                        widget.selectedLanguage == Language.Kurdish
                        ? TextDirection.rtl
                        : TextDirection.ltr,                        style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Changa-VariableFont_wght',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
            titleWidget: Align(
              alignment: Alignment.topRight,
              child: Text(
                selectedLanguage == Language.Arabic
                    ? "برنامجك الطبي الاول"
                    : selectedLanguage == Language.Persian
                    ? "نخستین برنامه پزشکی شما"
                    : selectedLanguage == Language.English
                    ? "Your First Medical Program"
                    : selectedLanguage == Language.Kurdish
                    ? "یەکەم برنامەی پزیشکیت"
                    : "",
                textDirection: widget.selectedLanguage == Language.Arabic ||
                    widget.selectedLanguage == Language.Persian ||
                    widget.selectedLanguage == Language.Kurdish
                    ? TextDirection.rtl
                    : TextDirection.ltr,                    style: TextStyle(
                color: Colors.black,
                fontFamily: 'Changa-VariableFont_wght',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
          ),
        ],
        onDone: () {
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
        skip: _buildButton(context, selectedLanguage == Language.Arabic
            ? "تخطي"
            : selectedLanguage == Language.Persian
            ? "تخطي"
            : selectedLanguage == Language.English
            ? "skip"
            : selectedLanguage == Language.Kurdish
            ? "تخطي"
            : "",
        ),
        next: _buildIconButton(context, Icons.navigate_next),
        done: _buildButton(context, selectedLanguage == Language.Arabic
            ? "تخطي"
            : selectedLanguage == Language.Persian
            ? "تخطي"
            : selectedLanguage == Language.English
            ? "skip"
            : selectedLanguage == Language.Kurdish
            ? "تخطي"
            : "",),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text) {
    return Container(
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
          text,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Changa-VariableFont_wght',
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon) {
    return Container(
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
          icon,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
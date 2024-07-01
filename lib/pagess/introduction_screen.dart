import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
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

  late Language selectedLanguage;
  final ZoomDrawerController _zoomDrawerController = ZoomDrawerController();

  @override
  void initState() {
    super.initState();
    selectedLanguage = widget.selectedLanguage;
  }

  void _handleLanguageChange(Language language) {
    setState(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => IntroScreen(selectedLanguage: language)),
      );
    });
    _zoomDrawerController.close!();
  }

  TextDirection getTextDirection() {
    return selectedLanguage == Language.Arabic ||
        selectedLanguage == Language.Persian ||
        selectedLanguage == Language.Kurdish
        ? TextDirection.rtl
        : TextDirection.ltr;
  }

  String getLocalizedText(String arabic, String persian, String english, String kurdish, String turkmen) {
    switch (selectedLanguage) {
      case Language.Arabic:
        return arabic;
      case Language.Persian:
        return persian;
      case Language.English:
        return english;
      case Language.Kurdish:
        return kurdish;
      case Language.Turkmen:
        return turkmen;
      default:
        return english;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFd9d9d9),
      child: ZoomDrawer(
        controller: _zoomDrawerController,
        menuScreen: SidebarMenu(onLanguageChange: _handleLanguageChange, selectedLanguage: selectedLanguage),
        mainScreen: _buildMainScreen(context),
        borderRadius: 24.0,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF5CBBE3),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
        showShadow: true,
        angle: -12.0,
        slideWidth: MediaQuery.of(context).size.width * 0.65,
      ),
    );
  }

  Widget _buildMainScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Tooltip(
          message: 'Translate',
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF5CBBE3),
                  Color(0xFF5CBBE3),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.translate, color: Colors.white),
              onPressed: () {
                _zoomDrawerController.toggle!();
              },
            ),
          ),
        ),
      ),
      body: IntroductionScreen(
        pages: [
          _buildPageViewModel(
            lottieAsset: 'assets/lottie/5.json',
            title: getLocalizedText(
              "برنامجك الطبي الاول",
              "نخستین برنامه پزشکی شما",
              "Your First Medical Program",
              "یەکەم برنامەی پزیشکیت",
              "",
            ),
            body: getLocalizedText(
              "دليلك الطبي\nلكل احتياجاتك خلال الرحلة",
              "راهنمای پزشکی شما\nبرای تمام نیازهای شما در طول سفر",
              "Your Medical Guide\nFor all your needs during the journey",
              "رێنمای پزیشكیتان\nبۆ هەمو خواستنەکانتان لە کاتی گەشت",
              "",
            ),
          ),
          _buildPageViewModel(
            lottieAsset: 'assets/lottie/3.json',
            title: getLocalizedText(
              "برنامجك الطبي الاول",
              "نخستین برنامه پزشکی شما",
              "Your First Medical Program",
              "یەکەم برنامەی پزیشکیت",
              "",
            ),
            body: getLocalizedText(
              "دليلك الطبي\nلكل احتياجاتك خلال الرحلة",
              "راهنمای پزشکی شما\nبرای تمام نیازهای شما در طول سفر",
              "Your Medical Guide\nFor all your needs during the journey",
              "رێنمای پزیشكیتان\nبۆ هەمو خواستنەکانتان لە کاتی گەشت",
              "",
            ),
          ),
          _buildPageViewModel(
            lottieAsset: 'assets/lottie/5.json',

            title: getLocalizedText(
              "برنامجك الطبي الاول",
              "نخستین برنامه پزشکی شما",
              "Your First Medical Program",
              "یەکەم برنامەی پزیشکیت",
              "",
            ),
            body: getLocalizedText(
              "دليلك الطبي\nلكل احتياجاتك خلال الرحلة",
              "راهنمای پزشکی شما\nبرای تمام نیازهای شما در طول سفر",
              "Your Medical Guide\nFor all your needs during the journey",
              "رێنمای پزیشكیتان\nبۆ هەمو خواستنەکانتان لە کاتی گەشت",
              "",
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
          activeColor: Color(0xFF5CBBE3),
          activeSize: Size(20, 10),
          size: Size.square(10),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        skip: _buildButton(context, getLocalizedText("تخطي", "تخطي", "Skip", "تخطي", "تخطي"), () {
          // Directly navigate to the page at index 2 (assuming 'assets/lottie/5.json' is the third page)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen(selectedLanguage: selectedLanguage)),
          );
        }),        next: _buildIconButton(context, Icons.navigate_next),
        done: _buildButton(context, getLocalizedText("تم", "تم", "Done", "تم", "تم"), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen(selectedLanguage: selectedLanguage)),
          );
        }),
      ),
    );
  }



  PageViewModel _buildPageViewModel({required String lottieAsset, required String title, required String body}) {
    return PageViewModel(
      bodyWidget: Column(
        children: [
          Lottie.asset(
            lottieAsset,
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.4,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 50),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              body,
              textDirection: selectedLanguage == Language.English ? TextDirection.ltr : TextDirection.rtl,
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      titleWidget: Align(
        alignment: Alignment.topRight,
        child: Text(
          title,
          textDirection: getTextDirection(),
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Changa-VariableFont_wght',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Function()? onPressed) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
       color:Color(0xFF5CBBE3),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 40,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Changa-VariableFont_wght',
              fontSize: 12,
            ),
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
       color:Color(0xFF5CBBE3),
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
class SidebarMenu extends StatelessWidget {
  final Function(Language) onLanguageChange;
  final Language selectedLanguage;

  SidebarMenu({required this.onLanguageChange, required this.selectedLanguage});

  String getLocalizedText(String arabic, String persian, String english, String kurdish, String turkmen) {
    switch (selectedLanguage) {
      case Language.Arabic:
        return arabic;
      case Language.Persian:
        return persian;
      case Language.English:
        return english;
      case Language.Kurdish:
        return kurdish;
      case Language.Turkmen:
        return turkmen;
      default:
        return english;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5CBBE3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                getLocalizedText(
                  'اختيار اللغة',
                  'انتخاب زبان',
                  'Language Selection',
                  'هەڵبژاردنی زمان',
                  '',
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Changa-VariableFont_wght',
                  fontSize: 24,
                ),
              ),
              Divider(height: 40, thickness: 2, color: Colors.white),
              SizedBox(height: 60),
              _buildLanguageTile(context, 'العربية', Language.Arabic),
              _buildLanguageTile(context, 'فارسی', Language.Persian),
              _buildLanguageTile(context, 'English', Language.English),
              _buildLanguageTile(context, 'کوردی', Language.Kurdish),
              _buildLanguageTile(context, 'Türkmençe', Language.Turkmen),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageTile(BuildContext context, String title, Language language) {
    Color? tileColor;

    if (language == selectedLanguage) {
      tileColor = Color(0xFF5CBBE3);
    }

    return ListTile(
      title: Container(
        height: 56,
        width: 500,
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: language == selectedLanguage ? FontWeight.bold : FontWeight.normal,
              fontFamily: 'Changa-VariableFont_wght',
            ),
          ),
        ),
      ),
      onTap: () => onLanguageChange(language),
    );
  }
}
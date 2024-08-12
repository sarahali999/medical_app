import '../languages/lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'login_reg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:showcaseview/showcaseview.dart';

class IntroScreen extends StatefulWidget {
  final Language selectedLanguage;
  const IntroScreen({Key? key, required this.selectedLanguage}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late Language selectedLanguage;
  final ZoomDrawerController _zoomDrawerController = ZoomDrawerController();
  final GlobalKey _translationIconKey = GlobalKey(); // Define the key here

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
    return Directionality(
      textDirection: getTextDirection(),
      child: Container(
        color: Color(0xFFd9d9d9),
        child: ShowCaseWidget(
          builder: (context) => ZoomDrawer(
            controller: _zoomDrawerController,
            menuScreen: SidebarMenu(
              onLanguageChange: _handleLanguageChange,
              selectedLanguage: selectedLanguage,
            ),
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
        ),
      ),
    );
  }

  Widget _buildMainScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove default shadow
        title: Tooltip(
          message: 'Translate',
          child: Showcase(
            key: _translationIconKey,
            description: 'Tap here to change the language',
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF5CBBE3),
                    Color(0xFF5CBBE3),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 2,
                    spreadRadius: 1,
                    offset: Offset(0, 2), // Change offset for floating effect
                  ),
                ],
              ),
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/tr1.svg',
                  color: Colors.white,
                  width: 20.0,
                  height: 20.0,
                ),
                onPressed: () {
                  _zoomDrawerController.toggle!();
                },
              ),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen(selectedLanguage: selectedLanguage)),
          );
        }),
        next: _buildIconButton(context, Icons.navigate_next),
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
          SizedBox(height: 20),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              body,
              textDirection: getTextDirection(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      titleWidget: Container(
        margin: EdgeInsets.only(bottom: 50),
        child: Align(
          alignment: Alignment.topRight,
          child: Text(
            title,
            textDirection: getTextDirection(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Color(0xFF5CBBE3), // Background color of CircleAvatar
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white, // Text color
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon) {
    return IconButton(
      icon: Icon(icon, color: Color(0xFF5CBBE3)),
      onPressed: () {},
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
                  fontSize: 24,
                ),
              ),
              Divider(height: 1, thickness: 2, color: Colors.white),
              SizedBox(height: 5),
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
            ),
          ),
        ),
      ),
      onTap: () => onLanguageChange(language),
    );
  }
}

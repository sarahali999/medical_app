import '../LoadingScreen.dart';
import '../languages/lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:showcaseview/showcaseview.dart';
import 'login_reg.dart';

class IntroScreen extends StatefulWidget {
  final Language selectedLanguage;
  const IntroScreen({Key? key, required this.selectedLanguage}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late Language selectedLanguage;
  late AppLocalizations localizations;
  final ZoomDrawerController _zoomDrawerController = ZoomDrawerController();
  final GlobalKey _translationIconKey = GlobalKey();
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    selectedLanguage = widget.selectedLanguage;
    localizations = AppLocalizations(selectedLanguage);
  }

  void _handleLanguageChange(Language language) {
    setState(() {
      selectedLanguage = language;
      localizations = AppLocalizations(language);
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

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: getTextDirection(),
      child: Container(
        color: Colors.white,
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
                color: Color(0xFF5BB9AE),
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Tooltip(
          message: localizations.translate,
          child: Showcase(
            key: _translationIconKey,
            description: localizations.tapToChangeLanguage,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF5BB9AE),
                    Color(0xFF5BB9AE),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 2,
                    spreadRadius: 1,
                    offset: Offset(0, 2),
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
      body: Center(
        child: IntroductionScreen(
          globalBackgroundColor: Colors.white,
          pages: [
            _buildPageViewModel(
              svgAsset: 'assets/icons/nlogg.svg',
              title: localizations.introScreenTitle1,
              body: localizations.introScreenBody1,
            ),
            _buildPageViewModel(
              svgAsset: 'assets/icons/nmap.svg',
              title: localizations.introScreenTitle2,
              body: localizations.introScreenBody2,
            ),
            _buildPageViewModel(
              svgAsset: 'assets/icons/nserv.svg',
              title: localizations.introScreenTitle3,
              body: localizations.introScreenBody3,
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
          skipOrBackFlex: 1,
          animationDuration: 1000,
          curve: Curves.fastOutSlowIn,
          dotsDecorator: DotsDecorator(
            spacing: EdgeInsets.all(5),
            activeColor: Color(0xFF5BB9AE),
            activeSize: Size(20, 10),
            size: Size.square(10),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          skip: _buildButton(context, localizations.skip, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoadingScreen(
                  onLoaded: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomeScreen(selectedLanguage: selectedLanguage),
                      ),
                    );
                  },
                ),
              ),
            );
          }),
          next: _buildIconButton(context, Icons.navigate_next),
          done: _buildButton(context, localizations.done, () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoadingScreen(onLoaded: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomeScreen(selectedLanguage: selectedLanguage),
                      ),
                    );
                  }),
                )
            );
          }),
        ),
      ),
    );
  }

  PageViewModel _buildPageViewModel({
    required String svgAsset,
    required String title,
    required String body,
  }) {
    return PageViewModel(
      decoration: PageDecoration(
        pageColor: Colors.white,
      ),
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgAsset,
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.4,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 40),
          Align(
            alignment: Alignment.center,
            child: Text(
              body,
              textDirection: getTextDirection(),
              textAlign: TextAlign.center,
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
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 50),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            textDirection: getTextDirection(),
            textAlign: TextAlign.center,
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
        backgroundColor: Color(0xFF5BB9AE),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
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
      icon: Icon(icon, color: Color(0xFF5BB9AE)),
      onPressed: () {
        if (_pageController.hasClients && _pageController.page! < 2) {
          _pageController.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }
}

class SidebarMenu extends StatelessWidget {
  final Function(Language) onLanguageChange;
  final Language selectedLanguage;

  SidebarMenu({required this.onLanguageChange, required this.selectedLanguage});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations(selectedLanguage);

    return Scaffold(
      backgroundColor: Color(0xFF5BB9AE),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.languageSelection,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Divider(height: 1, thickness: 2, color: Colors.white),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _buildLanguageTile(context, 'العربية', Language.Arabic),
                    _buildLanguageTile(context, 'فارسی', Language.Persian),
                    _buildLanguageTile(context, 'English', Language.English),
                    _buildLanguageTile(context, 'کوردی', Language.Kurdish),
                    _buildLanguageTile(context, 'Türkmençe', Language.Turkmen),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageTile(BuildContext context, String title, Language language) {
    Color? tileColor;

    if (language == selectedLanguage) {
      tileColor = Color(0xFFABC5AB);
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
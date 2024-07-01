import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

enum Language { Arabic, English, Persian, Kurdish, Turkmen }

class _LanguagePageState extends State<LanguagePage>
    with SingleTickerProviderStateMixin {
  Language? selectedLanguage = Language.Arabic; // Initial language
  late AnimationController _animationController;
  final Color primaryColor = Color(0xFF00897B);
  final Color cardColor = Color(0xFF80CBC4);
  bool isPersonalInfoLoading = false;
  bool isMapLoading = false;

  void _handleLanguageChange(Language language) {
    setState(() {
      selectedLanguage = language;
    });
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textDirection = selectedLanguage == Language.Arabic ||
        selectedLanguage == Language.Persian ||
        selectedLanguage == Language.Kurdish
        ? TextDirection.rtl
        : TextDirection.ltr;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF00897B),
        title: Text(
          selectedLanguage == Language.Arabic
              ? 'اللغات'
              : selectedLanguage == Language.English
              ? 'Languages'
              : selectedLanguage == Language.Persian
              ? 'زبان‌ها'
              : selectedLanguage == Language.Kurdish
              ? 'زمانەکان'
              : "", // Sorani for "Languages"
          textDirection: textDirection,
        ),
        leading: IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animationController.view,
          ),
          onPressed: () {
            if (_animationController.isDismissed) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
          },
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xFF00897B),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF00897B),
                ),
                child: Text(
                  selectedLanguage == Language.Arabic
                      ? 'اختيار اللغة'
                      : selectedLanguage == Language.English
                      ? 'Language Selection'
                      : selectedLanguage == Language.Persian
                      ? 'انتخاب زبان'
                      : selectedLanguage == Language.Kurdish
                      ? 'هەڵبژاردنی زمان'
                      : "",
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
      ),
    );
  }
}

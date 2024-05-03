import 'package:flutter/material.dart';

enum Language { Arabic, English, Persian, Kurdish, Turkmen }

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  Language? selectedLanguage = Language.Arabic; // Initial language
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

  void _handleDownload(String type) {
    if (type == 'personal_info') {
      setState(() {
        isPersonalInfoLoading = true;
      });
    } else if (type == 'map') {
      setState(() {
        isMapLoading = true;
      });
    }
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
          selectedLanguage == Language.Arabic ? 'اللغات' : selectedLanguage ==
              Language.English ? 'Languages' : selectedLanguage ==
              Language.Persian ? 'زبان‌ها' : selectedLanguage ==
              Language.Kurdish ? 'زمانەکان' : "", // Sorani for "Languages"
          textDirection: textDirection,
        ),
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
                // Sorani for "Language Selection"
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Cairo',
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
              title: Text('کوردی'), // Kurdish for "Kurdish"
              onTap: () => _handleLanguageChange(Language.Kurdish),
            ),
            ListTile(
              title: Text('Türkmençe'), // Turkmen for "Turkmen"
              onTap: () => _handleLanguageChange(Language.Turkmen),
            ),
          ],
        ),
      ),
    );
  }
  }
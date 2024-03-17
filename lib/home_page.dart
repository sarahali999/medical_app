import 'package:flutter/material.dart';
import 'personal_info.dart';
import 'map.dart';
import 'text_field.dart' as myTextField;

enum Language { Arabic, English, Persian, Kurdish, Turkmen }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key:key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color primaryColor = Color(0xFF00897B);
  final Color cardColor = Color(0xFF80CBC4);
  bool isPersonalInfoLoading = false;
  bool isMapLoading = false;
  Language selectedLanguage = Language.Arabic;

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
    var textDirection = selectedLanguage == Language.Arabic && selectedLanguage == Language.Persian ? TextDirection.rtl : TextDirection.ltr;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF00897B),
        title: Text(
          selectedLanguage == Language.Arabic ? 'اللغات' : selectedLanguage == Language.English ? 'Languages' :selectedLanguage == Language.Persian? 'زبان‌ها':"",
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
                selectedLanguage == Language.Arabic ? 'اختيار اللغة' : selectedLanguage == Language.English ? 'Language Selection' :selectedLanguage == Language.Persian? 'انتخاب زبان':"",
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
              title: Text('Kurdî'), // Kurdish for "Kurdish"
              onTap: () => _handleLanguageChange(Language.Kurdish),
            ),
            ListTile(
              title: Text('Türkmençe'), // Turkmen for "Turkmen"
              onTap: () => _handleLanguageChange(Language.Turkmen),
            ),
          ],
        ),
      ),
      body: isPersonalInfoLoading || isMapLoading
          ? LoadingScreen(selectedLanguage)
          : ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 30),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: selectedLanguage == Language.Arabic || selectedLanguage == Language.Persian   ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  transform: isPersonalInfoLoading
                      ? Matrix4.translationValues(-100, 0, 0)
                      : Matrix4.translationValues(0, 0, 0),
                  child: CircleAvatar(
                    radius: 35.0,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.local_hospital_rounded,
                      color: primaryColor,
                      size: 50,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  selectedLanguage == Language.Arabic ? 'دليل طبي' : selectedLanguage == Language.English ? 'Medical Guide' :selectedLanguage == Language.Persian? 'راهنمای پزشکی':"",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                Text(
                  selectedLanguage == Language.Arabic ? 'رفيقك الصحي' : selectedLanguage == Language.English ? 'Your Health Companion' :selectedLanguage == Language.Persian? 'همراه پزشکی شما':"",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 20,
                    fontFamily: 'Cairo',
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(70.0),
                  topRight: Radius.circular(70.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: selectedLanguage ==Language.Arabic || selectedLanguage == Language.Persian
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        _handleDownload('personal_info');
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return PersonalInfoPage(selectedLanguage: selectedLanguage);
                          },
                        ).then((_) {
                          setState(() {
                            isPersonalInfoLoading = false;
                          });
                        });
                      },
                      child: Card(
                        elevation: 80.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Color(0xFF80CBC4),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: selectedLanguage == Language.Arabic || selectedLanguage == Language.Persian ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.info,
                                  color: Colors.white,
                                  size: 50,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  selectedLanguage == Language.Arabic ? 'معلومات الزائر' : selectedLanguage == Language.English ? 'Personal Information' :selectedLanguage == Language.Persian? 'اطلاعات شخصی':"",
                                  style: myTextField.getGulzarTextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                if (isPersonalInfoLoading)
                                  Align(
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    InkWell(
                      onTap: () {
                        _handleDownload('map');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return MyApp();
                            },
                          ),
                        ).then((_) {
                          setState(() {
                            isMapLoading = false;
                          });
                        });
                      },
                      child: Card(
                        elevation: 80.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Colors.green,
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: selectedLanguage ==Language.Arabic || selectedLanguage == Language.Persian ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.map,
                                  color: Colors.white,
                                  size: 60,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  selectedLanguage == Language.Arabic ? 'الخريطة' : selectedLanguage == Language.English ? 'Map' :selectedLanguage == Language.Persian? 'نقشه':"",
                                  style: myTextField.getGulzarTextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                if (isMapLoading)
                                  Align(
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  final Language selectedLanguage;

  LoadingScreen(this.selectedLanguage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 20),
            Text(
              selectedLanguage == Language.Arabic ? "جاري التحميل..." : selectedLanguage == Language.English ? "Loading..." : selectedLanguage == Language.Persian?"در حال بارگذاری...":"",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

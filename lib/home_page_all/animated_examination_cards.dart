import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../languages/lang.dart';
import 'cart1.dart';
import 'cart2.dart';
import 'cart4.dart';
import 'homepage.dart';
import 'map.dart';
import 'package:medicapp/LoadingScreen.dart';

class AnimatedExaminationCards extends StatelessWidget {
  final BuildContext parentContext;
  final Language selectedLanguage;

  AnimatedExaminationCards({
    required this.parentContext,
    required this.selectedLanguage
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCard('cart1', Color(0xFF5CBBE3)),
          _buildCard('cart2', Color(0xFF8E8AEA)),
          _buildCard('map', Color(0xFF32817D)),
          _buildCard('cart4', Color(0xFF9E9E9E)),
        ],
      ),
    );
  }

  Widget _buildCard(String cardType, Color color) {
    String iconPath = _getCardIcon(cardType);
    return AnimatedExaminationCard(
      date: _getCardText(cardType, 'title'),
      title: _getCardText(cardType, 'date'),
      color: color,
      iconPath: iconPath,
      onTap: () => _navigateToExaminationDetails(parentContext, cardType),
    );
  }

  String _getCardIcon(String cardType) {
    switch (cardType) {
      case 'cart1':
        return 'assets/icons/health.svg';
      case 'cart2':
        return 'assets/icons/rep.svg';
      case 'map':
        return 'assets/icons/map.svg';
      case 'cart4':
        return 'assets/icons/info.svg';
      default:
        return 'assets/icons/info.svg';
    }
  }

  String _getCardText(String cardType, String textType) {
    Map<String, Map<String, Map<String, String>>> cardTexts = {
      'cart1': {
        'date': {
          'Arabic': 'العلاج المستمر',
          'Persian': 'درمان مداوم',
          'Kurdish': 'بەرەوپێش',
          'Turkmen': 'Daimi bej',
          'English': 'Continuous Treatment',
        },
        'title': {
          'Arabic': 'الفحوصات والادوية التي تلقاها الزائر ',
          'Persian': 'آزمون‌ها و داروهایی که بازدیدکننده دریافت کرده',
          'Kurdish': 'Test û dermanên ku serdana kiryar hatibû',
          'Turkmen': 'Gözden geçirilen we dermanlar',
          'English': 'Exams and medications received by the visitor',
        },
      },
      'cart2': {
        'date': {
          'Arabic': 'الحالة المرضية الكاملة',
          'Persian': 'وضعیت کامل پزشکی',
          'Kurdish': 'حالت پڕەی تیبەتی',
          'Turkmen': 'Dolandyryş ýagdaýy',
          'English': 'Complete Medical Condition',
        },
        'title': {
          'Arabic': 'تقريره الطبي',
          'Persian': 'گزارش پزشکی',
          'Kurdish': 'Raporê teyrana',
          'Turkmen': 'Mediki rapor',
          'English': 'Medical Report',
        },
      },
      'map': {
        'date': {
          'Arabic': 'دليلك الى المفارز الطبية',
          'Persian': 'راهنمایی به واحدهای پزشکی',
          'Kurdish': 'ڕێبەری بۆ ئەنجامی پزیشکی',
          'Turkmen': 'Baglanyşykly lukmançylyk nokatlary',
          'English': 'Guide to Medical Units',
        },
        'title': {
          'Arabic': 'الخريطة',
          'Persian': 'نقشه',
          'Kurdish': 'Nexşe',
          'Turkmen': 'Karta',
          'English': 'Map',
        },
      },
      'cart4': {
        'date': {
          'Arabic': 'الجانب الديني',
          'Persian': 'جنبه مذهبی',
          'Kurdish': 'لایەنی ئایینی',
          'Turkmen': 'Dini tarap',
          'English': 'Religious Aspect',
        },
        'title': {
          'Arabic': 'الأدعية والتسبيحات خلال المشي',
          'Persian': 'دعاها و تسبیحات هنگام راه رفتن',
          'Kurdish': 'نوێژ و ستایشەکان لە کاتی ڕۆیشتندا',
          'Turkmen': 'Ýöremek wagtynda dogalar we öwgüler',
          'English': 'Prayers and glorifications during walking',

        },
      },
    };

    String languageKey = selectedLanguage.toString().split('.').last;
    return cardTexts[cardType]?[textType]?[languageKey] ?? 'Text not found';
  }

  void _navigateToExaminationDetails(BuildContext context, String page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoadingScreen(onLoaded: () {
          _navigateToPage(context, page);
        }),
      ),
    );
  }

  void _navigateToPage(BuildContext context, String page) {
    Future.delayed(Duration(seconds: 2), () {
      Widget pageToNavigate;
      switch (page) {
        case 'cart1':
          pageToNavigate = cart1();
          break;
        case 'cart2':
          pageToNavigate = Cart2();
          break;
        case 'map':
          pageToNavigate = MapPage(selectedLanguage: selectedLanguage);
          break;
        case 'cart4':
          pageToNavigate = Cart4(selectedLanguage: selectedLanguage,);
          break;
        default:
          pageToNavigate = Homepage(selectedLanguage: Language.Arabic);
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => pageToNavigate,
        ),
      );
    });
  }
}

class AnimatedExaminationCard extends StatefulWidget {
  final String date;
  final String title;
  final Color color;
  final String iconPath;
  final VoidCallback onTap;

  AnimatedExaminationCard({
    required this.date,
    required this.title,
    required this.color,
    required this.iconPath,
    required this.onTap,
  });

  @override
  _AnimatedExaminationCardState createState() => _AnimatedExaminationCardState();
}

class _AnimatedExaminationCardState extends State<AnimatedExaminationCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1, end: 0.9).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
          widget.onTap();
        });
      },
      child: ScaleTransition(
        scale: _animation,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Container(
            height: 150,
            width: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [widget.color.withOpacity(0.7), widget.color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 50,
                    child: SvgPicture.asset(
                      widget.iconPath,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.date,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Changa-VariableFont_wght',
                          ),
                        ),
                        SizedBox(height: 4),
                        Expanded(
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                              fontFamily: 'Changa-VariableFont_wght',
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
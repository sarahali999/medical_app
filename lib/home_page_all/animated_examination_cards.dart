import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../languages/lang.dart';
import 'cart1.dart';
import 'cart2.dart';
import 'cart4.dart';
import 'homepage.dart';
import 'map.dart';
import 'package:medicapp/LoadingScreen.dart';
import 'package:latlong2/latlong.dart';


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
      height: 140,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCard('cart1'),
          _buildCard('cart2'),
          _buildCard('map'),
          _buildCard('cart4'),
        ],
      ),
    );
  }

  Widget _buildCard(String cardType) {
    String iconPath = _getCardIcon(cardType);
    return AnimatedExaminationCard(
      date: _getCardText(cardType, 'title'),
      title: _getCardText(cardType, 'date'),
      iconPath: iconPath,
      onTap: () => _navigateToExaminationDetails(parentContext, cardType),
      cardType: cardType,
      selectedLanguage: selectedLanguage,
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
          pageToNavigate = MapPage(
            selectedLanguage: selectedLanguage,
            initialLocation: LatLng(0, 0),  // Provide a default location
            locationName: "Default Location",  // Provide a default location name
          );          break;
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
  final String iconPath;
  final VoidCallback onTap;
  final String cardType;
  final Language selectedLanguage;

  AnimatedExaminationCard({
    required this.date,
    required this.title,
    required this.iconPath,
    required this.onTap,
    required this.cardType,
    required this.selectedLanguage,
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
    _animation = Tween<double>(begin: 1, end: 0.98).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  Color _getCardColor() {
    switch (widget.cardType) {
      case 'cart1':
        return Color(0xFFF5F4F0);
      case 'cart2':
        return Color(0xFFF5F4F0);
      case 'map':
        return Color(0xFFF5F4F0);
      case 'cart4':
        return Color(0xFFF5F4F0);
      default:
        return Color(0xFFF5F4F0);
    }
  }

  Color _getIconColor() {
    switch (widget.cardType) {
      case 'cart1':
        return Color(0xFF5CBBE3);
      case 'cart2':
        return Color(0xFFBCACD0);
      case 'map':
        return Color(0xFF32817D);
      case 'cart4':
        return Color(0xFFDFF19E);
      default:
        return Color(0xFFCDE9E0);
    }
  }

  Color _getTextColor() {
    return Colors.black87;
  }



  bool _isRtlLanguage(Language language) {
    return language == Language.Arabic || language == Language.Persian;
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
          elevation: 4,
          color: _getCardColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Container(
            width: 300,
            decoration: BoxDecoration(
              color: _getCardColor(),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: _isRtlLanguage(widget.selectedLanguage) ? null : -30,
                  left: _isRtlLanguage(widget.selectedLanguage) ? -30 : null,
                  bottom: -30,
                  child: SvgPicture.asset(
                    widget.iconPath,
                    width: 120,
                    height: 120,
                    color: _getIconColor(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.date,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _getTextColor(),
                          fontFamily: 'Changa-VariableFont_wght',
                        ),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 14,
                            color: _getTextColor(),
                            fontFamily: 'Changa-VariableFont_wght',
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textDirection: _isRtlLanguage(widget.selectedLanguage) ? TextDirection.rtl : TextDirection.ltr,
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
    );
  }
}

extension ColorExtension on Color {
  Color darker(int percent) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.fromARGB(
      alpha,
      (red * f).round(),
      (green * f).round(),
      (blue * f).round(),
    );
  }
}
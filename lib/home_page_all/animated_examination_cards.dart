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
      height: 140, // Increased height for more rectangular shape
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCard('map'),
          _buildCard('cart1'),
          _buildCard('cart2'),
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
    );
  }

  List<Color> _getGradientColors(int index) {
    final List<List<Color>> colorSets = [
      [Color(0xFFB5CADA),
        Color(0xFF519CDB)], // Light Blue
      [Color(0xFFE0CEE3),
        Color(0xFF815F87)], // Light Purple
      [Color(0xFFBBCDBC),
        Color(0xFF6C806C)], // Light Green
      [Color(0xFFD8D6BD),
        Color(0xFFAAA471)], // Light Yellow
    ];
    return colorSets[index % colorSets.length];
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
  final String iconPath;
  final VoidCallback onTap;
  final String cardType;

  AnimatedExaminationCard({
    required this.date,
    required this.title,
    required this.iconPath,
    required this.onTap,
    required this.cardType,
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
        return Color(0xFFE1F5FE); // Light Blue
      case 'cart2':
        return Color(0xFFF1F8E9); // Light Green
      case 'map':
        return Color(0xFFD7E3D7); // Light Orange
      case 'cart4':
        return Color(0xFFF3E5F5); // Light Purple
      default:
        return Colors.white;
    }
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _getCardColor().darker(10),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          widget.iconPath,
                          width: 24,
                          height: 24,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.date,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontFamily: 'Changa-VariableFont_wght',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontFamily: 'Changa-VariableFont_wght',
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
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

// Extension to darken colors
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
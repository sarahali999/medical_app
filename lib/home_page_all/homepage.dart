import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../languages/lang.dart';
import 'NewsDetailPage.dart';
import 'cart1.dart';
import 'cart2.dart';
import 'cart4.dart';
import 'news_model.dart';
import 'map.dart';
import 'dart:ui';

class Homepage extends StatelessWidget {
  final Language selectedLanguage;
  Homepage({required this.selectedLanguage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSpecialText(),
            AnimatedUserCard(selectedLanguage: selectedLanguage),
            AnimatedExaminationCards(
              parentContext: context,
              selectedLanguage: selectedLanguage,
            ),
            _buildSectionTitle(sectionTitle),
            AnimatedClinicNews(),
          ],
        ),
      ),
    );
  }

  String get sectionTitle {
    switch (selectedLanguage) {
      case Language.Arabic:
        return 'اخر الاخبار';
      case Language.Persian:
        return 'آخرین اخبار';
      case Language.Kurdish:
        return 'نووسینە تایبەتی';
      case Language.Turkmen:
        return 'Dernières nouvelles';
      default:
        return 'Latest News';
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

class AnimatedSpecialText extends StatefulWidget {
  @override
  _AnimatedSpecialTextState createState() => _AnimatedSpecialTextState();
}

class _AnimatedSpecialTextState extends State<AnimatedSpecialText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1, end: 1.1).animate(_controller);
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
        _controller.forward().then((_) => _controller.reverse());
      },
      child: ScaleTransition(
        scale: _animation,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              child:Text(
                "الحسين(ع) هو المنطق.. الحسين(ع) هو الطريق.. الحسين(ع) هو الانتصار",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'Amiri',
                  fontStyle: FontStyle.italic,
                  shadows: [
                    Shadow(
                      blurRadius: 8.0,
                      color: Colors.grey,
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
              )
            ),
          ),
        ),
      ),
    );
  }
}
class AnimatedExaminationCards extends StatelessWidget {
  final BuildContext parentContext;
  final Language selectedLanguage;

  AnimatedExaminationCards({required this.parentContext, required this.selectedLanguage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
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
    return AnimatedExaminationCard(
      date: _getCardText(cardType, 'title'), // Swapped 'title' here
      title: _getCardText(cardType, 'date'), // Swapped 'date' here
      color: color,
      onTap: () => _navigateToExaminationDetails(parentContext, cardType),
    );
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
          'Arabic': 'الفحوصات والادوية التي تلقاها الزائر',
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
          'Arabic': 'تقارير المريض العامة',
          'Persian': 'گزارش‌های عمومی بیمار',
          'Kurdish': 'ڕاپۆرتە گشتییەکان',
          'Turkmen': 'Hususy hasabatlar',
          'English': 'General Patient Reports',
        },
        'title': {
          'Arabic': 'تقريره العام',
          'Persian': 'گزارش کلی',
          'Kurdish': 'Raporê giştî',
          'Turkmen': 'Umumy hasabat',
          'English': 'General Report',
        },
      },


    };

    String languageKey = selectedLanguage.toString().split('.').last;
    return cardTexts[cardType]?[textType]?[languageKey] ?? 'Text not found';
  }

  void _navigateToExaminationDetails(BuildContext context, String page) {
    Widget pageToNavigate;
    switch (page) {
      case 'cart1':
        pageToNavigate = cart1();
        break;
      case 'cart2':
        pageToNavigate = cart2();
        break;
      case 'map':
        pageToNavigate = MyApp();
        break;
      case 'cart4':
        pageToNavigate = cart4();
        break;
      default:
        pageToNavigate = Homepage(selectedLanguage: Language.Arabic);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => pageToNavigate,
      ),
    );
  }
}

class AnimatedExaminationCard extends StatefulWidget {
  final String date;
  final String title;
  final Color color;
  final VoidCallback onTap;

  AnimatedExaminationCard({
    required this.date,
    required this.title,
    required this.color,
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
            height: 120,
            width: 300,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.date,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,

                      color: Colors.white,

                      fontFamily: 'Changa-VariableFont_wght',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                      fontFamily: 'Changa-VariableFont_wght',
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

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

// The rest of the code (AnimatedClinicNews, AnimatedNewsCard, AnimatedUserCard) remains unchanged
class AnimatedClinicNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: NewsService().fetchArticles(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF5CBBE3)),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'فشل في تحميل الأخبار',
              style: TextStyle(color: Colors.black,),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'لا توجد أخبار متاحة',
              style: TextStyle(color: Colors.black, ),
            ),
          );
        } else {
          return CarouselSlider(
            options: CarouselOptions(
              height: 250,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
            ),
            items: snapshot.data!.map((article) {
              return Builder(
                builder: (BuildContext context) {
                  return AnimatedNewsCard(article: article);
                },
              );
            }).toList(),
          );
        }
      },
    );
  }
}
class AnimatedNewsCard extends StatefulWidget {
  final Article article;

  AnimatedNewsCard({required this.article});

  @override
  _AnimatedNewsCardState createState() => _AnimatedNewsCardState();
}

class _AnimatedNewsCardState extends State<AnimatedNewsCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showNewsDetail(BuildContext context) {
    _controller.forward().then((_) {
      _controller.reverse();
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) => NewsDetailModal(article: widget.article, controller: scrollController),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: GestureDetector(
        onTap: () => _showNewsDetail(context),
        child: ScaleTransition(
          scale: _animation,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.article.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.white,
                        child: Icon(Icons.error, color: Colors.black),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                        ),
                      ),
                      child: Text(
                        widget.article.title,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
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

class AnimatedUserCard extends StatefulWidget {
  final Language selectedLanguage;

  AnimatedUserCard({required this.selectedLanguage});

  @override
  _AnimatedUserCardState createState() => _AnimatedUserCardState();
}

class _AnimatedUserCardState extends State<AnimatedUserCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleCard() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(_isExpanded ? _animation.value * -0.5 : 0),
            child: _buildUserCard(context),
          );
        },
      ),
    );
  }

  Widget _buildUserCard(BuildContext context) {
    Map<String, Map<String, String>> userDetails = {
      'Arabic': {
        'greeting': 'الزائر العزيز',
        'name': 'الاسم: يوسف علي',
        'number': 'الرقم: 1234567890',
        'bloodType': 'فصيلة الدم: A+',
        'address': 'العنوان: بغداد',
        'age': 'العمر: 30 years',
      },
      'Persian': {
        'greeting': 'عزیز بازدید کننده',
        'name': 'نام: یوسف علی',
        'number': 'شماره: 1234567890',
        'bloodType': 'گروه خونی: A+',
        'address': 'بغداد',
        'age': 'سن: 30 سال',
      },
      'Kurdish': {
        'greeting': 'میوانی بەخێربێ',
        'name': 'ناو: یوسف علی',
        'number': 'ژمارە: 1234567890',
        'bloodType': 'جۆری خوێن: A+',
        'address': 'بەغدا',
        'age': 'تەمەن: 30 ساڵ',
      },
      'Turkmen': {
        'greeting': 'Hormatly myhman',
        'name': 'Ady: يوسف علي',
        'number': 'Belgisi: 1234567890',
        'bloodType': 'Ganyň görnüşi: A+',
        'address': 'Bagdat',
        'age': 'Ýaşy: 30 ýyl',
      },
      'English': {
        'greeting': 'Dear Visitor',
        'name': 'Name: Yousef Ali',
        'number': 'Number: 1234567890',
        'bloodType': 'Blood Type: A+',
        'address': 'Address: Baghdad',
        'age': 'Age: 30 years',
      },
    };

    String languageKey = widget.selectedLanguage.toString().split('.').last;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF5CBBE3),
              Color(0xFF0794D2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userDetails[languageKey]!['greeting']!,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              AnimatedCrossFade(
                firstChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userDetails[languageKey]!['name']!,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      userDetails[languageKey]!['number']!,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                secondChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userDetails[languageKey]!['name']!,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      userDetails[languageKey]!['number']!,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      userDetails[languageKey]!['bloodType']!,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      userDetails[languageKey]!['address']!,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      userDetails[languageKey]!['age']!,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
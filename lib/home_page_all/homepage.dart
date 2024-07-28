import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'cart1.dart';
import 'cart2.dart';
import 'cart4.dart';
import 'news_detail_page.dart';
import 'news_model.dart';
import 'map.dart';
import 'dart:ui';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF1EE),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSpecialText(),
            AnimatedUserCard(),
            _buildExaminationCards(context),
            _buildSectionTitle('اخر الاخبار'),
            _buildClinicNews(),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialText() {
    return Center(
      child: Container(
        child: Text(
          "الحسين (ع)هوالمنطق..الحسين(ع)هوالطريق.. الحسين(ع)هوالانتصار",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontFamily: 'Amiri-BoldItalic',
            shadows: [
              Shadow(
                blurRadius: 2.0,
                color: Colors.grey,
                offset: Offset(1.0, 1.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildExaminationCards(BuildContext context) {
    return Container(
      height: 120, // Increased to accommodate the taller cards

      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildExaminationCard(
            context,
            'العلاج المستمر',
            'الفحوصات والادوية التي تلقاها الزائر',
            Color(0xFF6C80E5), // Green
                () => _navigateToExaminationDetails(context, 'cart1'),
          ),
          _buildExaminationCard(
            context,
            'الحالة المرضية الكاملة',
            'تقريره الطبي',
            Color(0xFFABA672), // Blue
                () => _navigateToExaminationDetails(context, 'cart2'),
          ),
          _buildExaminationCard(
            context,
            'دليلك الى المفارز الطبية',
            'الخريطة',
            Color(0xFF427C3C), // Red
                () => _navigateToExaminationDetails(context, 'map'),
          ),
          _buildExaminationCard(
            context,
            'تقارير المريض العامة',
            'تقرير عام',
            Color(0xFFBFD9A8), // Amber
                () => _navigateToExaminationDetails(context, 'cart4'),
          ),
        ],
      ),
    );
  }
  Widget _buildExaminationCard(
      BuildContext context,
      String date,
      String title,
      Color color,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0, // Set to 0 as we will use BoxShadow for custom elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Container(
          height: 120,
          width: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.7), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Changa-VariableFont_wght',
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                    fontFamily: 'Changa-VariableFont_wght',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
        pageToNavigate = Homepage();
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => pageToNavigate,
      ),
    );
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
          fontFamily: 'Changa-VariableFont_wght',
        ),
      ),
    );
  }

  Widget _buildClinicNews() {
    return FutureBuilder<List<Article>>(
      future: NewsService().fetchArticles(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'فشل في تحميل الأخبار',
              style: TextStyle(color: Colors.red, fontFamily: 'Changa-VariableFont_wght'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'لا توجد أخبار متاحة',
              style: TextStyle(color: Colors.grey, fontFamily: 'Changa-VariableFont_wght'),
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
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailPage(article: article),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
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
                              article.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[300],
                                  child: Icon(Icons.error, color: Colors.red),
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
                                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                                  ),
                                ),
                                child: Text(
                                  article.title,
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
                  );
                },
              );
            }).toList(),
          );
        }
      },
    );
  }
}

class AnimatedUserCard extends StatefulWidget {
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
    String userName = 'يوسف علي';
    String userNumber = '1234567890';
    String bloodType = 'A+';
    String address = 'بغداد';
    String age = '30 years'; // Example additional info

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5CBBE3),
              Color(0xFF04384F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الزائر العزيز',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Changa-VariableFont_wght',
                ),
              ),
              SizedBox(height: 8.0),
              _isExpanded
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الاسم: $userName',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontFamily: 'Changa-VariableFont_wght',
                    ),
                  ),
                  Text(
                    'الرقم: $userNumber',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontFamily: 'Changa-VariableFont_wght',
                    ),
                  ),
                  Text(
                    'فصيلة الدم: $bloodType',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontFamily: 'Changa-VariableFont_wght',
                    ),
                  ),
                  Text(
                    'العنوان: $address',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontFamily: 'Changa-VariableFont_wght',
                    ),
                  ),
                  Text(
                    'العمر: $age', // Additional info
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontFamily: 'Changa-VariableFont_wght',
                    ),
                  ),
                ],
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الاسم: $userName',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontFamily: 'Changa-VariableFont_wght',
                    ),
                  ),
                  Text(
                    'الرقم: $userNumber',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontFamily: 'Changa-VariableFont_wght',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
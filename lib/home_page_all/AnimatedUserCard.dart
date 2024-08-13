import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../languages/lang.dart';

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
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: Duration(milliseconds: 300),
              ),
              SizedBox(height: 8.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: _toggleCard,
                  child: SvgPicture.asset(
                    _isExpanded
                        ? 'assets/icons/less.svg'
                        : 'assets/icons/more.svg',
                    color: Colors.white,
                    height: 30.0,
                    width: 30.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
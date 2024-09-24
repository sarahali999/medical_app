import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../languages/lang.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/UserDetails.dart';

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
  UserDetails? userInfoDetails;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    fetchPatientDetails();
  }

  final String apiUrl = 'https://medicalpoint-api.tatwer.tech/api/Mobile/GetPatientDetails';

  String bloodType(int type) {
    switch (type) {
      case 1: return "A+";
      case 2: return "A-";
      case 3: return "O-";
      case 4: return "O+";
      case 5: return "AB+";
      case 6: return "AB-";
      case 7: return "B-";
      default: return "Unknown";
    }
  }

  Future<void> fetchPatientDetails() async {
    setState(() => isLoading = true);
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? jwtToken = prefs.getString('token');

      if (jwtToken == null) throw Exception('JWT token is missing');

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          userInfoDetails = UserDetails.fromJson(jsonResponse);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load patient details');
      }
    } catch (e) {
      print('Error fetching patient details: $e');
      setState(() => isLoading = false);
    }
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
            child: _buildUserCard(context, screenWidth, screenHeight),
          );
        },
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, double screenWidth, double screenHeight) {
    Map<String, Map<String, String>> userDetails = {
      'Arabic': {
        'greeting': 'الزائر العزيز',
        'name': 'الاسم: ',
        'number': 'الرقم: ',
        'bloodType': 'فصيلة الدم: ',
        'age': 'العمر: ',
      },
      'Persian': {
        'greeting': 'عزیز بازدید کننده',
        'name': 'نام: ',
        'number': 'شماره: ',
        'bloodType': 'گروه خونی: ',
        'age': 'سن: ',
      },
      'Kurdish': {
        'greeting': 'میوانی بەخێربێ',
        'name': 'ناو: ',
        'number': 'ژمارە: ',
        'bloodType': 'جۆری خوێن: ',
        'age': 'تەمەن: ',
      },
      'Turkmen': {
        'greeting': 'Hormatly myhman',
        'name': 'Ady: ',
        'number': 'Belgisi: ',
        'bloodType': 'Ganyň görnüşi: ',
        'age': 'Ýaşy: ',
      },
      'English': {
        'greeting': 'Dear Visitor',
        'name': 'Name: ',
        'number': 'Number: ',
        'bloodType': 'Blood Type: ',
        'age': 'Age: ',
      },
    };

    String languageKey = widget.selectedLanguage.toString().split('.').last;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.03,
        horizontal: screenWidth * 0.05,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5BB9AE),
              Color(0xFF5BB9AE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: screenWidth * 0.005,
              blurRadius: screenWidth * 0.02,
              offset: Offset(0, screenHeight * 0.005),
            ),
          ],
        ),
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : Column(
          children: [
            _buildHeader(screenWidth, screenHeight, userDetails[languageKey]!),
            _buildBody(screenWidth, screenHeight, userDetails[languageKey]!),
           // _buildFooter(screenWidth, screenHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(double screenWidth, double screenHeight, Map<String, String> translations) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.02),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(screenWidth * 0.03),
          topRight: Radius.circular(screenWidth * 0.03),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.person, color: Colors.white, size: screenWidth * 0.08),
          SizedBox(width: screenWidth * 0.02),
          Text(
            translations['greeting']!,
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(double screenWidth, double screenHeight, Map<String, String> translations) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(Icons.person, "${translations['name']}${userInfoDetails?.data?.user?.firstName ?? ''} ${userInfoDetails?.data?.user?.secondName ?? ''}", screenWidth),
          SizedBox(height: screenHeight * 0.01),
          _buildInfoRow(Icons.phone, "${translations['number']}${userInfoDetails?.data?.user?.phoneNumber ?? ''}", screenWidth),
          SizedBox(height: screenHeight * 0.01),
          _buildInfoRow(Icons.opacity, "${translations['bloodType']}${bloodType(userInfoDetails?.data?.bloodType ?? 0)}", screenWidth),
          SizedBox(height: screenHeight * 0.01),
          _buildInfoRow(Icons.cake, "${translations['age']}${userInfoDetails?.data?.birthYear ?? ''}", screenWidth),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, double screenWidth) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: screenWidth * 0.05),
        SizedBox(width: screenWidth * 0.02),
        Text(
          text,
          style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
        ),
      ],
    );
  }
  //
  // Widget _buildFooter(double screenWidth, double screenHeight) {
  //   return Container(
  //     padding: EdgeInsets.all(screenWidth * 0.02),
  //     decoration: BoxDecoration(
  //       color: Colors.white.withOpacity(0.1),
  //       borderRadius: BorderRadius.only(
  //         bottomLeft: Radius.circular(screenWidth * 0.04),
  //         bottomRight: Radius.circular(screenWidth * 0.04),
  //       ),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(
  //           _isExpanded ? "Hide Details" : "Show Details",
  //           style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.035),
  //         ),
  //         SizedBox(width: screenWidth * 0.02),
  //         Icon(
  //           _isExpanded ? Icons.expand_less : Icons.expand_more,
  //           color: Colors.white,
  //           size: screenWidth * 0.06,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
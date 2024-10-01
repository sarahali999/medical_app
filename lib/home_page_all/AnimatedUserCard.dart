import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../languages/lang.dart';

class AnimatedUserCard extends StatelessWidget {
  final Language selectedLanguage;

  AnimatedUserCard({required this.selectedLanguage});

  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.put(UserController());
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: controller.toggleCard,
      child: AnimatedBuilder(
        animation: controller.animation,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(controller.isExpanded.value ? controller.animation.value * -0.5 : 0),
            child: _buildUserCard(context, screenWidth, screenHeight, controller),
          );
        },
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, double screenWidth, double screenHeight, UserController controller) {
    Map<String, Map<String, String>> userDetails = {
      'Arabic': {
        'greeting': 'الزائر العزيز',
        'name': 'الاسم: ',
        'number': 'الرقم: ',
        'bloodType': 'فصيلة الدم: ',
        'age': 'العمر: ',
      },
      // ... (other language mappings remain the same)
    };

    String languageKey = selectedLanguage.toString().split('.').last;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.03,
        horizontal: screenWidth * 0.05,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5BB9AE), Color(0xFF5BB9AE)],
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
        child: Obx(() => controller.isLoading.value
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : Column(
          children: [
            _buildHeader(screenWidth, screenHeight, userDetails[languageKey]!),
            _buildBody(screenWidth, screenHeight, userDetails[languageKey]!, controller),
          ],
        )),
      ),
    );
  }


  Widget _buildBody(double screenWidth, double screenHeight, Map<String, String> translations, UserController controller) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(Icons.person,
              "${translations['name']}${controller.userInfoDetails.value?.data?.user?.firstName ?? ''} ${controller.userInfoDetails.value?.data?.user?.secondName ?? ''}", screenWidth),
          SizedBox(height: screenHeight * 0.01),
          _buildInfoRow(Icons.phone,
              "${translations['number']}${controller.userInfoDetails.value?.data?.user?.phoneNumber ?? ''}", screenWidth),
          SizedBox(height: screenHeight * 0.01),
          _buildInfoRow(Icons.opacity, "${translations['bloodType']}${controller.bloodType(
              controller.userInfoDetails.value?.data?.bloodType ?? 0)}", screenWidth),
          SizedBox(height: screenHeight * 0.01),
          _buildInfoRow(Icons.cake,
              "${translations['age']}${controller.userInfoDetails.value?.data?.birthYear ?? ''}",
              screenWidth),
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
}
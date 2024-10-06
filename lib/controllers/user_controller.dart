import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/UserDetails.dart';

class UserController extends GetxController with GetSingleTickerProviderStateMixin {
  static const String API_URL = 'https://medicalpoint-api.tatwer.tech/api/Mobile/GetPatientDetails';

  late AnimationController animationController;
  late Animation<double> animation;
  var isExpanded = false.obs;
  var userInfoDetails = Rx<UserDetails?>(null);
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
    fetchPatientDetails();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void toggleCard() {
    isExpanded.toggle();
    if (isExpanded.value) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  String bloodType(dynamic type) {
    try {
      if (type is int) {
        switch (type) {
          case 1:
            return "A+";
          case 2:
            return "A-";
          case 3:
            return "O-";
          case 4:
            return "O+";
          case 5:
            return "AB+";
          case 6:
            return "AB-";
          case 7:
            return "B-";
          default:
            return "Unknown";
        }
      } else if (type is String) {
        return type;
      } else {
        return "Unknown";
      }
    } catch (e) {
      print('Error in bloodType method: $e');
      return "Unknown";
    }
  }

  Future<void> fetchPatientDetails() async {
    isLoading.value = true;
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? jwtToken = prefs.getString('token');
      if (jwtToken == null) throw Exception('JWT token is missing');

      final response = await http.get(
        Uri.parse(API_URL),
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        userInfoDetails.value = UserDetails.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load patient details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching patient details: $e');
      // You might want to update the UI to show an error message here
    } finally {
      isLoading.value = false;
    }
  }
}
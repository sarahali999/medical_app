import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'styles.dart';
import 'language_service.dart';

class MedicalInfoPage extends StatelessWidget {
  final Language language;

  MedicalInfoPage({required this.language});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LanguageService.getText('medicalInfo', language),
            style: AppStyles.headerStyle,
          ),
          SizedBox(height: 20),
          FadeInUp(
            duration: Duration(milliseconds: 500),
            child: TextField(
              decoration: AppStyles.textFieldDecoration(
                LanguageService.getText('bloodType', language),
              ),
            ),
          ),
          SizedBox(height: 16),
          FadeInUp(
            duration: Duration(milliseconds: 700),
            child: TextField(
              decoration: AppStyles.textFieldDecoration(
                LanguageService.getText('chronicDiseases', language),
              ),
            ),
          ),
          // Add more fields as needed
        ],
      ),
    );
  }
}
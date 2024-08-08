import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'styles.dart';
import 'language_service.dart';

class EmergencyContactPage extends StatelessWidget {
  final Language language;

  EmergencyContactPage({required this.language});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LanguageService.getText('emergencyContact', language),
            style: AppStyles.headerStyle,
          ),
          SizedBox(height: 20),
          FadeInUp(
            duration: Duration(milliseconds: 500),
            child: TextField(
              decoration: AppStyles.textFieldDecoration(
                LanguageService.getText('emergencyContactName', language),
              ),
            ),
          ),
          SizedBox(height: 16),
          FadeInUp(
            duration: Duration(milliseconds: 700),
            child: TextField(
              decoration: AppStyles.textFieldDecoration(
                LanguageService.getText('emergencyContactRelation', language),
              ),
            ),
          ),
          // Add more fields as needed
        ],
      ),
    );
  }
}

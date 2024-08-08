import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl_phone_field/intl_phone_field.dart'; // Import the package
import 'styles.dart';
import 'language_service.dart';

class PersonalInfoPage extends StatelessWidget {
  final Language language;

  PersonalInfoPage({required this.language});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Make the entire page scrollable
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LanguageService.getText('personalInfo', language),
            style: AppStyles.headerStyle,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: FadeInUp(
                  duration: Duration(milliseconds: 500),
                  child: TextField(
                    decoration: AppStyles.textFieldDecoration(
                      LanguageService.getText('firstName', language),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: FadeInUp(
                  duration: Duration(milliseconds: 600),
                  child: TextField(
                    decoration: AppStyles.textFieldDecoration(
                      LanguageService.getText('secondName', language),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: FadeInUp(
                  duration: Duration(milliseconds: 700),
                  child: TextField(
                    decoration: AppStyles.textFieldDecoration(
                      LanguageService.getText('thirdName', language),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          FadeInUp(
            duration: Duration(milliseconds: 800),
            child: TextField(
              decoration: AppStyles.textFieldDecoration(
                LanguageService.getText('dateOfBirth', language),
              ),
            ),
          ),
          SizedBox(height: 16),
          FadeInUp(
            duration: Duration(milliseconds: 900),
            child: DropdownButtonFormField<String>(
              decoration: AppStyles.textFieldDecoration(
                LanguageService.getText('gender', language),
              ),
              items: [
                DropdownMenuItem(value: 'Male', child: Text('Male')),
                DropdownMenuItem(value: 'Female', child: Text('Female')),
              ],
              onChanged: (value) {},
            ),
          ),
          SizedBox(height: 16),
          FadeInUp(
            duration: Duration(milliseconds: 1000),
            child: IntlPhoneField(
              decoration: InputDecoration(
                labelText: LanguageService.getText('phoneNumber', language),
                border: OutlineInputBorder(),
              ),
              initialCountryCode: 'US',
              onChanged: (phone) {
                print(phone.completeNumber);
              },
            ),
          ),
        ],
      ),
    );
  }
}

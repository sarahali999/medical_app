import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'section_title.dart';
import '../languages/lang.dart';
import 'cusstom.dart';
class EmergencyContactPage extends StatelessWidget {
  final Language selectedLanguage;
  final TextEditingController emergencyContactNameController;
  final TextEditingController emergencyContactAddressController;
  final TextEditingController emergencyContactRelationshipController;
  final TextEditingController emergencyContactPhoneController;

  EmergencyContactPage({
    required this.selectedLanguage,
    required this.emergencyContactNameController,
    required this.emergencyContactAddressController,
    required this.emergencyContactRelationshipController,
    required this.emergencyContactPhoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: getLocalizedText('جهة الاتصال الطارئة', 'پەیوەندیدەری بەرەوپێش', 'Emergency Contact', 'پەیوەندیدەری بەرەوپێش', '')),
        CustomTextField(
          getLocalizedText('اسم جهة الاتصال الطارئة', 'نام فرد اضطراری', 'Emergency Contact Name', 'ناوی پەیوەندیدەری بەرەوپێش', ''),
          emergencyContactNameController,
          textStyle: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        _buildEmergencyPhoneNumberField(),
        CustomTextField(
          getLocalizedText('العنوان', 'آدرس', 'Address', 'ناونیشان', ''),
          emergencyContactAddressController,
          textStyle: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        CustomTextField(
          getLocalizedText('العلاقة', 'نسبت', 'Relationship', 'پەیوەندی', ''),
          emergencyContactRelationshipController,
          textStyle: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildEmergencyPhoneNumberField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getLocalizedText('رقم الهاتف', 'شماره تيلفۆن', 'Phone Number', 'ژمارەی تەلەفۆن', ''),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          IntlPhoneField(
            decoration: InputDecoration(
              labelText: getLocalizedText('رقم الهاتف', 'شماره تيلفۆن', 'Phone Number', 'ژمارەی تەلەفۆن', ''),
              labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[50],
              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
            initialCountryCode: 'US',
            onChanged: (phone) {
              print(phone.completeNumber);
            },
          ),
        ],
      ),
    );
  }

  String getLocalizedText(String arabic, String persian, String english, String kurdish, String defaultText) {
    switch (selectedLanguage) {
      case Language.Arabic:
        return arabic;
      case Language.Persian:
        return persian;
      case Language.Kurdish:
        return kurdish;
      default:
        return english;
    }
  }
}
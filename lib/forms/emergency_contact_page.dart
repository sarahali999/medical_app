import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'cusstom.dart';
import 'section_title.dart';
import '../languages/lang.dart';

class EmergencyContactPage extends StatelessWidget {
  final Language selectedLanguage;
  final TextEditingController emergencyContactNameController;
  final TextEditingController emergencyContactAddressController;
  final TextEditingController emergencyContactPhoneController;
  final TextEditingController emergencyContactRelationshipController;
  final TextEditingController emergencyContactCountryController;
  final TextEditingController emergencyContactProvinceController;
  final TextEditingController emergencyContactDistrictController;
  final TextEditingController emergencyContactAlleyController;
  final TextEditingController emergencyContactHouseController;

  final List<String> _connectionOptions = [
    'Father',
    'Mother',
    'Brother',
    'Sister',
    'Other',
  ];

  EmergencyContactPage({
    required this.selectedLanguage,
    required this.emergencyContactNameController,
    required this.emergencyContactAddressController,
    required this.emergencyContactPhoneController,
    required this.emergencyContactRelationshipController,
    required this.emergencyContactCountryController,
    required this.emergencyContactProvinceController,
    required this.emergencyContactDistrictController,
    required this.emergencyContactAlleyController,
    required this.emergencyContactHouseController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: getLocalizedText(
            'جهة الاتصال الطارئة',
            'پەیوەندیدەری بەرەوپێش',
            'Emergency Contact',
            'پەیوەندیدەری بەرەوپێش',
            'Ýaňyşlygyň aragatnaşygy',
          ),
        ),
        CustomTextField(
          getLocalizedText(
            'اسم جهة الاتصال الطارئة',
            'نام فرد اضطراری',
            'Emergency Contact Name',
            'ناوی پەیوندیدەری بەرەوپێش',
            'Ýaňyşlygyň aragatnaşygyň ady',
          ),
          emergencyContactNameController,
          textStyle: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        _buildEmergencyPhoneNumberField(),
        CustomTextField(
          getLocalizedText(
            'العنوان',
            'آدرس',
            'Address',
            'ناونیشان',
            'Salgysy',
          ),
          emergencyContactAddressController,
          textStyle: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        _buildConnectionDropdown(),
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
            getLocalizedText(
              'رقم الهاتف',
              'شماره تيلفۆن',
              'Phone Number',
              'ژمارەی تەلەفۆن',
              'Telefon belgisi',
            ),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          IntlPhoneField(
            decoration: InputDecoration(
              labelText: getLocalizedText(
                'رقم الهاتف',
                'شماره تيلفۆن',
                'Phone Number',
                'ژمارەی تەلەفۆن',
                'Telefon belgisi',
              ),
              labelStyle: TextStyle(color: Colors.black, fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                // borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
            initialCountryCode: 'IQ',
            onChanged: (phone) {
              print(phone.completeNumber);
              emergencyContactPhoneController.text = phone.completeNumber; // Save the phone number
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionDropdown() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getLocalizedText(
              'صلة القرابة',
              'نسبت',
              'Connection',
              'پەیوەندی',
              'Baglanyşyk',
            ),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                // borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
            items: _connectionOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  getLocalizedText(
                    value == 'Father' ? 'أب' : value == 'Mother' ? 'أم' : value == 'Brother' ? 'أخ' : value == 'Sister' ? 'أخت' : 'أخرى',
                    value == 'Father' ? 'پدر' : value == 'Mother' ? 'مادر' : value == 'Brother' ? 'برادر' : value == 'Sister' ? 'خواهر' : 'دیگر',
                    value,
                    value == 'Father' ? 'باوک' : value == 'Mother' ? 'دایک' : value == 'Brother' ? 'برا' : value == 'Sister' ? 'خوشک' : 'تر',
                    value == 'Father' ? 'Ata' : value == 'Mother' ? 'Ene' : value == 'Brother' ? 'Doganyňyz' : value == 'Sister' ? 'Uýadyňyz' : 'Beýlekiler',
                  ),
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              emergencyContactRelationshipController.text = newValue ?? '';
              print('Selected Connection: $newValue');
            },
          ),
        ],
      ),
    );
  }

  String getLocalizedText(String arabic, String persian, String english, String kurdish, String turkmen) {
    switch (selectedLanguage) {
      case Language.Arabic:
        return arabic;
      case Language.Persian:
        return persian;
      case Language.Kurdish:
        return kurdish;
      case Language.Turkmen:
        return turkmen;
      default:
        return english;
    }
  }
}

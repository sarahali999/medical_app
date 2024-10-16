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
    'Father',  // يجب أن تطابق تمامًا النصوص التي تعرفها في دالة الترجمة
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
    final localizations = AppLocalizations(selectedLanguage);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: localizations.emergencyContact,
        ),
        CustomTextField(
          localizations.emergencyContactName,
          emergencyContactNameController,
          textStyle: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        _buildEmergencyPhoneNumberField(localizations),
        _buildConnectionDropdown(localizations),
        CustomTextField(
          localizations.emergencyContactCountry,
          emergencyContactCountryController,
          textStyle: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        CustomTextField(
          localizations.emergencyContactProvince,
          emergencyContactProvinceController,
          textStyle: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        CustomTextField(
          localizations.emergencyContactDistrict,
          emergencyContactDistrictController,
          textStyle: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        CustomTextField(
          localizations.alley,
          emergencyContactAlleyController,
          textStyle: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        CustomTextField(
          localizations.house,
          emergencyContactHouseController,
          textStyle: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildEmergencyPhoneNumberField(AppLocalizations localizations) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.phoneNumber,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          IntlPhoneField(
            decoration: InputDecoration(
              labelText: localizations.phoneNumber,
              labelStyle: TextStyle(color: Colors.black, fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
            initialCountryCode: 'IQ',
            onChanged: (phone) {
              print(phone.completeNumber);
              emergencyContactPhoneController.text = phone.completeNumber;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionDropdown(AppLocalizations localizations) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.connection,
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
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
            items: _connectionOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  _getLocalizedConnection(value, localizations),
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
  String _getLocalizedConnection(String value, AppLocalizations localizations) {
    if (value == 'Father') {
      return localizations.father;
    } else if (value == 'Mother') {
      return localizations.mother;
    } else if (value == 'Brother') {
      return localizations.brother;
    } else if (value == 'Sister') {
      return localizations.sister;
    } else if (value == 'Other') {
      return localizations.other;
    } else {
      return localizations.unknown;  // إذا كان هناك قيمة غير معروفة، ارجع إلى "غير معروف"
    }
  }
}

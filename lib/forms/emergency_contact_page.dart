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
        CustomTextField(
          localizations.address,
          emergencyContactAddressController,
          textStyle: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        _buildConnectionDropdown(localizations),
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
    switch (value) {
      case 'Father':
        return localizations.father;
      case 'Mother':
        return localizations.mother;
      case 'Brother':
        return localizations.brother;
      case 'Sister':
        return localizations.sister;
      case 'Other':
        return localizations.other;
      default:
        return value;
    }
  }
}
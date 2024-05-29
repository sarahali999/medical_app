import 'package:flutter/material.dart';
import 'lang.dart';
class VisitorInfoScreen extends StatelessWidget {
  final Language selectedLanguage;
  final String name;
  final String age;
  final String dateOfBirth;
  final String gender;
  final List<String> phoneNumbers;
  final Map<String, String> address;
  final String bloodType;
  final String chronicDiseases;
  final String allergies;
  final Map<String, dynamic> emergencyContact;

  VisitorInfoScreen({
    required this.selectedLanguage,
    required this.name,
    required this.age,
    required this.dateOfBirth,
    required this.gender,
    required this.phoneNumbers,
    required this.address,
    required this.bloodType,
    required this.chronicDiseases,
    required this.allergies,
    required this.emergencyContact,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedLanguage == Language.Arabic
              ? 'معلومات الزائر'
              : selectedLanguage == Language.Persian
              ? 'اطلاعات بازدید کننده'
              : selectedLanguage == Language.Kurdish
              ? 'زانیاری سەرنجەمەند'
              : 'Visitor Information',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildInfoRow('Name', name),
            _buildInfoRow('Age', age),
            _buildInfoRow('Date of Birth', dateOfBirth),
            _buildInfoRow('Gender', gender),
            _buildInfoRow('Phone Numbers', phoneNumbers.join(', ')),
            _buildInfoRow('Address', _formatAddress(address)),
            _buildInfoRow('Blood Type', bloodType),
            _buildInfoRow('Chronic Diseases', chronicDiseases),
            _buildInfoRow('Allergies', allergies),
            _buildInfoRow('Emergency Contact Name', emergencyContact['name']),
            _buildInfoRow('Emergency Contact Relationship', emergencyContact['relationship']),
            _buildInfoRow('Emergency Contact Phone Numbers', emergencyContact['phoneNumbers'].join(', ')),
            _buildInfoRow('Emergency Contact Address', _formatAddress(emergencyContact['address'])),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }

  String _formatAddress(Map<String, String> address) {
    return '${address['country']}, ${address['province']}, ${address['judiciary']}, ${address['alley']}, ${address['house']}';
  }
}

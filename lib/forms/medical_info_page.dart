import 'package:flutter/material.dart';
import 'section_title.dart';
import '../languages/lang.dart';
import 'cusstom.dart';

class MedicalInfoPage extends StatelessWidget {
  final Language selectedLanguage;
  final String selectedBloodType;
  final TextEditingController chronicDiseasesController;
  final TextEditingController allergiesController;
  final Function(String?) onBloodTypeChanged;

  MedicalInfoPage({
    required this.selectedLanguage,
    required this.selectedBloodType,
    required this.chronicDiseasesController,
    required this.allergiesController,
    required this.onBloodTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: getLocalizedText('المعلومات الطبية', 'زانیاری پزیشکی', 'Medical Information', 'زانیاری پزیشکی', '')),
        _buildBloodTypeDropdown(),
        CustomTextField(
          getLocalizedText('الأمراض المزمنة', 'بیماری‌های مزمن', 'Chronic Diseases', 'نەخۆشیە مزمنەکان', ''),
          chronicDiseasesController,
          textStyle: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        CustomTextField(
          getLocalizedText('الحساسية', 'آلرژی‌ها', 'Allergies', 'تێکەڵەکان', ''),
          allergiesController,
          textStyle: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildBloodTypeDropdown() {
    List<String> bloodTypeOptions = [
      'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-',
    ];

    return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
    child: DropdownButtonFormField<String>(
    value: selectedBloodType.isNotEmpty ? selectedBloodType : null,
    items: bloodTypeOptions.map((String value) {
    return DropdownMenuItem<String>(
    value: value,
    child: Text(value, style: TextStyle(fontSize: 16, color: Colors.black87)),
    );
    }).toList(),
      onChanged: onBloodTypeChanged,
      decoration: InputDecoration(
        labelText: getLocalizedText('نوع الدم', 'گروه خونی', 'Blood Type', 'جۆری خوون', ''),
        labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
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
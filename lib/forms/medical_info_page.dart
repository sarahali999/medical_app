import 'package:flutter/material.dart';
import 'package:medicapp/forms/section_title.dart';
import '../languages/lang.dart';
import 'cusstom.dart';

class MedicalInfoPage extends StatelessWidget {
  final Language selectedLanguage;
  final int selectedBloodType;
  final TextEditingController chronicDiseasesController;
  final TextEditingController allergiesController;
  final ValueChanged<int?> onBloodTypeChanged;

  MedicalInfoPage({
    required this.selectedLanguage,
    required this.selectedBloodType,
    required this.chronicDiseasesController,
    required this.allergiesController,
    required this.onBloodTypeChanged,
  });


  @override
  Widget build(BuildContext context) {
    final bloodTypes = [
      'A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'
    ];


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: getLocalizedText(
              'المعلومات الطبية',
              'زانیاری پزیشکی',
              'Medical Information',
              'زانیاری پزیشکی',
              ''
          ),
        ),
        DropdownButtonFormField<int>(
          value: selectedBloodType,
          onChanged: onBloodTypeChanged,
          items: List.generate(bloodTypes.length, (index) {
            return DropdownMenuItem<int>(
              value: index,
              child: Text(
                bloodTypes[index], // Fixed to show the correct blood type
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            );
          }).toList(),
          decoration: InputDecoration(
            labelText: getLocalizedText(
                'نوع الدم',
                'گروه خونی',
                'Blood Type',
                'جۆری خوون',
                ''
            ),
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
        CustomTextField(
          getLocalizedText('الأمراض المزمنة', 'بیماری‌های مزمن', 'Chronic Diseases', 'نەخۆشیە مزمنەکان', ''),
         chronicDiseasesController,
          textStyle: TextStyle(fontSize: 14, color: Colors.black),
        ),
        CustomTextField(
          getLocalizedText('الحساسية', 'آلرژی‌ها', 'Allergies', 'تێکەڵەکان', ''),
          allergiesController, // Pass the controller directly
          textStyle: TextStyle(fontSize: 14, color: Colors.black),
        ),
      ],
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
      case Language.English:
      default:
        return english;
    }
  }
}

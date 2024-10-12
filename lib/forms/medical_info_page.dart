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
    final localizations = AppLocalizations(selectedLanguage);
    final bloodTypes = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: localizations.medicalInformation,
        ),
        DropdownButtonFormField<int>(
          value: selectedBloodType,
          onChanged: onBloodTypeChanged,
          items: List.generate(bloodTypes.length, (index) {
            return DropdownMenuItem<int>(
              value: index,
              child: Text(
                bloodTypes[index],
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            );
          }).toList(),
          decoration: InputDecoration(
            labelText: localizations.bloodType,
            labelStyle: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          ),
        ),
        CustomTextField(
          localizations.chronicDiseases,
          chronicDiseasesController,
          textStyle: TextStyle(fontSize: 14, color: Colors.black),
        ),
        CustomTextField(
          localizations.allergies,
          allergiesController,
          textStyle: TextStyle(fontSize: 14, color: Colors.black),
        ),
      ],
    );
  }
}
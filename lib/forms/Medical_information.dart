import 'package:flutter/material.dart';
import '../languages/lang.dart';
import 'Information_of_close person.dart';
import 'cusstom.dart';

class MedicalInformationPage extends StatefulWidget {
  final Language selectedLanguage;
  MedicalInformationPage({required this.selectedLanguage});

  @override
  _MedicalInformationPageState createState() => _MedicalInformationPageState();
}

class _MedicalInformationPageState extends State<MedicalInformationPage> {
  TextEditingController chronicDiseasesController = TextEditingController();
  TextEditingController allergiesController = TextEditingController();
  String selectedBloodType = '';
  List<String> bloodTypeOptions = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  Widget _buildBloodTypeDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: widget.selectedLanguage == Language.Arabic ? 'فصيلة الدم' :
        widget.selectedLanguage == Language.Persian ? 'گروه خون' :
        widget.selectedLanguage == Language.Kurdish ? 'جۆری خوێن' :
        'Blood Type',
      ),
      value: selectedBloodType.isNotEmpty ? selectedBloodType : null,
      items: bloodTypeOptions.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedBloodType = value!;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Medical Information')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBloodTypeDropdown(),
            SizedBox(height: 16),
            CustomTextField(
              widget.selectedLanguage == Language.Arabic ? 'الأمراض المزمنة والعلاجات المأخوذة' :
              widget.selectedLanguage == Language.Persian ? 'بیماری‌های مزمن و درمان‌های انجام‌شده' :
              widget.selectedLanguage == Language.Kurdish ? 'نەخۆشییەکانی دوامدار و چارەسەرەکانی بەکارهێنراو' :
              'Chronic Diseases and Taken Treatments',
              chronicDiseasesController,
            ),
            SizedBox(height: 16),
            CustomTextField(
              widget.selectedLanguage == Language.Arabic ? 'المواد والأدوية التي يتحسس منها الزائر' :
              widget.selectedLanguage == Language.Persian ? 'مواد و داروهایی که بازدید کننده حساسیت نشان می‌دهد' :
              widget.selectedLanguage == Language.Kurdish ? 'مادە و دەرمانەکان کە سەردانکەر حەساسیتیان پێیە' :
              'Substances and Medicines Visitor is Allergic to',
              allergiesController,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              child: Text('Next'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InformationOfClosePersonPage(selectedLanguage: widget.selectedLanguage),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
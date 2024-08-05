import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../languages/lang.dart';
import 'cusstom.dart';
import 'package:medicapp/home_page_all/home.dart';

class InformationOfClosePersonPage extends StatefulWidget {
  final Language selectedLanguage;
  InformationOfClosePersonPage({required this.selectedLanguage});

  @override
  _InformationOfClosePersonPageState createState() => _InformationOfClosePersonPageState();
}

class _InformationOfClosePersonPageState extends State<InformationOfClosePersonPage> {
  TextEditingController emergencyContactNameController = TextEditingController();
  TextEditingController emergencyContactRelationshipController = TextEditingController();
  TextEditingController emergencyContactaddress1 = TextEditingController();
  TextEditingController emergencyContactaddress2 = TextEditingController();
  TextEditingController emergencyContactadress3 = TextEditingController();
  TextEditingController emergencyContactadress4 = TextEditingController();
  TextEditingController emergencyContactadress5 = TextEditingController();
  TextEditingController emergencyContactPhoneController = TextEditingController();

  Widget _buildEmergencyContactAddressTitle() {
    return Text(
      widget.selectedLanguage == Language.Arabic ? 'العنوان ' :
      widget.selectedLanguage == Language.Persian ? 'آدرس تماس اضطراری' :
      widget.selectedLanguage == Language.Kurdish ? 'ناونیشانی پەیوەندیی ئەرکی' :
      'Emergency Contact Address',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildEmergencyContactAddressFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          widget.selectedLanguage == Language.Arabic ? 'البلد' :
          widget.selectedLanguage == Language.Persian ? 'کشور' :
          widget.selectedLanguage == Language.Kurdish ? 'وڵات' :
          'Country',
          emergencyContactaddress1,
        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic ? 'المحافظة' :
          widget.selectedLanguage == Language.Persian ? 'استان' :
          widget.selectedLanguage == Language.Kurdish ? 'پارێزگا' :
          'Province',
          emergencyContactaddress2,
        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic ? 'القضاء' :
          widget.selectedLanguage == Language.Persian ? 'قضاوت' :
          widget.selectedLanguage == Language.Kurdish ? 'دادوەری' :
          'Judiciary',
          emergencyContactadress3,
        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic ? 'الزقاق' :
          widget.selectedLanguage == Language.Persian ? 'کوچه' :
          widget.selectedLanguage == Language.Kurdish ? 'کۆڵانەوە' :
          'Alley',
          emergencyContactadress4,
        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic ? 'الدار' :
          widget.selectedLanguage == Language.Persian ? 'خانه' :
          widget.selectedLanguage == Language.Kurdish ? 'خانوو' :
          'House',
          emergencyContactadress5,
        ),
      ],
    );
  }

  Widget _buildPhoneNumberField() {
    return IntlPhoneField(
      decoration: InputDecoration(
        labelText: widget.selectedLanguage == Language.Arabic ? 'رقم الهاتف' :
        widget.selectedLanguage == Language.Persian ? 'شماره تلفن' :
        widget.selectedLanguage == Language.Kurdish ? 'ژمارەی تەلەفۆن' :
        'Phone Number',
      ),
      initialCountryCode: 'TR',
      onChanged: (phone) {
        print(phone.completeNumber);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.selectedLanguage == Language.Arabic ? 'معلومات شخص مقرب' :
            widget.selectedLanguage == Language.Persian ? 'اطلاعات نزدیک شخص' :
            widget.selectedLanguage == Language.Kurdish ? 'زانیاری کەسێکی نزیک' :
            'Close Person Information'
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              widget.selectedLanguage == Language.Arabic ? 'الاسم' :
              widget.selectedLanguage == Language.Persian ? 'نام' :
              widget.selectedLanguage == Language.Kurdish ? 'ناوی کەسەکە' :
              'Person\'s Name',
              emergencyContactNameController,
            ),
            SizedBox(height: 16),
            CustomTextField(
              widget.selectedLanguage == Language.Arabic ? 'صلة القرابة' :
              widget.selectedLanguage == Language.Persian ? 'رابطه خویشاوندی' :
              widget.selectedLanguage == Language.Kurdish ? 'پەیوەندیی خیزانی' :
              'Relationship',
              emergencyContactRelationshipController,
            ),
            SizedBox(height: 16),
            _buildEmergencyContactAddressTitle(),
            SizedBox(height: 8),
            _buildEmergencyContactAddressFields(),
            SizedBox(height: 16),
            _buildPhoneNumberField(),
            SizedBox(height: 24),
            ElevatedButton(
              child: Text(
                  widget.selectedLanguage == Language.Arabic ? 'حفظ' :
                  widget.selectedLanguage == Language.Persian ? 'ذخیره' :
                  widget.selectedLanguage == Language.Kurdish ? 'پاشکەوتکردن' :
                  'Save'
              ),
              onPressed: () {
                // Here you would typically save all the collected information
                // For now, we'll just navigate to the MainScreen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen(selectedLanguage: widget.selectedLanguage)),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../LoadingScreen.dart';
import '../languages/lang.dart';
import '../phones/PhoneNumberInputPage.dart';
import 'Registrationinformation.dart';
import 'personal_info_page.dart';
import 'medical_info_page.dart';
import 'emergency_contact_page.dart';
import 'step_indicator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PatientInfoIntroScreen extends StatefulWidget {
  final Language selectedLanguage;

  PatientInfoIntroScreen({required this.selectedLanguage});

  @override
  _PatientInfoIntroScreenState createState() => _PatientInfoIntroScreenState();
}

class _PatientInfoIntroScreenState extends State<PatientInfoIntroScreen> with TickerProviderStateMixin {
  final personalInfoKey = GlobalKey<FormState>();
  final medicalInfoKey = GlobalKey<FormState>();
  final emergencyContactKey = GlobalKey<FormState>();

  int? selectedDay;
  String? selectedMonth;
  String? selectedYear;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController fourthNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController governorateController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController alleyController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController bloodTypeController = TextEditingController();
  TextEditingController chronicDiseasesController = TextEditingController();
  TextEditingController allergiesController = TextEditingController();
  TextEditingController emergencyContactCountryController = TextEditingController();
  TextEditingController emergencyContactProvinceController = TextEditingController();
  TextEditingController emergencyContactDistrictController = TextEditingController();
  TextEditingController emergencyContactAlleyController = TextEditingController();
  TextEditingController emergencyContactHouseController = TextEditingController();
  TextEditingController emergencyContactNameController = TextEditingController();
  TextEditingController emergencyContactPhoneController = TextEditingController();
  TextEditingController emergencyContactAddressController = TextEditingController();
  TextEditingController emergencyContactRelationshipController = TextEditingController();
  List<TextEditingController> phoneControllers = [TextEditingController()];
  int selectedGender = 0;
  int selectedBloodType = 1;  // Default value
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> submitPatientData() async {
      if (phoneNumberController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                MyPhone(selectedLanguage: widget.selectedLanguage),
          ),
        );
      } else {
        // Handle missing phone number or password (e.g., show an error message)
        print('Please fill in phone number and password');
      }

      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('https://medicalpoint-api.tatwer.tech/api/Mobile/RegisterPatient'));
      request.body = json.encode({
        'firstName': firstNameController.text,
        'secondName': lastNameController.text,
        'thirdName': middleNameController.text,
        'gender': selectedGender == 1 ? 0 : 1,
        'address': addressController.text,
        'birthYear': selectedYear ?? '',
        'country': countryController.text,
        'province': governorateController.text,
        'district': districtController.text,
        'alley': alleyController.text,
        'house': houseController.text,
        'bloodType': selectedBloodType,
        'email': emailController.text,
        'chronicDiseases': chronicDiseasesController.text,
        'allergies': allergiesController.text,
        'emergencyContactFullName': emergencyContactNameController.text,
        'emergencyContactAddress': emergencyContactAddressController.text,
        'emergencyContactCountry': emergencyContactCountryController.text,
        'emergencyContactProvince': emergencyContactProvinceController.text,
        'emergencyContactDistrict': emergencyContactDistrictController.text,
        'emergencyContactAlley': emergencyContactAlleyController.text,
        'emergencyContactHouse': emergencyContactHouseController.text,
        'emergencyContactPhoneNumber': emergencyContactPhoneController.text,
        'emergencyContactRelationship': int.tryParse(emergencyContactRelationshipController.text) ?? 0,
        'password': passwordController.text,
        'phoneNumber': phoneNumberController.text,
        'username': usernameController.text,
      });
      request.headers.addAll(headers);

      print('Request Body: ${request.body}');
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
        print('Response: ${await response.stream.bytesToString()}');
      }

    }
    bool isRightToLeft = widget.selectedLanguage == Language.Arabic ||
        widget.selectedLanguage == Language.Persian ||
        widget.selectedLanguage == Language.Kurdish;

    return Directionality(
      textDirection: isRightToLeft ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: Color(0xFF5BB9AE)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          children: [
            StepIndicator(currentStep: currentStep, totalSteps: 4, selectedLanguage: widget.selectedLanguage,),
            Expanded(
              child: IntroductionScreen(
                onChange: (index) {
                  setState(() {
                    currentStep = index;
                  });
                },
                pages: [
                  _buildAnimatedPageViewModel(
                    PersonalInfoPage(
                      selectedLanguage: widget.selectedLanguage,
                      firstname: firstNameController,
                      lastNameController: lastNameController,
                      middleNameController: middleNameController,
                      alleyController: alleyController,
                      districtController: districtController,
                      governorateController: governorateController,
                      countryController: countryController,
                      houseController: houseController,
                      selectedGender: selectedGender,
                      selectedDay: selectedDay,
                      selectedMonth: selectedMonth,
                      selectedYear: selectedYear,
                      onGenderChanged: (value) => setState(() => selectedGender = value!),
                      onDayChanged: (value) => setState(() => selectedDay = int.parse(value!)),
                      onMonthChanged: (value) => setState(() => selectedMonth = value!),
                      onYearChanged: (value) => setState(() => selectedYear = value!),
                    ),
                  ),
                  _buildAnimatedPageViewModel(
                    AccountInfoPage(
                      selectedLanguage: widget.selectedLanguage,
                      emailController: emailController,
                      passwordController: passwordController,
                      usernameController: usernameController,
                      phoneNumberController: phoneNumberController,
                    ),
                  ),
                  _buildAnimatedPageViewModel(
                    MedicalInfoPage(
                      selectedLanguage: widget.selectedLanguage,
                      selectedBloodType: selectedBloodType,
                      chronicDiseasesController: chronicDiseasesController,
                      allergiesController: allergiesController,
                      onBloodTypeChanged: (value) => setState(() => selectedBloodType = value!),
                    ),
                  ),
                  _buildAnimatedPageViewModel(
                    EmergencyContactPage(
                      selectedLanguage: widget.selectedLanguage,
                      emergencyContactNameController: emergencyContactNameController,
                      emergencyContactAddressController: emergencyContactAddressController,
                      emergencyContactRelationshipController: emergencyContactRelationshipController,
                      emergencyContactPhoneController: emergencyContactPhoneController,
                      emergencyContactCountryController: emergencyContactCountryController,
                      emergencyContactProvinceController: emergencyContactProvinceController, // Use the correct controller
                      emergencyContactDistrictController: emergencyContactDistrictController, // Use the correct controller
                      emergencyContactAlleyController: emergencyContactAlleyController, // Use the correct controller
                      emergencyContactHouseController: emergencyContactHouseController, // Use the correct controller
                    ),
                  ),

                ],
                done: Text(
                  getLocalizedText('إنهاء', 'پایان', 'Done', 'کۆیە', ''),
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFF5BB9AE),
                  ),                     ),
                onDone: () {
                  submitPatientData();
                },
                next: Text(
                  getLocalizedText('التالي', 'بعدی', 'Next', 'پاشەکەوت', ''),
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFF5BB9AE),
                  ),                     ),
                skip: SizedBox.shrink(),
                nextFlex: 0,
                dotsDecorator: DotsDecorator(
                  color: Colors.blueGrey,
                  activeColor: Color(0xFF5BB9AE),
                  size: Size(10.0, 10.0),
                  activeSize: Size(15.0, 10.0),
                  spacing: EdgeInsets.symmetric(horizontal: 3.0),
                ),
                globalBackgroundColor: Colors.white,
                animationDuration: 400,
                curve: Curves.easeInOut,
              ),
            ),
          ],
        ),
      ),
    );
  }

  PageViewModel _buildAnimatedPageViewModel(Widget content) {
    return PageViewModel(
      titleWidget: SizedBox.shrink(),
      bodyWidget: AnimationLimiter(
        child: AnimationConfiguration.staggeredList(
          position: 0,
          duration: const Duration(milliseconds: 600),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: content,
            ),
          ),
        ),
      ),
      decoration: PageDecoration(
        contentMargin: EdgeInsets.all(16),
        pageColor: Colors.white,
        imagePadding: EdgeInsets.zero,
      ),
    );
  }

  String getLocalizedText(String arabic, String persian, String english, String kurdish, String turkmen) {
    switch (widget.selectedLanguage) {
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

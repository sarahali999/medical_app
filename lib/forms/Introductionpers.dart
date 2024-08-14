import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../LoadingScreen.dart';
import '../languages/lang.dart';
import 'personal_info_page.dart';
import 'medical_info_page.dart';
import 'emergency_contact_page.dart';
import 'step_indicator.dart';
import 'package:medicapp/home_page_all/home.dart';

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
  TextEditingController fourthNameController = TextEditingController();
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
  TextEditingController emergencyContactNameController = TextEditingController();
  TextEditingController emergencyContactPhoneController = TextEditingController();
  TextEditingController emergencyContactAddressController = TextEditingController();
  TextEditingController emergencyContactRelationshipController = TextEditingController();
  List<TextEditingController> phoneControllers = [TextEditingController()];

  String selectedGender = '';
  String selectedBloodType = '';
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isRightToLeft = widget.selectedLanguage == Language.Arabic ||
        widget.selectedLanguage == Language.Persian ||
        widget.selectedLanguage == Language.Kurdish;

    return Directionality(
      textDirection: isRightToLeft ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: Color(0xFF5CBBE3)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          children: [
            StepIndicator(currentStep: currentStep, totalSteps: 3),
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
                      fourthNameController: fourthNameController,
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
                    ),
                  ),
                ],
                done: Text(
                  getLocalizedText('إنهاء', 'پایان', 'Done', 'کۆیە', ''),
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                onDone: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoadingScreen(
                        onLoaded: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainScreen(selectedLanguage: widget.selectedLanguage),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                next: Text(
                  getLocalizedText('التالي', 'بعدی', 'Next', 'پاشەکەوت', ''),
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                skip: SizedBox.shrink(),
                nextFlex: 0,
                dotsDecorator: DotsDecorator(
                  color: Colors.blueGrey,
                  activeColor: Colors.blue,
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

  String getLocalizedText(String arabic, String persian, String english, String kurdish, String defaultText) {
    switch (widget.selectedLanguage) {
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
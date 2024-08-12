import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../languages/lang.dart';
import 'package:medicapp/home_page_all/home.dart';
import 'cusstom.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16, top: 24),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Color(0xFF5CBBE3),
        ),
      ).animate()
          .fadeIn(duration: 600.ms, curve: Curves.easeOutQuad)
          .slideX(begin: -0.2, end: 0, duration: 600.ms, curve: Curves.easeOutQuad)
          .scale(begin: Offset(0.8, 0.8), end: Offset(1, 1), duration: 600.ms, curve: Curves.easeOutQuad),
    );
  }
}class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  StepIndicator({required this.currentStep, required this.totalSteps});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(totalSteps, (index) {
              bool isActive = index <= currentStep;
              bool isCurrent = index == currentStep;
              return _buildStep(context, index, isActive, isCurrent);
            }),
          ),
          SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (currentStep + 1) / totalSteps,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF5CBBE3)),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(BuildContext context, int index, bool isActive, bool isCurrent) {
    return Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: isActive ? Color(0xFF5CBBE3) : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? Color(0xFF5CBBE3) : Colors.grey[300]!,
              width: 2,
            ),
            boxShadow: isCurrent
                ? [BoxShadow(color: Color(0xFF5CBBE3).withOpacity(0.3), blurRadius: 8, spreadRadius: 2)]
                : [],
          ),
          child: Center(
            child: SvgPicture.asset(
              _getIconPath(index),
              color: isActive ? Colors.white : Colors.grey[400],
              width: 28,
              height: 28,
            ),
          ),
        ).animate()
            .scale(
          begin: Offset(isCurrent ? 0.9 : 1, isCurrent ? 0.9 : 1),
          end: Offset(isCurrent ? 1.1 : 1, isCurrent ? 1.1 : 1),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        )
            .then()
            .scale(
          begin: Offset(isCurrent ? 1.1 : 1, isCurrent ? 1.1 : 1),
          end: Offset(1, 1),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
        SizedBox(height: 8),
        Text(
          _getStepTitle(index),
          style: TextStyle(
            color: isActive ? Color(0xFF5CBBE3) : Colors.grey[600],
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  String _getIconPath(int index) {
    switch (index) {
      case 0:
        return 'assets/icons/person.svg';
      case 1:
        return 'assets/icons/medh.svg';
      case 2:
        return 'assets/icons/close.svg';
      default:
        return 'assets/icons/close.svg';
    }
  }

  String _getStepTitle(int index) {
    switch (index) {
      case 0:
        return 'Personal';
      case 1:
        return 'Medical';
      case 2:
        return 'Emergency';
      default:
        return '';
    }
  }
}
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
  TextEditingController emergencyContactaddress1 = TextEditingController();
  TextEditingController emergencyContactaddress2 = TextEditingController();
  TextEditingController emergencyContactadress3 = TextEditingController();
  TextEditingController emergencyContactadress4 = TextEditingController();
  TextEditingController emergencyContactadress5 = TextEditingController();

  TextEditingController emergencyContactRelationshipController = TextEditingController();
  TextEditingController emergencyContactPhoneControllers = TextEditingController();
  TextEditingController medicalHistoryController = TextEditingController();
  List<TextEditingController> phoneControllers = [TextEditingController()];
  late List<String> genderOptions;
  String selectedGender = '';
  List<String> bloodTypeOptions = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];
  String selectedBloodType = '';

  @override
  void initState() {
    super.initState();
    genderOptions = _getGenderOptions();
  }

  List<String> _getGenderOptions() {
    switch (widget.selectedLanguage) {
      case Language.Arabic:
        return ['ذكر', 'أنثى'];
      case Language.Persian:
        return ['مرد', 'زن'];
      case Language.Kurdish:
        return ['پیاو', 'ژن'];
      default:
        return ['Male', 'Female'];
    }
  }
  int currentStep = 0;

  Widget _buildeemPhoneNumberField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getLocalizedText('رقم الهاتف', 'شماره تيلفۆن', 'Phone Number', 'ژمارەی تەلەفۆن', ''),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          IntlPhoneField(
            decoration: InputDecoration(
              labelText: getLocalizedText('رقم الهاتف', 'شماره تيلفۆن', 'Phone Number', 'ژمارەی تەلەفۆن', ''),
              labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[50],
              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
            initialCountryCode: 'US',
            onChanged: (phone) {
              print(phone.completeNumber);
            },
          ),
        ],
      ),
    );
  }
  Widget _buildSectionTitle(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Color(0xFF5CBBE3),
        ),
      ),
    );
  }

  Widget _buildBloodTypeDropdown() {
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
        onChanged: (value) {
          setState(() {
            selectedBloodType = value!;
          });
        },
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

  Widget _buildAddressTitle() {
    return Text(
      widget.selectedLanguage == Language.Arabic ? 'العنوان' :
      widget.selectedLanguage == Language.Persian ? 'آدرس' :
      widget.selectedLanguage == Language.Kurdish ? 'ناونیشان' :
      'Address',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
  Widget _buildAddressFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTextField(
          widget.selectedLanguage == Language.Arabic ? 'البلد' :
          widget.selectedLanguage == Language.Persian ? 'کشور' :
          widget.selectedLanguage == Language.Kurdish ? 'وڵات' :
          'Country',
          alleyController,
        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic ? 'المحافظة' :
          widget.selectedLanguage == Language.Persian ? 'استان' :
          widget.selectedLanguage == Language.Kurdish ? 'پارێزگا' :
          'Province',
          districtController,
        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic ? 'القضاء' :
          widget.selectedLanguage == Language.Persian ? 'دادگاه' :
          widget.selectedLanguage == Language.Kurdish ? 'دادگا' :
          'Judiciary',
          governorateController,
        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic ? 'الزقاق' :
          widget.selectedLanguage == Language.Persian ? 'کوچه' :
          widget.selectedLanguage == Language.Kurdish ? 'کۆڵان' :
          'Alley',
          countryController,
        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic ? 'الدار' :
          widget.selectedLanguage == Language.Persian ? 'خانه' :
          widget.selectedLanguage == Language.Kurdish ? 'ماڵ' :
          'House',
          houseController,
        ),
        SizedBox(height: 8),
        SizedBox(height: 8),
      ],
    );
  }
  Widget _buildNameFields() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              '',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: CustomTextField(
                  widget.selectedLanguage == Language.Arabic ? 'الاسم الاول' :
                  widget.selectedLanguage == Language.Persian ? 'نام اول' :
                  widget.selectedLanguage == Language.Kurdish ? 'ناوی یەکەم' :
                  'first Name',
                  fourthNameController,
                  textStyle: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return widget.selectedLanguage == Language.Arabic ? 'يرجى إدخال الاسم الأول'
                          :
                      widget.selectedLanguage == Language.Persian ? 'لطفاً نام اول را وارد کنید'
                          :
                      widget.selectedLanguage == Language.Kurdish ? 'تکایە ناوی یەکەم داخل بکە'
                          :
                      'Please enter the first name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: CustomTextField(
                  widget.selectedLanguage == Language.Arabic ? 'الاسم الثاني' :
                  widget.selectedLanguage == Language.Persian ? 'نام دوم' :
                  widget.selectedLanguage == Language.Kurdish ? 'ناوی دووهەم' :
                  'second Name',
                  lastNameController,
                  textStyle: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return widget.selectedLanguage == Language.Arabic
                          ? 'يرجى إدخال الاسم الثاني'
                          :
                      widget.selectedLanguage == Language.Persian
                          ? 'لطفاً نام دوم را وارد کنید'
                          :
                      widget.selectedLanguage == Language.Kurdish
                          ? 'تکایە ناوی دووهەم داخل بکە'
                          :
                      'Please enter the second name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: CustomTextField(
                  widget.selectedLanguage == Language.Arabic ? 'الاسم الثالث' :
                  widget.selectedLanguage == Language.Persian ? 'نام سوم' :
                  widget.selectedLanguage == Language.Kurdish ? 'ناوی سێیەم' :
                  'Third Name',
                  middleNameController,
                  textStyle: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
        ]
    );
  }
  Widget _buildGenderDropdown() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: selectedGender.isNotEmpty ? selectedGender : null,
        items: _getGenderOptions().map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: TextStyle(fontSize: 16, color: Colors.black87)),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedGender = value!;
          });
        },
        decoration: InputDecoration(
          labelText: getLocalizedText('الجنس', 'جنس', 'Gender', 'رەگەز', ''),
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

  Widget _buildDateOfBirthField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getLocalizedText('تاريخ الميلاد', 'تاریخ تولد', 'Date of Birth', 'رێکەوتی لەدایکبوون', ''),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildDateDropdown(
                  getLocalizedText('اليوم', 'روز', 'Day', 'ڕۆژ', ''),
                  List.generate(31, (index) => (index + 1).toString()),
                  selectedDay?.toString(),
                      (value) => setState(() => selectedDay = int.parse(value!)),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildDateDropdown(
                  getLocalizedText('الشهر', 'ماه', 'Month', 'مانگ', ''),
                  List.generate(12, (index) => (index + 1).toString()),
                  selectedMonth,
                      (value) => setState(() => selectedMonth = value!),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildDateDropdown(
                  getLocalizedText('السنة', 'سال', 'Year', 'ساڵ', ''),
                  List.generate(DateTime.now().year - 1900 + 1, (index) => (DateTime.now().year - index).toString()),
                  selectedYear,
                      (value) => setState(() => selectedYear = value!),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateDropdown(String label, List<String> items, String? selectedValue, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      items: items.map((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(fontSize: 16, color: Colors.black87)),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }
  Widget _buildPhoneNumberField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getLocalizedText('رقم الهاتف', 'شماره تيلفۆن', 'Phone Number', 'ژمارەی تەلەفۆن', ''),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          IntlPhoneField(
            decoration: InputDecoration(
              labelText: getLocalizedText('رقم الهاتف', 'شماره تيلفۆن', 'Phone Number', 'ژمارەی تەلەفۆن', ''),
              labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[50],
              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
            initialCountryCode: 'US',
            onChanged: (phone) {
              print(phone.completeNumber);
            },
          ),
        ],
      ),
    );
  }
  Widget _buildPersonalInfoPage() {
  return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  SectionTitle(title: getLocalizedText('المعلومات الشخصية', 'زانیاری تایبەتی', 'Personal Information', 'زانیاری تایبەتی', '')),
    SizedBox(height: 1),
    _buildNameFields(),
  _buildAddressTitle(),
  _buildAddressFields(),
  _buildGenderDropdown(),
  _buildDateOfBirthField(),
  _buildPhoneNumberField(),
  ],
  );
  }

  Widget _buildMedicalInfoPage() {
  return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  SectionTitle(title: getLocalizedText('المعلومات الطبية', 'زانیاری پزیشکی', 'Medical Information', 'زانیاری پزیشکی', '')),
  _buildBloodTypeDropdown(),
  CustomTextField(
  widget.selectedLanguage == Language.Arabic ? 'الأمراض المزمنة' :
  widget.selectedLanguage == Language.Persian ? 'بیماری‌های مزمن' :
  widget.selectedLanguage == Language.Kurdish ? 'نەخۆشیە مزمنەکان' :
  'Chronic Diseases',
  chronicDiseasesController,
  textStyle: TextStyle(
  fontSize: 14,
  color: Colors.black,
  ),
  ),
  CustomTextField(
  widget.selectedLanguage == Language.Arabic ? 'الحساسية' :
  widget.selectedLanguage == Language.Persian ? 'آلرژی‌ها' :
  widget.selectedLanguage == Language.Kurdish ? 'تێکەڵەکان' :
  'Allergies',
  allergiesController,
  textStyle: TextStyle(
  fontSize: 14,
  color: Colors.black,
  ),
  ),
  ],
  );
  }

  Widget _buildEmergencyContactPage() {
  return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  SectionTitle(title: getLocalizedText('جهة الاتصال الطارئة', 'پەیوەندیدەری بەرەوپێش', 'Emergency Contact', 'پەیوەندیدەری بەرەوپێش', '')),
  CustomTextField(
  widget.selectedLanguage == Language.Arabic ? 'اسم جهة الاتصال الطارئة' :
  widget.selectedLanguage == Language.Persian ? 'نام فرد اضطراری' :
  widget.selectedLanguage == Language.Kurdish ? 'ناوی پەیوەندیدەری بەرەوپێش' :
  'Emergency Contact Name',
  emergencyContactNameController,
  textStyle: TextStyle(
  fontSize: 14,
  color: Colors.black,
  ),
  ),
    _buildeemPhoneNumberField(),

  CustomTextField(
  widget.selectedLanguage == Language.Arabic ? 'العنوان' :
  widget.selectedLanguage == Language.Persian ? 'آدرس' :
  widget.selectedLanguage == Language.Kurdish ? 'ناونیشان' :
  'Address',
  emergencyContactAddressController,
  textStyle: TextStyle(
  fontSize: 14,
  color: Colors.black,
  ),
  ),
  ],
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
                  _buildAnimatedPageViewModel(_buildPersonalInfoPage()),
                  _buildAnimatedPageViewModel(_buildMedicalInfoPage()),
                  _buildAnimatedPageViewModel(_buildEmergencyContactPage()),
                ],
                done: Text(
                  getLocalizedText('إنهاء', 'پایان', 'Done', 'کۆیە', ''),
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                onDone: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen(selectedLanguage: widget.selectedLanguage)),
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
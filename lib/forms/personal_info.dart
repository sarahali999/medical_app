import 'package:flutter/material.dart';
import 'cusstom.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../languages/lang.dart';
import 'package:medicapp/home_page_all/home.dart';

class PersonalInfoPage extends StatefulWidget {
  final Language selectedLanguage;
  PersonalInfoPage({required this.selectedLanguage});
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
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
  TextEditingController  emergencyContactaddress1=TextEditingController();
  TextEditingController  emergencyContactaddress2=TextEditingController();
  TextEditingController emergencyContactadress3 =TextEditingController();
  TextEditingController emergencyContactadress4 =TextEditingController();
  TextEditingController emergencyContactadress5 =TextEditingController();

  TextEditingController emergencyContactRelationshipController = TextEditingController();
  TextEditingController emergencyContactPhoneControllers = TextEditingController();
  TextEditingController medicalHistoryController = TextEditingController();
  // final TextEditingController agenController = TextEditingController();
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
  get selectedLanguage => Language.Arabic;
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
  }Widget _buildGenderDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!, width: 1.0),
        color: Colors.grey[100],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedGender.isNotEmpty ? selectedGender : null,
          items: _getGenderOptions().map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedGender = value!;
            });
          },
          hint: Text(
            widget.selectedLanguage == Language.Arabic ? 'الجنس' :
            widget.selectedLanguage == Language.Persian ? 'جنس' :
            widget.selectedLanguage == Language.Kurdish ? 'رەگەز' :
            'Gender',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          isExpanded: true,
        ),
      ),
    );
  }  Widget _buildDateOfBirthField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        SizedBox(height: 8),
        Text(
          widget.selectedLanguage == Language.Arabic ? 'تاريخ الميلاد' :
          widget.selectedLanguage == Language.Persian ? 'تاریخ تولد' :
          widget.selectedLanguage == Language.Kurdish ? 'رێکەوتی لەدایکبوون' :
          'Date of Birth',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: widget.selectedLanguage == Language.Arabic ||
              widget.selectedLanguage == Language.Persian ||
              widget.selectedLanguage == Language.Kurdish
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 55.0,
                child: DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    labelText: widget.selectedLanguage == Language.Arabic ? 'اليوم' :
                    widget.selectedLanguage == Language.Persian ? 'روز' :
                    widget.selectedLanguage == Language.Kurdish ? 'ڕۆژ' :
                    'Day',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100]!,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFF5CBBE3)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey[100]!, width: 1.0),
                    ),
                  ),
                  value: selectedDay,
                  items: List.generate(31, (index) => index + 1).map((day) {
                    return DropdownMenuItem<int>(
                      value: day,
                      child: Text(
                        day.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (int? value) {
                    setState(() {
                      selectedDay = value!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 55.0,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: widget.selectedLanguage == Language.Arabic ? 'الشهر' :
                    widget.selectedLanguage == Language.Persian ? 'ماه' :
                    widget.selectedLanguage == Language.Kurdish ? 'مانگ' :
                    'Month',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100]!,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Color(0xFF5CBBE3)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey[100]!, width: 1.0),
                    ),
                  ),
                  value: selectedMonth,
                  items: List.generate(12, (index) {
                    final month = index + 1;
                    return DropdownMenuItem<String>(
                      value: month.toString(),
                      child: Text(
                        month.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMonth = value!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 55.0,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: widget.selectedLanguage == Language.Arabic ? 'السنة' :
                    widget.selectedLanguage == Language.Persian ? 'سال' :
                    widget.selectedLanguage == Language.Kurdish ? 'ساڵ' :
                    'Year',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100]!,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Color(0xFF5CBBE3)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey[100]!, width: 1.0),
                    ),
                  ),
                  value: selectedYear,
                  items: List.generate(DateTime.now().year - 1900 + 1, (index) {
                    final year = DateTime.now().year - index;
                    return DropdownMenuItem<String>(
                      value: year.toString(),
                      child: Text(
                        year.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ],
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
  Widget _buildPhoneNumbersSection() {
    List<Widget> phoneFields = [];

    for (int i = 0; i < phoneControllers.length; i++) {
      phoneFields.add(
        Column(
          crossAxisAlignment: widget.selectedLanguage == Language.Arabic
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey[300]!),
                color: Colors.grey[100],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: IntlPhoneField(
                        decoration: InputDecoration(
                          labelText: widget.selectedLanguage == Language.Arabic
                              ? 'رقم الهاتف'
                              : widget.selectedLanguage == Language.Persian
                              ? 'شماره تلفن'
                              : widget.selectedLanguage == Language.Kurdish
                              ? 'ژمارەی تەلەفۆن'
                              : 'Phone Number',
                          border: InputBorder.none,
                        ),
                        initialCountryCode: 'TR',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      );
    }
    return Column(children: phoneFields);
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
  Widget _buildBloodTypeDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey[300]!, width: 1.0),
        color: Colors.grey[100],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedBloodType.isNotEmpty ? selectedBloodType : null,
          items: bloodTypeOptions.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedBloodType = value!;
            });
          },
          hint: Text(
            widget.selectedLanguage == Language.Arabic ? 'فصيلة الدم' :
            widget.selectedLanguage == Language.Persian ? 'گروه خون' :
            widget.selectedLanguage == Language.Kurdish ? 'جۆری خوێن' :
            'Blood Type',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          isExpanded: true,
        ),
      ),
    );
  }
  Widget _buildEmergencyContactAddressTitle() {
    return Text(
      widget.selectedLanguage == Language.Arabic ? 'العنوان ' :
      widget.selectedLanguage == Language.Persian ? 'آدرس تماس اضطراری' :
      widget.selectedLanguage == Language.Kurdish
          ? 'ناونیشانی پەیوەندیی ئەرکی'
          :
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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTextField(
          widget.selectedLanguage == Language.Arabic
              ? 'البلد'
              : widget.selectedLanguage == Language.Persian
              ? 'کشور'
              : widget.selectedLanguage == Language.Kurdish
              ? 'وڵات'
              : 'Country',
          emergencyContactaddress1,
        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic
              ? 'المحافظة'
              : widget.selectedLanguage == Language.Persian
              ? 'استان'
              : widget.selectedLanguage == Language.Kurdish
              ? 'پارێزگا'
              : 'Province',
          emergencyContactaddress2,
        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic
              ? 'القضاء'
              : widget.selectedLanguage == Language.Persian
              ? 'قضاوت'
              : widget.selectedLanguage == Language.Kurdish
              ? 'دادوەری'
              : 'Judiciary',
          emergencyContactadress3,
        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic ? 'الزقاق'
              : widget.selectedLanguage == Language.Persian ? 'کوچه'
              : widget.selectedLanguage == Language.Kurdish
              ? 'کۆڵانەوە'
              : 'Alley',

          emergencyContactadress4,
        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic ? 'الدار'
              : widget.selectedLanguage == Language.Persian ? 'خانه'
              : widget.selectedLanguage == Language.Kurdish ? 'خانوو' : 'House',
          emergencyContactadress5,
        ),
        SizedBox(height: 8),
        _buildPhoneNumbersSection(),
        SizedBox(height: 8),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF1EE),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(50),
                  height: 700,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF5CBBE3),
                        Color(0xFF3A8ED0)],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(100),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    // decoration: BoxDecoration(
                    //   shape: BoxShape.circle,
                    //   image: DecorationImage(
                    //     image: AssetImage('assets/images/iii.png'),
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: SizedBox(
                      height: 900,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100),
                        ),
                        child:Container(
                          constraints: BoxConstraints(
                            // minHeight: 25,
                            minWidth: double.infinity,
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                            ),
                            color: Colors.white,
                          ),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(15),
                            child: Directionality(
                              textDirection: widget.selectedLanguage ==
                                  Language.Arabic ||
                                  widget.selectedLanguage == Language.Persian ||
                                  widget.selectedLanguage == Language.Kurdish
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              child: Column(
                                crossAxisAlignment: widget.selectedLanguage ==
                                    Language.Arabic ||
                                    widget.selectedLanguage == Language.Persian ||
                                    widget.selectedLanguage == Language.Kurdish
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.end,
                                children: [
                                  _buildSectionTitle(
                                    widget.selectedLanguage == Language.Arabic ? 'البيانات الشخصية للزائر' :
                                    widget.selectedLanguage == Language.Persian ? 'اطلاعات شخصی بازدیدکنندگان' :
                                    widget.selectedLanguage == Language.Kurdish ? 'داتای کەسی سەردانکەرەوە' :
                                    'Visitor personal data',
                                  ),
                                  _buildNameFields(),
                                  SizedBox(height: 16),
                                  // SizedBox(height: 16),
                                  _buildDateOfBirthField(),
                                  SizedBox(height: 16),
                                  _buildGenderDropdown(),
                                  SizedBox(height: 16),
                                  _buildPhoneNumbersSection(),
                                  SizedBox(height: 16),
                                  _buildAddressTitle(),
                                  SizedBox(height: 16),
                                  _buildAddressFields(),
                                  SizedBox(height: 16),
                                  _buildBloodTypeDropdown(),
                                  SizedBox(height: 16),
                                  CustomTextField(
                                    widget.selectedLanguage == Language.Arabic ? 'الأمراض المزمنة والعلاجات المأخوذة'
                                        : widget.selectedLanguage ==
                                        Language.Persian ? 'بیماری‌های مزمن و درمان‌های انجام‌شده'
                                        : widget.selectedLanguage ==
                                        Language.Kurdish ? 'نەخۆشییەکانی دوامدار و چارەسەرەکانی بەکارهێنراو'
                                        : 'Chronic Diseases and Taken Treatments',
                                    chronicDiseasesController,
                                    textStyle: TextStyle(                       fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,),
                                  ),
                                  SizedBox(height: 16),
                                  CustomTextField(
                                    widget.selectedLanguage == Language.Arabic ? 'المواد والأدوية التي يتحسس منها الزائر'
                                        : widget.selectedLanguage ==
                                        Language.Persian ? 'مواد و داروهایی که بازدید کننده حساسیت نشان می‌دهد'
                                        : widget.selectedLanguage ==
                                        Language.Kurdish ? 'مادە و دەرمانەکان کە سەردانکەر حەساسیتیان پێیە'
                                        : 'Substances and Medicines Visitor is Allergic to',
                                    allergiesController,
                                    textStyle: TextStyle(
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  _buildSectionTitle(
                                    widget.selectedLanguage == Language.Arabic ? 'معلومات شخص مقرب'
                                        : widget.selectedLanguage ==
                                        Language.Persian ? 'اطلاعات نزدیک شخص'
                                        : widget.selectedLanguage ==
                                        Language.Kurdish ? 'زانیاری کەسێکی نزیک'
                                        : 'Close Person Information',
                                  ),
                                  CustomTextField(
                                    widget.selectedLanguage == Language.Arabic ? 'الاسم'
                                        : widget.selectedLanguage ==
                                        Language.Persian ? 'نام '
                                        : widget.selectedLanguage ==
                                        Language.Kurdish ? 'ناوی کەسەکە'
                                        : 'Person\'s Name',
                                    emergencyContactNameController,
                                    textStyle: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  _buildEmergencyContactAddressTitle(),
                                  _buildEmergencyContactAddressFields(),
                                  CustomTextField(
                                    widget.selectedLanguage == Language.Arabic ? 'صلة القرابة'
                                        : widget.selectedLanguage ==
                                        Language.Persian ? 'رابطه خویشاوندی'
                                        : widget.selectedLanguage ==
                                        Language.Kurdish ? 'پەیوەندیی خیزانی'
                                        : 'Relationship',
                                    emergencyContactRelationshipController,
                                    textStyle: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MainScreen(selectedLanguage: widget.selectedLanguage,),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(double.infinity, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ).copyWith(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith(
                                            (states) {
                                          LinearGradient gradient = LinearGradient(
                                            colors: [
                                              Color(0xFF5CBBE3),
                                              Color(0xFF5CBBE3),
                                            ],
                                          );
                                          return gradient.colors.first;
                                        },
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.selectedLanguage == Language.Arabic ? 'حفظ'
                                              : widget.selectedLanguage ==
                                              Language.Persian ? 'ذخیره'
                                              : widget.selectedLanguage ==
                                              Language.Kurdish ? 'پاشکەوتکردن'
                                              : 'Save',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),)
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
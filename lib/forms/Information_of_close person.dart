import 'package:flutter/material.dart';
import 'cusstom.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../languages/lang.dart';
import 'package:medicapp/home_page_all/home.dart';

void main() {
  runApp(
    MaterialApp(
      home: PersonalInfoPage(selectedLanguage: Language.Arabic), // Provide a default value
    ),
  );
}

class PersonalInfoPage extends StatefulWidget {
  final Language selectedLanguage;
  PersonalInfoPage({required this.selectedLanguage});
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}
class _PersonalInfoPageState extends State<PersonalInfoPage> {
  late List<String> genderOptions; // Initialize later in initState
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
  TextEditingController chronicDiseasesController = TextEditingController();
  TextEditingController allergiesController = TextEditingController();

  String? selectedGender;
  int? selectedDay;
  String? selectedMonth;
  String? selectedYear;
  List<TextEditingController> phoneControllers = List.generate(
      3, (_) => TextEditingController());

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
            color: Colors.white
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
                      return widget.selectedLanguage == Language.Arabic
                          ? 'يرجى إدخال الاسم الأول'
                          :
                      widget.selectedLanguage == Language.Persian
                          ? 'لطفاً نام اول را وارد کنید'
                          :
                      widget.selectedLanguage == Language.Kurdish
                          ? 'تکایە ناوی یەکەم داخل بکە'
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
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!, width: 1.0),
        color: Colors.grey[100],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedGender,
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
  }

  Widget _buildDateOfBirthField() {
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
                    labelText: widget.selectedLanguage == Language.Arabic
                        ? 'اليوم'
                        :
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
                      borderSide: BorderSide(
                          color: Colors.grey[100]!, width: 1.0),
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
                    labelText: widget.selectedLanguage == Language.Arabic
                        ? 'الشهر'
                        :
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
                      borderSide: BorderSide(
                          color: Colors.grey[100]!, width: 1.0),
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
                    labelText: widget.selectedLanguage == Language.Arabic
                        ? 'السنة'
                        :
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
                      borderSide: BorderSide(
                          color: Colors.grey[100]!, width: 1.0),
                    ),
                  ),
                  value: selectedYear,
                  items: List.generate(DateTime
                      .now()
                      .year - 1900 + 1, (index) {
                    final year = DateTime
                        .now()
                        .year - index;
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
    return Column(
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
                    initialCountryCode: 'iraq',
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

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.selectedLanguage == Language.Arabic ||
          widget.selectedLanguage == Language.Persian ||
          widget.selectedLanguage == Language.Kurdish
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF5CBBE3),
                    Color(0xFF5CBBE3),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0, left: 22),
                child: _buildSectionTitle(
                  widget.selectedLanguage == Language.Arabic
                      ? 'البيانات الشخصية للزائر'
                      : widget.selectedLanguage == Language.Persian
                      ? 'اطلاعات شخصی بازدیدکنندگان'
                      : widget.selectedLanguage == Language.Kurdish
                      ? 'داتای کەسی سەردانکەرەوە'
                      : 'Visitor personal data',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildNameFields(),
                        SizedBox(height: 20),
                        _buildGenderDropdown(),
                        SizedBox(height: 20),
                        _buildAddressFields(),
                        SizedBox(height: 16),
                        _buildPhoneNumbersSection(),
                        SizedBox(height: 20),
                        _buildDateOfBirthField(),
                        const SizedBox(height: 70),
                        Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF5CBBE3),
                                Color(0xFF5CBBE3),
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'SIGN up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 80),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "Sign in",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
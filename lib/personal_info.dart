import 'package:flutter/material.dart';
import 'home_page.dart';
import 'QRPage.dart';
class PersonalInfoPage extends StatefulWidget {
  final Language selectedLanguage;

  PersonalInfoPage({required this.selectedLanguage});

  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController fourthNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
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
  TextEditingController emergencyContactPhoneControllers=TextEditingController();
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
    return widget.selectedLanguage == Language.Arabic ? ['ذكر', 'أنثى'] : widget.selectedLanguage == Language.Persian ? ['مرد', 'زن'] : ['Male', 'Female'];
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        ageController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }
  void _addEmergencyContactPhoneNumberField(){
    setState(() {
      phoneControllers.add(TextEditingController());
    });
  }


  void _addPhoneNumberField() {
    setState(() {
      phoneControllers.add(TextEditingController());
    });
  }

  void _removePhoneNumberField(int index) {
    setState(() {
      phoneControllers.removeAt(index);
    });
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
          color:Color(0xFF00897B),
        ),
        textAlign: TextAlign.right,
      ),
    );
  }
  void _handleSaveButtonPressed(PersonalInfoPage personalInfo) {
    // عرض صفحة الرمز مع بيانات المستخدم
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return QRPage(personalInfo: personalInfo);
        },
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
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
              color: Colors.black87,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: CustomTextField(
                widget.selectedLanguage == Language.Arabic ? 'الاسم الثاني' : widget.selectedLanguage == Language.Persian ? 'نام دوم' : 'Second Name',
                fourthNameController,
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: Colors.black,
                ),
                textDirection: widget.selectedLanguage == Language.Arabic ||widget.selectedLanguage==Language.Persian? TextDirection.rtl : TextDirection.ltr,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                widget.selectedLanguage == Language.Arabic ? 'الاسم الأول' : widget.selectedLanguage == Language.Persian ? 'نام اول' : 'First Name',
                lastNameController,
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: Colors.black,
                ),
                textDirection: widget.selectedLanguage == Language.Arabic ||widget.selectedLanguage==Language.Persian? TextDirection.rtl : TextDirection.ltr,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: CustomTextField(
                widget.selectedLanguage == Language.Arabic ? 'الاسم الثالث' : widget.selectedLanguage == Language.Persian ? 'نام سوم' : 'Third Name',
                middleNameController,
                textStyle: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Cairo',
                  color: Colors.grey,
                ),
                textDirection: widget.selectedLanguage == Language.Arabic ||widget.selectedLanguage==Language.Persian? TextDirection.rtl : TextDirection.ltr,
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedGender.isNotEmpty ? selectedGender : null,
      items: genderOptions.map((String value) {
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

          }
        );
      },
      decoration: InputDecoration(
        labelText: widget.selectedLanguage == Language.Arabic ? 'الجنس' : widget.selectedLanguage == Language.Persian ? 'جنس' : 'Gender',
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDateOfBirthField() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          controller: ageController,
          decoration: InputDecoration(
            labelText: widget.selectedLanguage == Language.Arabic ? 'تاريخ الميلاد' : widget.selectedLanguage == Language.Persian ? 'تاریخ تولد' : 'Date of Birth',
            suffixIcon: Icon(Icons.calendar_today),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  Widget _buildAddressTitle() {
    return Text(
      widget.selectedLanguage == Language.Arabic ? 'العنوان' : widget.selectedLanguage == Language.Persian ? 'آدرس' : 'Address',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        fontFamily: 'Cairo',
        color: Colors.black,
      ),
      textAlign: TextAlign.right,
    );
  }
  Widget _buildPhoneNumbersSection() {
    List<Widget> phoneFields = [];

    for (int i = 0; i < phoneControllers.length; i++) {
      phoneFields.add(
        Column(
          crossAxisAlignment: widget.selectedLanguage == Language.Arabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomTextField(
                    widget.selectedLanguage == Language.Arabic ? 'رقم الهاتف' : widget.selectedLanguage == Language.Persian ? 'شماره تلفن' : 'Phone Number',
                    phoneControllers[i],
                    textDirection: widget.selectedLanguage == Language.Arabic ||widget.selectedLanguage==Language.Persian? TextDirection.rtl : TextDirection.ltr,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () {
                    _removePhoneNumberField(i);
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      );
    }
    return Column(
      crossAxisAlignment: widget.selectedLanguage == Language.Arabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        ...phoneFields,
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: _addPhoneNumberField,
          child: Text(
            widget.selectedLanguage == Language.Arabic
                ? 'إضافة رقم الهاتف'
                : widget.selectedLanguage == Language.Persian
                ? 'افزودن شماره تلفن'
                : 'Add Phone Number',
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
  Widget _buildPhoneNumbersSectionn() {
    List<Widget> phoneFields = [];

    for (int i = 0; i < phoneControllers.length; i++) {
      phoneFields.add(
        Column(
            crossAxisAlignment: widget.selectedLanguage == Language.Arabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextField(
                      widget.selectedLanguage == Language.Arabic ? 'رقم الهاتف' : widget.selectedLanguage == Language.Persian ? 'شماره تماس' : 'Phone Number',




                      phoneControllers[i],
                      textDirection: widget.selectedLanguage == Language.Arabic ||widget.selectedLanguage==Language.Persian? TextDirection.rtl : TextDirection.ltr,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () {
                      _removePhoneNumberField(i);
                    },
                  ),
                ],
              ),
            ]
        ),
      );
    }

    return Column(
      children: [
        ...phoneFields,
        ElevatedButton(
          onPressed: _addEmergencyContactPhoneNumberField,
          child: Text(widget.selectedLanguage == Language.Arabic ? 'إضافة رقم هاتف' : widget.selectedLanguage == Language.Persian ? 'افزودن شماره تلفن' : 'Add Phone Number'),

        ),
      ],
    );
  }

  Widget _buildAddressFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTextField(
          widget.selectedLanguage == Language.Arabic ? 'البلد' : widget.selectedLanguage == Language.Persian ? 'کشور' : 'Country',
          alleyController,
          textDirection: widget.selectedLanguage == Language.Arabic ||widget.selectedLanguage==Language.Persian? TextDirection.rtl : TextDirection.ltr,

        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic ? 'المحافظة' : widget.selectedLanguage == Language.Persian ? 'استان' : 'Province',

          districtController,
          textDirection: widget.selectedLanguage == Language.Arabic ||widget.selectedLanguage==Language.Persian? TextDirection.rtl : TextDirection.ltr,

        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic ? 'القضاء' : widget.selectedLanguage == Language.Persian ? 'دادگاه' : 'Judiciary',
          governorateController,
          textDirection: widget.selectedLanguage == Language.Arabic ||widget.selectedLanguage==Language.Persian? TextDirection.rtl : TextDirection.ltr,

        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic ? 'الزقاق' : widget.selectedLanguage == Language.Persian ? 'کوچه' : 'Alley',




          countryController,
          textDirection: widget.selectedLanguage == Language.Arabic ||widget.selectedLanguage==Language.Persian? TextDirection.rtl : TextDirection.ltr,

        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic ? 'الدار' : widget.selectedLanguage == Language.Persian ? 'خانه' : 'House',
          houseController,
          textDirection: widget.selectedLanguage == Language.Arabic ||widget.selectedLanguage==Language.Persian? TextDirection.rtl : TextDirection.ltr,

        ),
        SizedBox(height: 8),
        _buildPhoneNumbersSection(),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildBloodTypeDropdown() {
    return DropdownButtonFormField<String>(
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
      decoration: InputDecoration(
        labelText: widget.selectedLanguage == Language.Arabic ? 'فصيلة الدم' : widget.selectedLanguage == Language.Persian ? 'گروه خون' : 'Blood Type',




        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildEmergencyContactAddressTitle() {
    return Text(
      widget.selectedLanguage == Language.Arabic ? 'عنوان الشخص المقرب' : widget.selectedLanguage == Language.Persian ? 'آدرس تماس اضطراری' : 'Emergency Contact Address',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        fontFamily: 'Cairo',
        color: Colors.black,
      ),
      textAlign: TextAlign.right,
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
              : 'Country',
          emergencyContactAddressController,
          textDirection: widget.selectedLanguage == Language.Arabic ||widget.selectedLanguage==Language.Persian? TextDirection.rtl : TextDirection.ltr,

        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic
              ? 'المحافظة'
              : widget.selectedLanguage == Language.Persian
              ? 'استان'
              : 'Province',
          emergencyContactAddressController,
          textDirection: widget.selectedLanguage == Language.Arabic ||widget.selectedLanguage==Language.Persian? TextDirection.rtl : TextDirection.ltr,

        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic
              ? 'القضاء'
              : widget.selectedLanguage == Language.Persian
              ? 'قضاوت'
              : 'Judiciary',
          emergencyContactAddressController,
          textDirection: widget.selectedLanguage == Language.Arabic ||widget.selectedLanguage==Language.Persian? TextDirection.rtl : TextDirection.ltr,

        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic
              ? 'الزقاق'
              : widget.selectedLanguage == Language.Persian
              ? 'کوچه'
              : 'Alley',
          emergencyContactAddressController,
          textDirection: widget.selectedLanguage == Language.Arabic ||widget.selectedLanguage==Language.Persian? TextDirection.rtl : TextDirection.ltr,

        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic
              ? 'الدار'
              : widget.selectedLanguage == Language.Persian
              ? 'خانه'
              : 'House',
          emergencyContactAddressController,
          textDirection: widget.selectedLanguage == Language.Arabic ||widget.selectedLanguage==Language.Persian? TextDirection.rtl : TextDirection.ltr,

        ),
        SizedBox(height: 8),
        _buildPhoneNumbersSectionn(),


      ],

    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          child: TextField(
            textAlign: TextAlign.start,
            textDirection: widget.selectedLanguage == Language.Arabic ||widget.selectedLanguage==Language.Persian? TextDirection.rtl : TextDirection.ltr,
            decoration:InputDecoration(
              labelText: widget.selectedLanguage == Language.Arabic ? 'معلومات الزائر' : widget.selectedLanguage == Language.Persian ? 'اطلاعات شخصی' : 'Personal Information',



              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ),
        backgroundColor: Color(0xFF80CBC4),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Directionality(
          textDirection: widget.selectedLanguage == Language.Arabic ||widget.selectedLanguage==Language.Persian? TextDirection.rtl : TextDirection.ltr,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: widget.selectedLanguage == Language.Arabic ||widget.selectedLanguage==Language.Persian? TextDirection.rtl : TextDirection.ltr,
            children: [
              _buildSectionTitle(
                  widget.selectedLanguage == Language.Arabic ? 'البيانات الشخصية للزائر' : widget.selectedLanguage == Language.Persian ? 'اطلاعات شخصی بازدیدکنندگان' : 'Visitor personal data'
              ),
              _buildNameFields(),
              SizedBox(height: 16),
              _buildGenderDropdown(),
              SizedBox(height: 16),
              _buildDateOfBirthField(),
              SizedBox(height: 16),
              _buildAddressTitle(),
              _buildAddressFields(),
              _buildBloodTypeDropdown(),
              SizedBox(height: 16),
              CustomTextField(
                widget.selectedLanguage == Language.Arabic
                    ? 'الأمراض المزمنة والعلاجات المأخوذة'
                    : widget.selectedLanguage == Language.Persian
                    ? 'بیماری‌های مزمن و درمان‌های انجام‌شده'
                    : 'Chronic Diseases and Taken Treatments',
                chronicDiseasesController,
                textStyle: TextStyle(fontFamily: 'Cairo',),
                textDirection: widget.selectedLanguage == Language.Arabic ||widget.selectedLanguage==Language.Persian? TextDirection.rtl : TextDirection.ltr,

              ),
              SizedBox(height: 16),
              CustomTextField(
                widget.selectedLanguage == Language.Arabic
                    ? 'المواد والأدوية التي يتحسس منها الزائر'
                    : widget.selectedLanguage == Language.Persian
                    ? 'مواد و داروهایی که بازدید کننده حساسیت نشان می‌دهد'
                    : 'Substances and Medicines Visitor is Allergic to',

                allergiesController,
                textStyle: TextStyle(
                  fontFamily: 'Cairo',
                ),
                textDirection: widget.selectedLanguage == Language.Arabic ||widget.selectedLanguage==Language.Persian? TextDirection.rtl : TextDirection.ltr,

              ),
              SizedBox(height: 16),
              _buildSectionTitle(
                widget.selectedLanguage == Language.Arabic
                    ? 'معلومات شخص مقرب'
                    : widget.selectedLanguage == Language.Persian
                    ? 'اطلاعات نزدیک شخص'
                    : 'Close Person Information',),
              CustomTextField(
                widget.selectedLanguage == Language.Arabic
                    ? 'اسم الشخص'
                    : widget.selectedLanguage == Language.Persian
                    ? 'نام شخص'
                    : 'Person\'s Name',
                emergencyContactNameController,
                textStyle: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: Color(0xFF80CBC4),
                ),
                textDirection: widget.selectedLanguage == Language.Arabic ||widget.selectedLanguage==Language.Persian? TextDirection.rtl : TextDirection.ltr,

              ),

              SizedBox(height: 20),
              _buildEmergencyContactAddressTitle(),
              _buildEmergencyContactAddressFields(),
              CustomTextField(
                widget.selectedLanguage == Language.Arabic
                    ? 'صلة القرابة'
                    : widget.selectedLanguage == Language.Persian
                    ? 'رابطه خویشاوندی'
                    : 'Relationship',
                emergencyContactRelationshipController,
                textStyle: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: Colors.red,
                ),
                textDirection: widget.selectedLanguage == Language.Arabic ||widget.selectedLanguage==Language.Persian? TextDirection.rtl : TextDirection.ltr,


              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF80CBC4),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.selectedLanguage == Language.Arabic
                          ? 'حفظ'
                          : widget.selectedLanguage == Language.Persian
                          ? 'ذخیره'
                          : 'Save',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Cairo',
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
    );
  }
}
class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextStyle textStyle;
  final TextDirection textDirection;
  final IconData? icon; // Optional icon

  CustomTextField(this.hintText, this.controller, {this.textStyle = const TextStyle(fontSize: 18,color: Colors.black,fontFamily: 'Cairo'), required this.textDirection, this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: textStyle,
      textDirection: textDirection,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon != null ? Icon(icon) : null,
        hintStyle: TextStyle(color: Colors.black, fontSize: 18,fontFamily: 'Cairo'),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../languages/lang.dart';
import 'Medical_information.dart';
import 'cusstom.dart';

class PersonalInformationPage extends StatefulWidget {
  final Language selectedLanguage;
  PersonalInformationPage({required this.selectedLanguage});

  @override
  _PersonalInformationPageState createState() => _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController fourthNameController = TextEditingController();
  List<TextEditingController> phoneControllers = [TextEditingController()];
  TextEditingController countryController = TextEditingController();
  TextEditingController governorateController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController alleyController = TextEditingController();
  TextEditingController houseController = TextEditingController();

  int? selectedDay;
  String? selectedMonth;
  String? selectedYear;
  String selectedGender = '';
  List<String> genderOptions = [];

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

  Widget _buildNameFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: CustomTextField(
                widget.selectedLanguage == Language.Arabic ? 'الاسم الاول' :
                widget.selectedLanguage == Language.Persian ? 'نام اول' :
                widget.selectedLanguage == Language.Kurdish ? 'ناوی یەکەم' :
                'First Name',
                fourthNameController,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                widget.selectedLanguage == Language.Arabic ? 'الاسم الثاني' :
                widget.selectedLanguage == Language.Persian ? 'نام دوم' :
                widget.selectedLanguage == Language.Kurdish ? 'ناوی دووهەم' :
                'Second Name',
                lastNameController,
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
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateOfBirthField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.selectedLanguage == Language.Arabic ? 'تاريخ الميلاد' :
          widget.selectedLanguage == Language.Persian ? 'تاریخ تولد' :
          widget.selectedLanguage == Language.Kurdish ? 'رێکەوتی لەدایکبوون' :
          'Date of Birth',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: 'Day'),
                value: selectedDay,
                items: List.generate(31, (index) => index + 1).map((day) {
                  return DropdownMenuItem<int>(
                    value: day,
                    child: Text(day.toString()),
                  );
                }).toList(),
                onChanged: (int? value) {
                  setState(() {
                    selectedDay = value!;
                  });
                },
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Month'),
                value: selectedMonth,
                items: List.generate(12, (index) {
                  final month = index + 1;
                  return DropdownMenuItem<String>(
                    value: month.toString(),
                    child: Text(month.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMonth = value!;
                  });
                },
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Year'),
                value: selectedYear,
                items: List.generate(DateTime.now().year - 1900 + 1, (index) {
                  final year = DateTime.now().year - index;
                  return DropdownMenuItem<String>(
                    value: year.toString(),
                    child: Text(year.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedYear = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: widget.selectedLanguage == Language.Arabic ? 'الجنس' :
        widget.selectedLanguage == Language.Persian ? 'جنس' :
        widget.selectedLanguage == Language.Kurdish ? 'رەگەز' :
        'Gender',
      ),
      value: selectedGender.isNotEmpty ? selectedGender : null,
      items: genderOptions.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedGender = value!;
        });
      },
    );
  }

  Widget _buildPhoneNumbersSection() {
    return Column(
      children: phoneControllers.map((controller) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: IntlPhoneField(
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
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAddressFields() {
    return Column(
      children: [
        CustomTextField(
          widget.selectedLanguage == Language.Arabic ? 'البلد' :
          widget.selectedLanguage == Language.Persian ? 'کشور' :
          widget.selectedLanguage == Language.Kurdish ? 'وڵات' :
          'Country',
          countryController,
        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic ? 'المحافظة' :
          widget.selectedLanguage == Language.Persian ? 'استان' :
          widget.selectedLanguage == Language.Kurdish ? 'پارێزگا' :
          'Province',
          governorateController,
        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic ? 'القضاء' :
          widget.selectedLanguage == Language.Persian ? 'دادگاه' :
          widget.selectedLanguage == Language.Kurdish ? 'دادگا' :
          'Judiciary',
          districtController,
        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic ? 'الزقاق' :
          widget.selectedLanguage == Language.Persian ? 'کوچه' :
          widget.selectedLanguage == Language.Kurdish ? 'کۆڵان' :
          'Alley',
          alleyController,
        ),
        SizedBox(height: 8),
        CustomTextField(
          widget.selectedLanguage == Language.Arabic ? 'الدار' :
          widget.selectedLanguage == Language.Persian ? 'خانه' :
          widget.selectedLanguage == Language.Kurdish ? 'ماڵ' :
          'House',
          houseController,
        ),
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
          colors: [Color(0xFF5CBBE3), Color(0xFF3A8ED0)],
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
    child: Container(
    constraints: BoxConstraints(
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
    textDirection: widget.selectedLanguage == Language.Arabic ||
    widget.selectedLanguage == Language.Persian ||
    widget.selectedLanguage == Language.Kurdish
    ? TextDirection.rtl
        : TextDirection.ltr,
    child: Column(
    crossAxisAlignment: widget.selectedLanguage == Language.Arabic ||
    widget.selectedLanguage == Language.Persian ||
    widget.selectedLanguage == Language.Kurdish
    ? CrossAxisAlignment.start
        : CrossAxisAlignment.end,
    children: [
            _buildNameFields(),
            SizedBox(height: 16),
            _buildDateOfBirthField(),
            SizedBox(height: 16),
            _buildGenderDropdown(),
            SizedBox(height: 16),
            _buildPhoneNumbersSection(),
            SizedBox(height: 16),
            Text('Address', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            _buildAddressFields(),
            SizedBox(height: 24),
            ElevatedButton(
              child: Text('Next'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedicalInformationPage(selectedLanguage: widget.selectedLanguage),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
    ),
    ),
    );
  }
}
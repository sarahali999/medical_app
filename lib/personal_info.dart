
import 'package:flutter/material.dart';

class PersonalInfoPage extends StatefulWidget {
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
  TextEditingController emergencyContactAddressController =
  TextEditingController();
  TextEditingController emergencyContactRelationshipController =
  TextEditingController();
  TextEditingController medicalHistoryController = TextEditingController();
  List<TextEditingController> phoneControllers = [TextEditingController()];

  List<String> genderOptions = ['ذكر', 'أنثى'];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          child: TextField(
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              hintText:'معلومات الزائر',

              hintStyle: TextStyle(color: Colors.white,fontSize: 22),
            ),
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: [
            _buildSectionTitle('البيانات الشخصية'),
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
              'الأمراض المزمنة والعلاجات المأخوذة',
              chronicDiseasesController,
            ),
            SizedBox(height: 16),
            CustomTextField(
              'المواد والأدوية التي يتحسس منها الزائر',
              allergiesController,
            ),
            SizedBox(height: 16),
            _buildSectionTitle('معلومات شخص مقرب'),
            CustomTextField('اسم الشخص ', emergencyContactNameController,
                textStyle: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                )),
            SizedBox(height: 16),
            CustomTextField(
              'رقم هاتفه',
              emergencyContactPhoneController,
              textStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 16),
            _buildEmergencyContactAddressTitle(),
            _buildEmergencyContactAddressFields(),
            CustomTextField(
              'صلة القرابة',
              emergencyContactRelationshipController,
              textStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlueAccent,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.save, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'حفظ',
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
          color: Theme.of(context).colorScheme.primary,
        ),
        textAlign: TextAlign.right,
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
                'الاسم الثاني',
                fourthNameController,
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

            ),
            SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                'الاسم الأول',
                lastNameController,
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
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
                'الاسم الرابع',
                middleNameController,
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                'الاسم الثالث',
                firstNameController,
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        Divider(
          height: 2,
          thickness: 2,
        )
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'الجنس',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.right,
        ),
        DropdownButtonFormField(
          value: selectedGender.isNotEmpty ? selectedGender : null,
          items: genderOptions.map((String gender) {
            return DropdownMenuItem(
              value: gender,
              child: Text(
                gender,
                style: TextStyle(fontSize: 16),
              ),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              selectedGender = value ?? '';
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDateOfBirthField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'تاريخ الميلاد',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.right,
        ),
        TextFormField(
          controller: ageController,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: 'حدد تاريخ الميلاد',
            hintStyle: TextStyle(fontSize: 18),
            border: OutlineInputBorder(),
            suffixIcon: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Icon(Icons.calendar_today),
              ),
            ),
          ),


          onTap: () => _selectDate(context),
          readOnly: true,
        ),
      ],
    );
  }

  Widget _buildAddressTitle() {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(bottom: 8),
      child: Text(
        'العنوان',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildAddressFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField('المحافظة', countryController),
            ),
            SizedBox(width: 16),
            Expanded(
              child: CustomTextField('الدولة', governorateController),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CustomTextField('الزقاق', districtController),
            ),
            SizedBox(width: 16),
            Expanded(
              child: CustomTextField('القضاء', alleyController),
            ),
          ],
        ),
        SizedBox(height: 16),
        CustomTextField('الدار', houseController),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildBloodTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'فئة الدم',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.right,
        ),
        DropdownButtonFormField(
          value: selectedBloodType.isNotEmpty ? selectedBloodType : null,
          items: bloodTypeOptions.map((String bloodType) {
            return DropdownMenuItem(
              value: bloodType,
              child: Text(
                bloodType,
                style: TextStyle(fontSize: 16),
              ),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              selectedBloodType = value ?? ' ';
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildEmergencyContactAddressTitle() {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(bottom: 8),
      child: Text(
        'عنوانه',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildEmergencyContactAddressFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField('المحافظة', countryController),
            ),
            SizedBox(width: 16),
            Expanded(
              child: CustomTextField('الدولة', governorateController),
            ),
          ],
        ),
        SizedBox(height: 1),
        Row(
          children: [
            Expanded(
              child: CustomTextField('الزقاق', districtController),
            ),
            SizedBox(width: 10),
            Expanded(
              child: CustomTextField('القضاء', alleyController),
            ),
          ],
        ),
        SizedBox(height: 0),
        CustomTextField('الدار', houseController),
        SizedBox(height: 16),
      ],
    );
  }

  void _addPhone() {
    setState(() {
      phoneControllers.add(TextEditingController());
    });
  }
}

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextAlign textAlign;
  final TextStyle textStyle;

  CustomTextField(this.labelText, this.controller,
      {this.textAlign = TextAlign.right, this.textStyle = const TextStyle()});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: labelText == 'اسم الشخص'
                ? Colors.black87
                : labelText == 'رقم هاتفه'
                ? Colors.black87
                : labelText == 'صلة القرابة'
                ? Colors.black87
                : Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 50,
          child: TextFormField(
            controller: controller,
            textAlign: textAlign,
            style: labelText == 'اسم الشخص'
                ? TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            )
                : labelText == 'رقم هاتفه'
                ? TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            )
                : labelText == 'صلة القرابة'
                ? TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            )
                : textStyle,
            decoration: InputDecoration(
              contentPadding:
              EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

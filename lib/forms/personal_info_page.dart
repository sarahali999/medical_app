import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'section_title.dart';
import '../languages/lang.dart';
import 'cusstom.dart';
class PersonalInfoPage extends StatelessWidget {
  final Language selectedLanguage;
  final TextEditingController fourthNameController;
  final TextEditingController lastNameController;
  final TextEditingController middleNameController;
  final TextEditingController alleyController;
  final TextEditingController districtController;
  final TextEditingController governorateController;
  final TextEditingController countryController;
  final TextEditingController houseController;
  final String selectedGender;
  final int? selectedDay;
  final String? selectedMonth;
  final String? selectedYear;
  final Function(String?) onGenderChanged;
  final Function(String?) onDayChanged;
  final Function(String?) onMonthChanged;
  final Function(String?) onYearChanged;

  PersonalInfoPage({
    required this.selectedLanguage,
    required this.fourthNameController,
    required this.lastNameController,
    required this.middleNameController,
    required this.alleyController,
    required this.districtController,
    required this.governorateController,
    required this.countryController,
    required this.houseController,
    required this.selectedGender,
    required this.selectedDay,
    required this.selectedMonth,
    required this.selectedYear,
    required this.onGenderChanged,
    required this.onDayChanged,
    required this.onMonthChanged,
    required this.onYearChanged,
  });

  @override
  Widget build(BuildContext context) {
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
                getLocalizedText('الاسم الاول', 'نام اول', 'First Name', 'ناوی یەکەم', ''),
                fourthNameController,
                textStyle: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return getLocalizedText('يرجى إدخال الاسم الأول', 'لطفاً نام اول را وارد کنید', 'Please enter the first name', 'تکایە ناوی یەکەم داخل بکە', '');
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                getLocalizedText('الاسم الثاني', 'نام دوم', 'Second Name', 'ناوی دووهەم', ''),
                lastNameController,
                textStyle: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return getLocalizedText('يرجى إدخال الاسم الثاني', 'لطفاً نام دوم را وارد کنید', 'Please enter the second name', 'تکایە ناوی دووهەم داخل بکە', '');
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                getLocalizedText('الاسم الثالث', 'نام سوم', 'Third Name', 'ناوی سێیەم', ''),
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
      ],
    );
  }

  Widget _buildAddressTitle() {
    return Text(
      getLocalizedText('العنوان', 'آدرس', 'Address', 'ناونیشان', ''),
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
          getLocalizedText('البلد', 'کشور', 'Country', 'وڵات', ''),
          alleyController,
        ),
        SizedBox(height: 8),
        CustomTextField(
          getLocalizedText('المحافظة', 'استان', 'Province', 'پارێزگا', ''),
          districtController,
        ),
        SizedBox(height: 8),
        CustomTextField(
          getLocalizedText('القضاء', 'دادگاه', 'Judiciary', 'دادگا', ''),
          governorateController,
        ),
        SizedBox(height: 8),
        CustomTextField(
          getLocalizedText('الزقاق', 'کوچه', 'Alley', 'کۆڵان', ''),
          countryController,
        ),
        SizedBox(height: 8),
        CustomTextField(
          getLocalizedText('الدار', 'خانه', 'House', 'ماڵ', ''),
          houseController,
        ),
        SizedBox(height: 8),
      ],
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
        onChanged: onGenderChanged,
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
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildDateDropdown(
                  getLocalizedText('اليوم', 'روز', 'Day', 'ڕۆژ', ''),
                  List.generate(31, (index) => (index + 1).toString()),
                  selectedDay?.toString(),
                  onDayChanged,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildDateDropdown(
                  getLocalizedText('الشهر', 'ماه', 'Month', 'مانگ', ''),
                  List.generate(12, (index) => (index + 1).toString()),
                  selectedMonth,
                  onMonthChanged,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildDateDropdown(
                  getLocalizedText('السنة', 'سال', 'Year', 'ساڵ', ''),
                  List.generate(DateTime.now().year - 1900 + 1, (index) => (DateTime.now().year - index).toString()),
                  selectedYear,
                  onYearChanged,
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
            initialCountryCode: 'IQ',
            onChanged: (phone) {
              print(phone.completeNumber);
            },
          ),
        ],
      ),
    );
  }

  List<String> _getGenderOptions() {
    switch (selectedLanguage) {
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

  String getLocalizedText(String arabic, String persian, String english, String kurdish, String defaultText) {
    switch (selectedLanguage) {
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
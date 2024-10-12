import 'package:flutter/material.dart';
import 'section_title.dart';
import '../languages/lang.dart';
import 'cusstom.dart';

class PersonalInfoPage extends StatelessWidget {
  final Language selectedLanguage;
  final TextEditingController firstname;
  final TextEditingController lastNameController;
  final TextEditingController middleNameController;
  final TextEditingController alleyController;
  final TextEditingController districtController;
  final TextEditingController governorateController;
  final TextEditingController countryController;
  final TextEditingController houseController;

  final int selectedGender;
  final int? selectedDay;
  final String? selectedMonth;
  final String? selectedYear;
  final Function(int?) onGenderChanged;
  final Function(String?) onDayChanged;
  final Function(String?) onMonthChanged;
  final Function(String?) onYearChanged;

  PersonalInfoPage({
    required this.selectedLanguage,
    required this.firstname,
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
    final localizations = AppLocalizations(selectedLanguage);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: localizations.personalInformation),
        SizedBox(height: 1),
        _buildNameFields(localizations),
        _buildAddressTitle(localizations),
        _buildAddressFields(localizations),
        _buildGenderDropdown(localizations),
        _buildDateOfBirthField(localizations),
      ],
    );
  }

  Widget _buildNameFields(AppLocalizations localizations) {
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
                localizations.firstName,
                firstname,
                textStyle: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                localizations.secondName,
                lastNameController,
                textStyle: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                localizations.thirdName,
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

  Widget _buildAddressTitle(AppLocalizations localizations) {
    return Text(
      localizations.address,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildAddressFields(AppLocalizations localizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTextField(
          localizations.country,
          alleyController,
        ),
        SizedBox(height: 8),
        CustomTextField(
          localizations.province,
          districtController,
        ),
        SizedBox(height: 8),
        CustomTextField(
          localizations.judiciary,
          governorateController,
        ),
        SizedBox(height: 8),
        CustomTextField(
          localizations.alley,
          countryController,
        ),
        SizedBox(height: 8),
        CustomTextField(
          localizations.house,
          houseController,
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildGenderDropdown(AppLocalizations localizations) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<int>(
        value: selectedGender != null && (selectedGender == 1 || selectedGender == 2)
            ? selectedGender
            : 1, // Default to 'Male' if null or invalid
        items: _getGenderOptions(localizations).map((option) {
          return DropdownMenuItem<int>(
            value: option['key'],
            child: Text(
              option['value'],
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          );
        }).toList(),
        onChanged: (int? newValue) {
          if (newValue != null) {
            onGenderChanged(newValue);
          }
        },
        decoration: InputDecoration(
          labelText: localizations.gender,
          labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildDateOfBirthField(AppLocalizations localizations) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.dateOfBirth,
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
                  localizations.day,
                  List.generate(31, (index) => (index + 1).toString()),
                  selectedDay?.toString(),
                  onDayChanged,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildDateDropdown(
                  localizations.month,
                  List.generate(12, (index) => (index + 1).toString()),
                  selectedMonth,
                  onMonthChanged,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildDateDropdown(
                  localizations.year,
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
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }

  List<Map<String, dynamic>> _getGenderOptions(AppLocalizations localizations) {
    return [
      {
        "value": localizations.male,
        "key": 1
      },
      {
        "value": localizations.female,
        "key": 2
      },
    ];
  }
}
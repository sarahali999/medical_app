import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/UserDetails.dart';

class EditProfilePage extends StatefulWidget {
  final Data userData;

  const EditProfilePage({Key? key, required this.userData}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _secondNameController;
  late TextEditingController _thirdNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _chronicDiseasesController;
  late TextEditingController _allergiesController;
  late TextEditingController _emergencyContactNameController;
  late TextEditingController _emergencyContactPhoneController;

  int? _selectedGender;
  int? _selectedBloodType;
  int? _selectedEmergencyContactRelationship;
  bool _isLoading = false;

  final Color _primaryColor = Color(0xFF5BB9AE);
  final Color _secondaryColor = Color(0xFF2B5D44);
  final Color _accentColor = Color(0xFFE0FBFC);

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _firstNameController = TextEditingController(text: widget.userData.user?.firstName);
    _secondNameController = TextEditingController(text: widget.userData.user?.secondName);
    _thirdNameController = TextEditingController(text: widget.userData.user?.thirdName);
    _emailController = TextEditingController(text: widget.userData.user?.email);
    _phoneController = TextEditingController(text: widget.userData.user?.phoneNumber);
    _addressController = TextEditingController(text: widget.userData.address);
    _chronicDiseasesController = TextEditingController(text: widget.userData.chronicDiseases);
    _allergiesController = TextEditingController(text: widget.userData.allergies);
    _emergencyContactNameController = TextEditingController(text: widget.userData.emergencyContactFullName);
    _emergencyContactPhoneController = TextEditingController(text: widget.userData.emergencyContactPhoneNumber);

    _selectedGender = widget.userData.gender;
    _selectedBloodType = widget.userData.bloodType;
    _selectedEmergencyContactRelationship = widget.userData.emergencyContactRelationship;
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    _firstNameController.dispose();
    _secondNameController.dispose();
    _thirdNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _chronicDiseasesController.dispose();
    _allergiesController.dispose();
    _emergencyContactNameController.dispose();
    _emergencyContactPhoneController.dispose();
  }
  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final String? jwtToken = prefs.getString('token');

        if (jwtToken == null) {
          throw Exception('JWT token is missing');
        }

        print('JWT Token: $jwtToken'); // Log the token for debugging

        final Map<String, dynamic> requestBody = _getUpdatedUserData();
        print('Request Body: ${json.encode(requestBody)}'); // Log the request body

        final response = await http.put(
          Uri.parse('https://medicalpoint-api.tatwer.tech/api/Mobile/UpdatePatientDetails'),
          headers: {
            'Authorization': 'Bearer $jwtToken',
            'Content-Type': 'application/json',
          },
          body: json.encode(requestBody),
        );

        print('Response Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تم تحديث الملف الشخصي بنجاح')),
          );
          Navigator.pop(context, true);
        } else {
          throw Exception('Failed to update profile: ${response.statusCode}');
        }
      } catch (e) {
        print('Exception occurred: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل تحديث الملف الشخصي: $e')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  Map<String, dynamic> _getUpdatedUserData() {
    return {
      "firstName": _firstNameController.text,
      "secondName": _secondNameController.text,
      "thirdName": _thirdNameController.text,
      "gender": _selectedGender,
      "address": _addressController.text,
      "birthYear": widget.userData.birthYear,
      "country": widget.userData.country,
      "province": widget.userData.province,
      "district": widget.userData.district,
      "alley": widget.userData.alley,
      "house": widget.userData.house,
      "bloodType": _selectedBloodType,
      "email": _emailController.text,
      "chronicDiseases": _chronicDiseasesController.text,
      "allergies": _allergiesController.text,
      "emergencyContactFullName": _emergencyContactNameController.text,
      "emergencyContactAddress": widget.userData.emergencyContactAddress,
      "emergencyContactCountry": widget.userData.emergencyContactCountry,
      "emergencyContactProvince": widget.userData.emergencyContactProvince,
      "emergencyContactDistrict": widget.userData.emergencyContactDistrict,
      "emergencyContactAlley": widget.userData.emergencyContactAlley,
      "emergencyContactHouse": widget.userData.emergencyContactHouse,
      "emergencyContactPhoneNumber": _emergencyContactPhoneController.text,
      "emergencyContactRelationship": _selectedEmergencyContactRelationship,
      "phoneNumber": _phoneController.text,
      "username": widget.userData.user?.username,
      // Add any missing fields
      "password": widget.userData.user?.password ?? "", // If available
    };
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator(color: _primaryColor))
                        : SingleChildScrollView(
                      controller: scrollController,
                      padding: EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionHeader('المعلومات الشخصية'),
                            _buildAnimatedTextField(
                              controller: _firstNameController,
                              labelText: 'الاسم الأول',
                              icon: Icons.person,
                            ),
                            _buildAnimatedTextField(
                              controller: _secondNameController,
                              labelText: 'الاسم الثاني',
                              icon: Icons.person_outline,
                            ),
                            _buildAnimatedTextField(
                              controller: _thirdNameController,
                              labelText: 'الاسم الثالث',
                              icon: Icons.person_outline,
                            ),
                            _buildAnimatedTextField(
                              controller: _emailController,
                              labelText: 'البريد الإلكتروني',
                              icon: Icons.email,
                            ),
                            _buildAnimatedTextField(
                              controller: _phoneController,
                              labelText: 'رقم الهاتف',
                              icon: Icons.phone,
                            ),
                            _buildAnimatedTextField(
                              controller: _addressController,
                              labelText: 'العنوان',
                              icon: Icons.home,
                            ),
                            _buildAnimatedDropdown(
                              value: _selectedGender,
                              label: 'الجنس',
                              items: [
                                DropdownMenuItem(child: Text('ذكر'), value: 0),
                                DropdownMenuItem(child: Text('أنثى'), value: 1),
                              ],
                              onChanged: (value) => setState(() => _selectedGender = value),
                              icon: Icons.wc,
                            ),
                            SizedBox(height: 20),
                            _buildSectionHeader('المعلومات الطبية'),
                            _buildAnimatedDropdown(
                              value: _selectedBloodType,
                              label: 'فصيلة الدم',
                              items: [
                                DropdownMenuItem(child: Text('A+'), value: 0),
                                DropdownMenuItem(child: Text('A-'), value: 1),
                                DropdownMenuItem(child: Text('B+'), value: 2),
                                DropdownMenuItem(child: Text('B-'), value: 3),
                                DropdownMenuItem(child: Text('AB+'), value: 4),
                                DropdownMenuItem(child: Text('AB-'), value: 5),
                                DropdownMenuItem(child: Text('O+'), value: 6),
                                DropdownMenuItem(child: Text('O-'), value: 7),
                              ],
                              onChanged: (value) => setState(() => _selectedBloodType = value),
                              icon: Icons.local_hospital,
                            ),
                            _buildAnimatedTextField(
                              controller: _chronicDiseasesController,
                              labelText: 'الأمراض المزمنة',
                              icon: Icons.medical_services,
                            ),
                            _buildAnimatedTextField(
                              controller: _allergiesController,
                              labelText: 'الحساسيات',
                              icon: Icons.warning,
                            ),
                            SizedBox(height: 20),
                            _buildSectionHeader('معلومات الاتصال في حالات الطوارئ'),
                            _buildAnimatedTextField(
                              controller: _emergencyContactNameController,
                              labelText: 'اسم جهة الاتصال للطوارئ',
                              icon: Icons.contact_emergency,
                            ),
                            _buildAnimatedTextField(
                              controller: _emergencyContactPhoneController,
                              labelText: 'رقم هاتف جهة الاتصال للطوارئ',
                              icon: Icons.phone_callback,
                            ),
                            _buildAnimatedDropdown(
                              value: _selectedEmergencyContactRelationship,
                              label: 'علاقة جهة الاتصال للطوارئ',
                              items: [
                                DropdownMenuItem(child: Text('الأب'), value: 0),
                                DropdownMenuItem(child: Text('الأم'), value: 1),
                                DropdownMenuItem(child: Text('الأخ'), value: 2),
                                DropdownMenuItem(child: Text('الأخت'), value: 3),
                                DropdownMenuItem(child: Text('صديق'), value: 4),
                              ],
                              onChanged: (value) => setState(() => _selectedEmergencyContactRelationship = value),
                              icon: Icons.family_restroom,
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: ElevatedButton(
                                onPressed: _updateProfile,
                                child: Text('حفظ التغييرات'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _primaryColor,
                                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ).animate().scale(duration: 300.ms, curve: Curves.easeInOut),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.close_outlined, color:
            Color(0xFF3D5A80)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    ).animate().slideY(begin: -1, end: 0, duration: 500.ms, curve: Curves.easeOutBack);
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: _secondaryColor,
        ),
      ),
    ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2, end: 0);
  }

  Widget _buildAnimatedTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon, color: _primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: _primaryColor),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 100.ms).slideX(begin: 0.2, end: 0);
  }

  Widget _buildAnimatedDropdown({
    required int? value,
    required String label,
    required List<DropdownMenuItem<int>> items,
    required Function(int?) onChanged,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<int>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: _primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: _primaryColor),
          ),
        ),
        items: items,
        onChanged: onChanged,
        icon: Icon(Icons.arrow_drop_down, color: _primaryColor),
        isExpanded: true,
        dropdownColor: _accentColor,
        style: TextStyle(color: _secondaryColor),
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 200.ms).slideX(begin: -0.2, end: 0);
  }
}


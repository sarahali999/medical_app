import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/UserDetails.dart';
import 'edit_profile_page.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Future<UserDetails> _userDetailsFuture;
  bool isLoading = false;
  String apiUrl = 'https://medicalpoint-api.tatwer.tech/api/Mobile/GetPatientDetails'; // Replace with actual API URL
  UserDetails? userInfoDetails;

  @override
  void initState() {
    super.initState();
    _userDetailsFuture = fetchUserDetails(); // Fetch user details when the widget initializes
  }

  Future<UserDetails> fetchUserDetails() async {
    setState(() {
      isLoading = true;
    });
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? jwtToken = prefs.getString('token');

      if (jwtToken == null) {
        throw Exception('JWT token is missing');
      }

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          isLoading = false;
          userInfoDetails = UserDetails.fromJson(jsonResponse);
        });
        return userInfoDetails!;
      } else {
        throw Exception('Failed to load user details');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      throw Exception('Error fetching user details: $e');
    }
  }
  String getEmergencyContactRelationship(int? relationshipCode) {
    switch (relationshipCode) {
      case 0:
        return 'الأب';
      case 1:
        return 'الأم';
      case 2:
        return 'الأخ';
      case 3:
        return 'الأخت';
      case 4:
        return 'صديق';
      default:
        return 'غير معروف';
    }
  }

  String getBloodType(int? bloodType) {
    switch (bloodType) {
      case 0:
        return 'A+';
      case 1:
        return 'A-';
      case 2:
        return 'B+';
      case 3:
        return 'B-';
      case 4:
        return 'AB+';
      case 5:
        return 'AB-';
      case 6:
        return 'O+';
      case 7:
        return 'O-';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<UserDetails>(
          future: _userDetailsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final user = snapshot.data!.data!;
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        _buildProfileHeader(user),
                        _buildInfoSection(user),
                        _buildActionButtons(),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
  Widget _buildProfileHeader(Data user) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Hero(
            tag: 'profile-image',
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/dd.jpg',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack),
          SizedBox(height: 16),
          Text(
            "${user.user?.firstName ?? ''} ${user.user?.secondName ?? ''} ${user.user?.thirdName ?? ''}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.5, end: 0),
          SizedBox(height: 8),
          Text(
            user.user?.email ?? '',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ).animate().fadeIn(duration: 500.ms, delay: 250.ms).slideY(begin: 0.5, end: 0),
        ],
      ),
    );
  }

  Widget _buildInfoSection(Data user) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'معلومات شخصية',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          _buildInfoTile(Icons.cake, 'العمر', "${(user.birthYear ?? '')} سنة"),
          _buildInfoTile(Icons.local_hospital, 'فصيلة الدم', getBloodType(user.bloodType)),
          _buildInfoTile(Icons.phone, 'رقم الهاتف', user.user?.phoneNumber ?? ''),
          _buildInfoTile(Icons.email, 'البريد الإلكتروني', user.user?.email ?? ''),
          _buildInfoTile(Icons.person, 'الاسم الكامل', "${user.user?.firstName ?? ''} ${user.user?.secondName ?? ''} ${user.user?.thirdName ?? ''}"),
          _buildInfoTile(Icons.home, 'العنوان', "${user.address ?? ''},${user.country ?? ''},${user.district ?? ''}, ${user.district ?? ''}, ${user.province ?? ''}, ${user.country ?? ''}, ${user.house ?? ''}"),
          _buildInfoTile(Icons.heart_broken, 'الأمراض المزمنة', user.chronicDiseases ?? 'غير موجود'),
          _buildInfoTile(Icons.warning, 'الحساسيات', user.allergies ?? 'غير موجود'),
          _buildInfoTile(Icons.contacts, 'اسم جهة الاتصال للطوارئ', user.emergencyContactFullName ?? ''),
          _buildInfoTile(Icons.phone_in_talk, 'رقم هاتف جهة الاتصال للطوارئ', user.emergencyContactPhoneNumber ?? ''),
          _buildInfoTile(Icons.family_restroom, 'علاقة جهة الاتصال للطوارئ', getEmergencyContactRelationship(user.emergencyContactRelationship)),

        ],
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 500.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF5BB9AE), size: 24),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildGradientButton(
            icon: Icons.edit,
            label: 'تعديل الملف الشخصي',
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(userData: userInfoDetails!.data!),
                ),
              );
              if (result == true) {
                // Refresh user details if the profile was updated
                setState(() {
                  _userDetailsFuture = fetchUserDetails();
                });
              }
            },
            gradient: LinearGradient(
              colors: [Color(0xFF5BB9AE),
                Color(0xFF5BB9AE)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          SizedBox(height: 16),
          _buildOutlinedIconButton(
            icon: Icons.settings,
            label: 'الإعدادات',
            onPressed: () {
              // Implement settings functionality
            },
          ).animate(onPlay: (controller) => controller.repeat(reverse: true))
              .tint(color: Color(0xFF5BB9AE).withOpacity(0.2), duration: 1500.ms)
              .animate()
              .fadeIn(duration: 500.ms, delay: 1000.ms)
              .slideX(begin: -0.1, end: 0),
        ],
      ),
    );
  }

  Widget _buildGradientButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Gradient gradient,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF5BB9AE).withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
      ),
    );
  }

  Widget _buildOutlinedIconButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Color(0xFF5BB9AE), width: 2),
      ),
      child: OutlinedButton.icon(
        icon: Icon(icon, color: Color(0xFF5BB9AE)),
        label: Text(
          label,
          style: TextStyle(
            color: Color(0xFF5BB9AE),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28)),
        ),
      ),
    );
  }
}
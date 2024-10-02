import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart'; // Import your controller
import '../models/UserDetails.dart';
import 'edit_profile_page.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Instantiate the UserController
    final UserController userController = Get.put(UserController());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Obx(() {
          if (userController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (userController.userInfoDetails.value?.data == null) {
            return Center(child: Text('No data available'));
          } else {
            final user = userController.userInfoDetails.value?.data!;
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _buildProfileHeader(user!),
                      _buildInfoSection(user!),
                      _buildActionButtons(userController),
                    ],
                  ),
                ),
              ],
            );
          }
        }),
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
          _buildInfoTile(Icons.local_hospital, 'فصيلة الدم', getBloodType(user.bloodType as String?)),
          _buildInfoTile(Icons.phone, 'رقم الهاتف', user.user?.phoneNumber ?? ''),
          _buildInfoTile(Icons.email, 'البريد الإلكتروني', user.user?.email ?? ''),
          _buildInfoTile(Icons.person, 'الاسم الكامل', "${user.user?.firstName ?? ''} ${user.user?.secondName ?? ''} ${user.user?.thirdName ?? ''}"),
          _buildInfoTile(Icons.home, 'العنوان', "${user.address ?? ''},${user.country ?? ''},${user.district ?? ''}, ${user.province ?? ''}, ${user.house ?? ''}"),
          _buildInfoTile(Icons.heart_broken, 'الأمراض المزمنة', user.chronicDiseases ?? 'غير موجود'),
          _buildInfoTile(Icons.warning, 'الحساسيات', user.allergies ?? 'غير موجود'),
          _buildInfoTile(Icons.contacts, 'اسم جهة الاتصال للطوارئ', user.emergencyContactFullName ?? ''),
          _buildInfoTile(Icons.phone_in_talk, 'رقم هاتف جهة الاتصال للطوارئ', user.emergencyContactPhoneNumber ?? ''),
          _buildInfoTile(Icons.family_restroom, 'علاقة جهة الاتصال للطوارئ', getEmergencyContactRelationship(user.emergencyContactRelationship as String?)),
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

  Widget _buildActionButtons(UserController userController) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildGradientButton(
            icon: Icons.edit,
            label: 'تعديل الملف الشخصي',
            onPressed: () async {
              final result = await Get.to(() => EditProfilePage(userData: userController.userInfoDetails.value!.data!));
              if (result == true) {
                // Refresh user details if the profile was updated
                userController.fetchPatientDetails();
              }
            },
            gradient: LinearGradient(
              colors: [Color(0xFF5BB9AE), Color(0xFF5BB9AE)],
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
        borderRadius: BorderRadius.circular(8),
        gradient: gradient,
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildOutlinedIconButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Color(0xFF5BB9AE)),
      label: Text(label, style: TextStyle(color: Color(0xFF5BB9AE))),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(color: Color(0xFF5BB9AE)),
      ),
    );
  }

  String getBloodType(String? bloodType) {
    switch (bloodType) {
      case 'A+':
        return 'A إيجابي';
      case 'A-':
        return 'A سلبي';
      case 'B+':
        return 'B إيجابي';
      case 'B-':
        return 'B سلبي';
      case 'AB+':
        return 'AB إيجابي';
      case 'AB-':
        return 'AB سلبي';
      case 'O+':
        return 'O إيجابي';
      case 'O-':
        return 'O سلبي';
      default:
        return 'غير معروف';
    }
  }

  String getEmergencyContactRelationship(String? relationship) {
    switch (relationship) {
      case 'Father':
        return 'أب';
      case 'Mother':
        return 'أم';
      case 'Brother':
        return 'أخ';
      case 'Sister':
        return 'أخت';
      case 'Friend':
        return 'صديق';
      default:
        return 'غير معروف';
    }
  }
}

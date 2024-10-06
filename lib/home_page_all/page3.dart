import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../models/UserDetails.dart';
import 'edit_profile_page.dart';

class UserProfile extends GetView<UserController> {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.userInfoDetails.value == null) {
            return const Center(child: Text('No data available'));
          } else {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _buildProfileHeader(controller.userInfoDetails.value!.data!),
                      _buildInfoSection(controller.userInfoDetails.value!.data!),
                      _buildActionButtons(context),
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
      padding: const EdgeInsets.all(16),
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
          const SizedBox(height: 16),
          Text(
            "${user.user?.firstName ?? ''} ${user.user?.secondName ?? ''} ${user.user?.thirdName ?? ''}",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.5, end: 0),
          const SizedBox(height: 8),
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'معلومات شخصية',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoTile(Icons.cake, 'العمر', "${user.birthYear ?? ''} سنة"),
          _buildInfoTile(Icons.local_hospital, 'فصيلة الدم', controller.bloodType(user.bloodType)),
          _buildInfoTile(Icons.phone, 'رقم الهاتف', user.user?.phoneNumber ?? ''),
          _buildInfoTile(Icons.email, 'البريد الإلكتروني', user.user?.email ?? ''),
          _buildInfoTile(Icons.person, 'الاسم الكامل', "${user.user?.firstName ?? ''} ${user.user?.secondName ?? ''} ${user.user?.thirdName ?? ''}"),
          _buildInfoTile(Icons.home, 'العنوان', "${user.address ?? ''}, ${user.country ?? ''}, ${user.district ?? ''}, ${user.province ?? ''}, ${user.house ?? ''}"),
          _buildInfoTile(Icons.heart_broken, 'الأمراض المزمنة', user.chronicDiseases ?? 'غير موجود'),
          _buildInfoTile(Icons.warning, 'الحساسيات', user.allergies ?? 'غير موجود'),
          _buildInfoTile(Icons.contacts, 'اسم جهة الاتصال للطوارئ', user.emergencyContactFullName ?? ''),
          _buildInfoTile(Icons.phone_in_talk, 'رقم هاتف جهة الاتصال للطوارئ', user.emergencyContactPhoneNumber ?? ''),
          _buildInfoTile(Icons.family_restroom, 'علاقة جهة الاتصال للطوارئ', _getEmergencyContactRelationship(user.emergencyContactRelationship)),
          _buildInfoTile(Icons.code, 'الرمز العشوائي', user.randomCode ?? ''),
          _buildInfoTile(Icons.wc, 'الجنس', _getGender(user.gender)),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 500.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF5BB9AE), size: 24),
          const SizedBox(width: 16),
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
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
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

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                  builder: (context) => EditProfilePage(userData: controller.userInfoDetails.value!.data!),
                ),
              );
              if (result == true) {
                controller.fetchPatientDetails();
              }
            },
            gradient: const LinearGradient(
              colors: [Color(0xFF5BB9AE), Color(0xFF5BB9AE)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          const SizedBox(height: 16),
          _buildOutlinedIconButton(
            icon: Icons.settings,
            label: 'الإعدادات',
            onPressed: () {
              // Implement settings functionality
            },
          ).animate(onPlay: (controller) => controller.repeat(reverse: true))
              .tint(color: const Color(0xFF5BB9AE).withOpacity(0.2), duration: 1500.ms)
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
        icon: Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
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
      icon: Icon(icon, color: const Color(0xFF5BB9AE)),
      label: Text(label, style: const TextStyle(color: Color(0xFF5BB9AE))),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: const BorderSide(color: Color(0xFF5BB9AE)),
      ),
    );
  }

  String _getEmergencyContactRelationship(int? relationship) {
    switch (relationship) {
      case 1:
        return 'أب';
      case 2:
        return 'أم';
      case 3:
        return 'أخ';
      case 4:
        return 'أخت';
      case 5:
        return 'صديق';
      default:
        return 'غير معروف';
    }
  }

  String _getGender(int? gender) {
    switch (gender) {
      case 1:
        return 'ذكر';
      case 2:
        return 'أنثى';
      default:
        return 'غير محدد';
    }
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../models/UserDetails.dart';
import 'Settings.dart';
import 'edit_profile_page.dart';
import '../languages/lang.dart'; // Import the language enum

class UserProfile extends GetView<UserController> {
  final Language selectedLanguage;

  const UserProfile({Key? key, required this.selectedLanguage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _getTextDirection(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.userInfoDetails.value == null) {
            return Center(child: Text(_getLocalizedText(
                'No data available', 'بيانات غير متوفرة', 'داده‌ای موجود نیست',
                'داتا بەردەست نیە', 'Maglumat ýok')));
          } else {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _buildProfileHeader(controller.userInfoDetails.value!
                          .data!),
                      _buildInfoSection(controller.userInfoDetails.value!
                          .data!),
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

  TextDirection _getTextDirection() {
    return selectedLanguage == Language.Arabic ||
        selectedLanguage == Language.Persian ||
        selectedLanguage == Language.Kurdish
        ? TextDirection.rtl
        : TextDirection.ltr;
  }

  String _getLocalizedText(String english, String arabic, String persian,
      String kurdish, String turkmen) {
    switch (selectedLanguage) {
      case Language.English:
        return english;
      case Language.Arabic:
        return arabic;
      case Language.Persian:
        return persian;
      case Language.Kurdish:
        return kurdish;
      case Language.Turkmen:
        return turkmen;
      default:
        return english;
    }
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
            "${user.user?.firstName ?? ''} ${user.user?.secondName ?? ''} ${user
                .user?.thirdName ?? ''}",
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
          ).animate().fadeIn(duration: 500.ms, delay: 250.ms).slideY(
              begin: 0.5, end: 0),
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
          Text(
            _getLocalizedText(
                'Personal Information', 'معلومات شخصية', 'اطلاعات شخصی',
                'زانیاری کەسی', 'Şahsy maglumat'),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoTile(Icons.cake,
              _getLocalizedText('Age', 'العمر', 'سن', 'تەمەن', 'Ýaş'),
              "${user.birthYear ?? ''} ${_getLocalizedText(
                  'years', 'سنة', 'سال', 'ساڵ', 'ýaş')}"),
          _buildInfoTile(Icons.local_hospital, _getLocalizedText(
              'Blood Type', 'فصيلة الدم', 'گروه خونی', 'گرووپی خوێن',
              'Gan topary'), controller.bloodType(user.bloodType)),
          _buildInfoTile(Icons.phone, _getLocalizedText(
              'Phone Number', 'رقم الهاتف', 'شماره تلفن', 'ژمارەی تەلەفۆن',
              'Telefon belgisi'), user.user?.phoneNumber ?? ''),
          _buildInfoTile(Icons.email, _getLocalizedText(
              'Email', 'البريد الإلكتروني', 'ایمیل', 'ئیمەیل', 'E-poçta'),
              user.user?.email ?? ''),
          _buildInfoTile(Icons.person, _getLocalizedText(
              'Full Name', 'الاسم الكامل', 'نام کامل', 'ناوی تەواو',
              'Doly ady'),
              "${user.user?.firstName ?? ''} ${user.user?.secondName ??
                  ''} ${user.user?.thirdName ?? ''}"),
          _buildInfoTile(Icons.home, _getLocalizedText(
              'Address', 'العنوان', 'آدرس', 'ناونیشان', 'Salgy'),
              "${user.address ?? ''}, ${user.country ?? ''}, ${user.district ??
                  ''}, ${user.province ?? ''}, ${user.house ?? ''}"),
          _buildInfoTile(Icons.heart_broken, _getLocalizedText(
              'Chronic Diseases', 'الأمراض المزمنة', 'بیماری‌های مزمن',
              'نەخۆشیە درێژخایەنەکان', 'Dowamly keseller'),
              user.chronicDiseases ??
                  _getLocalizedText('None', 'غير موجود', 'هیچ', 'هیچ', 'Ýok')),
          _buildInfoTile(Icons.warning, _getLocalizedText(
              'Allergies', 'الحساسيات', 'آلرژی‌ها', 'هەستیارییەکان',
              'Allergiýalar'), user.allergies ??
              _getLocalizedText('None', 'غير موجود', 'هیچ', 'هیچ', 'Ýok')),
          _buildInfoTile(Icons.contacts, _getLocalizedText(
              'Emergency Contact Name', 'اسم جهة الاتصال للطوارئ',
              'نام تماس اضطراری', 'ناوی پەیوەندی کتوپڕ',
              'Gyssagly habarlaşmak üçin adam'),
              user.emergencyContactFullName ?? ''),
          _buildInfoTile(Icons.phone_in_talk, _getLocalizedText(
              'Emergency Contact Number', 'رقم هاتف جهة الاتصال للطوارئ',
              'شماره تماس اضطراری', 'ژمارەی پەیوەندی کتوپڕ',
              'Gyssagly habarlaşmak üçin belgi'),
              user.emergencyContactPhoneNumber ?? ''),
          _buildInfoTile(Icons.family_restroom, _getLocalizedText(
              'Emergency Contact Relationship', 'علاقة جهة الاتصال للطوارئ',
              'نسبت تماس اضطراری', 'پەیوەندی کەسی کتوپڕ',
              'Gyssagly habarlaşmak üçin garyndaşlyk'),
              _getEmergencyContactRelationship(
                  user.emergencyContactRelationship)),
          _buildInfoTile(Icons.code, _getLocalizedText(
              'Random Code', 'الرمز العشوائي', 'کد تصادفی', 'کۆدی هەڕەمەکی',
              'Tötänleýin kod'), user.randomCode ?? ''),
          _buildInfoTile(Icons.wc,
              _getLocalizedText('Gender', 'الجنس', 'جنسیت', 'ڕەگەز', 'Jyns'),
              _getGender(user.gender)),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 500.ms).slideY(
        begin: 0.1, end: 0);
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
            label: _getLocalizedText(
                'Edit Profile', 'تعديل الملف الشخصي', 'ویرایش پروفایل',
                'دەستکاری پرۆفایل', 'Profili üýtgetmek'),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditProfilePage(
                          userData: controller.userInfoDetails.value!.data!,
                          selectedLanguage: selectedLanguage),
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
            label: _getLocalizedText(
                'Settings', 'الإعدادات', 'تنظیمات', 'ڕێکخستنەکان',
                'Sazlamalar'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );            },
          ).animate(onPlay: (controller) => controller.repeat(reverse: true))
              .tint(color: const Color(0xFF5BB9AE).withOpacity(0.2),
              duration: 1500.ms)
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
        return _getLocalizedText('Father', 'أب', 'پدر', 'باوک', 'Kaka');
      case 2:
        return _getLocalizedText('Mother', 'أم', 'مادر', 'دایک', 'Ene');
      case 3:
        return _getLocalizedText('Brother', 'أخ', 'برادر', 'برا', 'Dogan');
      case 4:
        return _getLocalizedText('Sister', 'أخت', 'خواهر', 'خوشک', 'Uýa');
      case 5:
        return _getLocalizedText('Friend', 'صديق', 'دوست', 'هاوڕێ', 'Dost');
      default:
        return _getLocalizedText(
            'Unknown', 'غير معروف', 'ناشناخته', 'نەزانراو', 'Näbelli');
    }
  }
  String _getGender(int? gender) {
    switch (gender) {
      case 1:
        return _getLocalizedText('Male', 'ذكر', 'مرد', 'نێر', 'Erkek');
      case 2:
        return _getLocalizedText('Female', 'انثى', 'زن', 'مێ', 'Kadın');
      default:
        return _getLocalizedText('Unknown', 'غير معروف', 'ناشناخته', 'نەزانراو', 'Näbelli');
    }
  }
}
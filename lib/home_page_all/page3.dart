import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../models/UserDetails.dart';
import 'Settings.dart';
import 'edit_profile_page.dart';
import '../languages/lang.dart';

class UserProfile extends GetView<UserController> {
  final Language selectedLanguage;

  const UserProfile({Key? key, required this.selectedLanguage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations(selectedLanguage);

    return Directionality(
      textDirection: _getTextDirection(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.userInfoDetails.value == null) {
            return Center(child: Text(localizations.noDataAvailable));
          } else {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _buildProfileHeader(controller.userInfoDetails.value!.data!, localizations),
                      _buildInfoSection(controller.userInfoDetails.value!.data!, localizations),
                      _buildActionButtons(context, localizations),
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

  Widget _buildProfileHeader(Data user, AppLocalizations localizations) {
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

  Widget _buildInfoSection(Data userData, AppLocalizations localizations) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.personalInformation,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoTile(Icons.person, localizations.fullName, "${userData.user?.firstName ?? ''} ${userData.user?.secondName ?? ''} ${userData.user?.thirdName ?? ''}"),
          _buildInfoTile(Icons.email, localizations.email, userData.user?.email ?? ''),
          _buildInfoTile(Icons.phone, localizations.phoneNumber, userData.user?.phoneNumber ?? ''),
          _buildInfoTile(Icons.cake, localizations.birthYear, userData.birthYear ?? ''),
          _buildInfoTile(Icons.wc, localizations.gender, _getGender(userData.gender, localizations)),
          _buildInfoTile(Icons.local_hospital, localizations.bloodType, controller.bloodType(userData.bloodType)),
          _buildInfoTile(Icons.location_city, localizations.address, "${userData.address ?? ''}, ${userData.alley ?? ''}, ${userData.house ?? ''}"),
          _buildInfoTile(Icons.flag, localizations.country, userData.country ?? ''),
          _buildInfoTile(Icons.location_on, localizations.province, userData.province ?? ''),
          _buildInfoTile(Icons.location_city, localizations.district, userData.district ?? ''),
          _buildInfoTile(Icons.medical_services, localizations.chronicDiseases, userData.chronicDiseases ?? localizations.none),
          _buildInfoTile(Icons.warning, localizations.allergies, userData.allergies ?? localizations.none),
          _buildInfoTile(Icons.contacts, localizations.emergencyContactName, userData.emergencyContactFullName ?? ''),
          _buildInfoTile(Icons.phone_in_talk, localizations.emergencyContactNumber, userData.emergencyContactPhoneNumber ?? ''),
          _buildInfoTile(Icons.family_restroom, localizations.emergencyContactRelationship, _getEmergencyContactRelationship(userData.emergencyContactRelationship, localizations)),
          _buildInfoTile(Icons.home, localizations.emergencyContactAddress, "${userData.emergencyContactAddress ?? ''}, ${userData.emergencyContactAlley ?? ''}, ${userData.emergencyContactHouse ?? ''}"),
          _buildInfoTile(Icons.flag, localizations.emergencyContactCountry, userData.emergencyContactCountry ?? ''),
          _buildInfoTile(Icons.location_on, localizations.emergencyContactProvince, userData.emergencyContactProvince ?? ''),
          _buildInfoTile(Icons.location_city, localizations.emergencyContactDistrict, userData.emergencyContactDistrict ?? ''),
          _buildInfoTile(Icons.code, localizations.randomCode, userData.randomCode ?? ''),
          _buildInfoTile(Icons.person_outline, localizations.username, userData.user?.username ?? ''),
          _buildInfoTile(Icons.event, localizations.createdAt, _formatDateTime(userData.createdAt)),
          _buildInfoTile(Icons.update, localizations.modifiedAt, _formatDateTime(userData.modifiedAt)),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 500.ms).slideY(begin: 0.1, end: 0);
  }

  String _formatDateTime(String? dateTimeString) {
    if (dateTimeString == null) return '';
    final dateTime = DateTime.parse(dateTimeString);
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
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

  Widget _buildActionButtons(BuildContext context, AppLocalizations localizations) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildGradientButton(
            icon: Icons.edit,
            label: localizations.editProfile,
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(
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
            label: localizations.settings,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );            },
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

  String _getEmergencyContactRelationship(int? relationship, AppLocalizations localizations) {
    switch (relationship) {
      case 1:
        return localizations.father;
      case 2:
        return localizations.mother;
      case 3:
        return localizations.brother;
      case 4:
        return localizations.sister;
      case 5:
        return localizations.friend;
      default:
        return localizations.unknown;
    }
  }

  String _getGender(int? gender, AppLocalizations localizations) {
    switch (gender) {
      case 1:
        return localizations.male;
      case 2:
        return localizations.female;
      default:
        return localizations.unknown;
    }
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../controllers/user_controller.dart';
import '../languages/lang.dart';

class QrCode extends StatelessWidget {
  final Language selectedLanguage;

   QrCode({Key? key, required this.selectedLanguage}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final UserController controller = Get.put(UserController());

    return Directionality(
      textDirection: _getTextDirection(selectedLanguage),
      child: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  // Use Obx to reactively rebuild based on loading state
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else {
                    return _buildQrCodeContainer(context, controller.userInfoDetails.value?.data?.randomCode);
                  }
                }),
                SizedBox(height: 20),
                _buildActionButtons(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQrCodeContainer(BuildContext context, String? qrData) {
    if (qrData == null || qrData.isEmpty) {
      return Text(
        _getLocalizedText('qr_data_empty', selectedLanguage),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: QrImageView(
          data: qrData,
          version: QrVersions.auto,
          size: MediaQuery.of(context).size.width * 0.7,
        ).animate()
            .scale(duration: 500.ms, curve: Curves.easeInOut)
            .fadeIn(duration: 700.ms),
      ),
    ).animate()
        .scale(duration: 800.ms, curve: Curves.easeOutBack)
        .fadeIn(duration: 900.ms);
  }

  Widget _buildActionButtons(UserController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildActionButton(
          icon: Icons.refresh,
          label: _getLocalizedText('refresh', selectedLanguage),
          onPressed: controller.fetchPatientDetails,
        ),
        SizedBox(width: 20),
        _buildActionButton(
          icon: Icons.share,
          label: _getLocalizedText('download_code', selectedLanguage),
          onPressed: () {
            // Implement share functionality
          },
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: Color(0xFF5BB9AE)),
      label: Text(label, style: TextStyle(color: Color(0xFF5BB9AE))),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ).animate()
        .fadeIn(delay: 1000.ms, duration: 500.ms)
        .slide(begin: Offset(0, 0.5), curve: Curves.easeOutQuad);
  }

  TextDirection _getTextDirection(Language language) {
    return language == Language.Arabic ||
        language == Language.Persian ||
        language == Language.Kurdish
        ? TextDirection.rtl
        : TextDirection.ltr;
  }

  String _getLocalizedText(String key, Language language) {
    switch (language) {
      case Language.Arabic:
        return _arabicTranslations[key] ?? key; // Add your Arabic translations
      case Language.Persian:
        return _persianTranslations[key] ?? key; // Add your Persian translations
      case Language.Kurdish:
        return _kurdishTranslations[key] ?? key; // Add your Kurdish translations
      case Language.English:
        return _englishTranslations[key] ?? key; // Add your English translations
      case Language.Turkmen:
        return _turkmenTranslations[key] ?? key; // Add your Turkmen translations
      default:
        return key;
    }
  }

  // Add translation maps for each language
  final Map<String, String> _arabicTranslations = {
    'qr_data_empty': 'بيانات QR فارغة أو غير صالحة',
    'refresh': 'تحديث',
    'download_code': 'تحميل الرمز',
  };

  final Map<String, String> _persianTranslations = {
    'qr_data_empty': 'داده QR خالی یا نامعتبر است',
    'refresh': 'تازه‌سازی',
    'download_code': 'دانلود کد',
  };

  final Map<String, String> _kurdishTranslations = {
    'qr_data_empty': 'داده QR vala an nayê raye',
    'refresh': 'Nûvekirin',
    'download_code': 'Koda danîn',
  };

  final Map<String, String> _englishTranslations = {
    'qr_data_empty': 'QR data is empty or invalid',
    'refresh': 'Refresh',
    'download_code': 'Download Code',
  };

  final Map<String, String> _turkmenTranslations = {
    'qr_data_empty': 'QR maglumat boş ýa-da nädogry',
    'refresh': 'Täzelemek',
    'download_code': 'Kody ýüklemek',
  };
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/user_controller.dart';
import '../models/UserDetails.dart';
import '../languages/lang.dart';

class QrCode extends StatefulWidget {
  final Language selectedLanguage;

  const QrCode({Key? key, required this.selectedLanguage}) : super(key: key);

  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  String? qrData;
  bool isLoading = true;
  final UserController controller = Get.put(UserController());
  UserDetails? userDetails;
  late Language selectedLanguage;

  @override
  void initState() {
    super.initState();
    selectedLanguage = widget.selectedLanguage;
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    setState(() {
      isLoading = true;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwtToken = prefs.getString('token');

    if (jwtToken == null) {
      throw Exception(getLocalizedText(
        'رمز JWT مفقود',
        'توکن JWT موجود نیست',
        'JWT token is missing',
        'تۆکێنی JWT بزرە',
        'JWT belligi ýok',
      ));
    }

    try {
      final response = await http.get(
        Uri.parse('https://medicalpoint-api.tatwer.tech/api/Mobile/GetPatientDetails'),
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          userDetails = UserDetails.fromJson(jsonData);
          qrData = userDetails?.data?.randomCode?.trim();
        });
      } else {
        throw Exception(getLocalizedText(
          'فشل في تحميل تفاصيل المستخدم',
          'بارگیری اطلاعات کاربر ناموفق بود',
          'Failed to load user details',
          'بارکردنی وردەکارییەکانی بەکارهێنەر سەرکەوتوو نەبوو',
          'Ulanyjy maglumatlaryny ýükläp bolmady',
        ));
      }
    } catch (e) {
      print('Error fetching user details: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String getLocalizedText(String arabic, String persian, String english, String kurdish, String turkmen) {
    switch (selectedLanguage) {
      case Language.Arabic:
        return arabic;
      case Language.Persian:
        return persian;
      case Language.English:
        return english;
      case Language.Kurdish:
        return kurdish;
      case Language.Turkmen:
        return turkmen;
      default:
        return english;
    }
  }
  TextDirection getTextDirection() {
    return selectedLanguage == Language.Arabic ||
        selectedLanguage == Language.Persian ||
        selectedLanguage == Language.Kurdish
        ? TextDirection.rtl
        : TextDirection.ltr;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: getTextDirection(),
      child: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLoading ? CircularProgressIndicator() : _buildQrCodeContainer(),
                SizedBox(height: 20),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQrCodeContainer() {
    if (qrData == null || qrData!.isEmpty) {
      return Text(
        getLocalizedText(
          'بيانات رمز الاستجابة السريعة فارغة أو غير صالحة',
          'داده‌های QR خالی یا نامعتبر است',
          'QR data is empty or invalid',
          'داتای QR بەتاڵە یان نادروستە',
          'QR maglumatlary boş ýa-da nädogry',
        ),
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
        child: _buildQrCodeContent(),
      ),
    ).animate()
        .scale(duration: 800.ms, curve: Curves.easeOutBack)
        .fadeIn(duration: 900.ms);
  }

  Widget _buildQrCodeContent() {
    return QrImageView(
      data: qrData!,
      version: QrVersions.auto,
      size: MediaQuery.of(context).size.width * 0.7,
    ).animate()
        .scale(duration: 500.ms, curve: Curves.easeInOut)
        .fadeIn(duration: 700.ms);
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildActionButton(
          icon: Icons.refresh,
          label: getLocalizedText(
            'تحديث',
            'بازخوانی',
            'Refresh',
            'نوێکردنەوە',
            'Täzelemek',
          ),
          onPressed: fetchUserDetails,
        ),
        SizedBox(width: 20),
        _buildActionButton(
          icon: Icons.share,
          label: getLocalizedText(
            'تنزيل الرمز',
            'دانلود کد',
            'Download Code',
            'داگرتنی کۆد',
            'Kody göçürip almak',
          ),
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
}

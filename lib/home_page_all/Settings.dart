import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medicapp/pagess/login_reg.dart';
import '../languages/lang.dart';

class SettingsScreen extends StatefulWidget {
  final Language selectedLanguage;

  const SettingsScreen({Key? key, required this.selectedLanguage}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Language _currentLanguage;

  @override
  void initState() {
    super.initState();
    _currentLanguage = widget.selectedLanguage;
  }

  // إضافة وظيفة تغيير اللغة
  void _handleLanguageChange(Language newLanguage) {
    setState(() {
      _currentLanguage = newLanguage;
    });
    Navigator.pop(context); // إغلاق قائمة اللغات
    // هنا يمكنك إضافة المنطق لحفظ اللغة المختارة
  }

  // إضافة وظيفة عرض قائمة اللغات
  void _showLanguageSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'اختر اللغة',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(),
                _buildLanguageOption('العربية', Language.Arabic),
                _buildLanguageOption('English', Language.English),
                _buildLanguageOption('فارسی', Language.Persian),
                _buildLanguageOption('کوردی', Language.Kurdish),
                _buildLanguageOption('Türkmençe', Language.Turkmen),
              ],
            ),
          ),
        );
      },
    );
  }

  // بناء خيار اللغة
  Widget _buildLanguageOption(String title, Language language) {
    return ListTile(
      title: Text(title),
      trailing: _currentLanguage == language
          ? const Icon(Icons.check, color: Color(0xFF5BB9AE))
          : null,
      onTap: () => _handleLanguageChange(language),
    );
  }
  Future<void> _deleteAccount(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwtToken = prefs.getString('token');

    if (jwtToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في العثور على معلومات المستخدم. الرجاء تسجيل الدخول مرة أخرى.')),
      );
      // TODO: Navigate to login screen or handle re-authentication
      return;
    }

    // Decode the JWT token to get the user ID
    final parts = jwtToken.split('.');
    if (parts.length != 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في تنسيق الرمز المميز. الرجاء تسجيل الدخول مرة أخرى.')),
      );
      return;
    }

    String payload = parts[1];
    payload = base64Url.normalize(payload);
    final payloadMap = json.decode(utf8.decode(base64Url.decode(payload)));
    final String? userId = payloadMap['nameid'];

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('لم يتم العثور على معرف المستخدم. الرجاء تسجيل الدخول مرة أخرى.')),
      );
      return;
    }

    final bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('حذف الحساب'),
          content: Text('هل أنت متأكد أنك تريد حذف حسابك؟ هذا الإجراء لا يمكن التراجع عنه.'),
          actions: <Widget>[
            TextButton(
              child: Text('إلغاء'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('نعم، احذف الحساب'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      try {
        final url = Uri.parse('https://medicalpoint-api.tatwer.tech/api/Users/$userId');

        final response = await http.delete(
          url,
          headers: {
            'Authorization': 'Bearer $jwtToken',
            'accept': 'text/plain',
          },
        );

        if (response.statusCode == 200) {
          // Clear local storage
          await prefs.clear();

          // Navigate to WelcomeScreen
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => WelcomeScreen(selectedLanguage: _currentLanguage)),
                (Route<dynamic> route) => false,
          );

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('فشل في حذف الحساب. الرجاء المحاولة مرة أخرى. الخطأ: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ أثناء محاولة حذف الحساب: $e')),
        );
      }
    }
  }
  String _getLanguageDisplayName(Language language) {
    switch (language) {
      case Language.Arabic:
        return 'العربية';
      case Language.English:
        return 'English';
      case Language.Persian:
        return 'فارسی';
      case Language.Kurdish:
        return 'کوردی';
      case Language.Turkmen:
        return 'Türkmençe';
      default:
        return 'العربية';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
        backgroundColor: Colors.transparent,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            _buildSection(
              title: 'عام',
              items: [
                _buildListTile(
                  icon: Icons.language,
                  title: 'اللغة',
                  trailing: _getLanguageDisplayName(_currentLanguage),
                  onTap: () => _showLanguageSelection(context),
                ),
                _buildListTile(
                  icon: Icons.delete_outline,
                  title: 'حذف الحساب',
                  textColor: Colors.red,
                  onTap: () => _deleteAccount(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: 'قانوني',
              items: [
                _buildListTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'سياسة الخصوصية',
                ),
                _buildListTile(
                  icon: Icons.description_outlined,
                  title: 'شروط الخدمة',
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: 'إعدادات التطبيق',
              items: [
                _buildListTile(
                  icon: Icons.notifications_outlined,
                  title: 'الإشعارات',
                ),
                _buildListTile(
                  icon: Icons.security,
                  title: 'الأمان',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? trailing,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF5BB9AE)),
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      trailing: trailing != null
          ? Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            trailing,
            style: TextStyle(color: Colors.grey[600]),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      )
          : const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
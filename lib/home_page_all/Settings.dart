import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
                  trailing: 'العربية',
                ),
                _buildListTile(
                  icon: Icons.delete_outline,
                  title: 'حذف الحساب',
                  textColor: Colors.red,
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
  }) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF5BB9AE)),
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
      onTap: () {
        // Handle tap
      },
    );
  }
}

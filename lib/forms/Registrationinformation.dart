import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'section_title.dart';
import '../languages/lang.dart';
import 'cusstom.dart';

class AccountInfoPage extends StatelessWidget {
  final Language selectedLanguage;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController usernameController;
  final TextEditingController phoneNumberController;

  AccountInfoPage({
    required this.selectedLanguage,
    required this.emailController,
    required this.passwordController,
    required this.usernameController,
    required this.phoneNumberController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: getLocalizedText('معلومات الحساب', 'اطلاعات حساب', 'Account Information', 'زانیاری هەژمار', '')),
        SizedBox(height: 16),
        _buildUsernameField(),
        SizedBox(height: 16),
        _buildEmailField(),
        SizedBox(height: 16),
        _buildPasswordField(),
        SizedBox(height: 16),
        _buildPhoneNumberField(),
      ],
    );
  }

  Widget _buildUsernameField() {
    return CustomTextField(
      getLocalizedText('اسم المستخدم', 'نام کاربری', 'Username', 'ناوی بەکارهێنەر', ''),
      usernameController,
      textStyle: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  Widget _buildEmailField() {
    return CustomTextField(
      getLocalizedText('البريد الإلكتروني', 'ایمیل', 'Email', 'ئیمەیل', ''),
      emailController,
      textStyle: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      getLocalizedText('كلمة المرور', 'رمز عبور', 'Password', 'وشەی نهێنی', ''),
      passwordController,
      textStyle: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getLocalizedText('رقم الهاتف', 'شماره تلفن', 'Phone Number', 'ژمارەی تەلەفۆن', ''),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        IntlPhoneField(
          controller: phoneNumberController,
          decoration: InputDecoration(
            labelText: getLocalizedText('رقم الهاتف', 'شماره تيلفۆن', 'Phone Number', 'ژمارەی تەلەفۆن', ''),
            labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          ),
          initialCountryCode: 'IQ',
          onChanged: (phone) {
            print(phone.completeNumber);
          },
          validator: (phone) {
            if (phone == null || phone.number.isEmpty) {
              return getLocalizedText(
                  'يرجى إدخال رقم الهاتف',
                  'لطفاً شماره تلفن را وارد کنید',
                  'Please enter a phone number',
                  'تکایە ژمارەی تەلەفۆن داخڵ بکە',
                  ''
              );
            }
            return null;
          },
        ),
      ],
    );
  }

  String getLocalizedText(String arabic, String persian, String english, String kurdish, String turkmen) {
    switch (selectedLanguage) {
      case Language.Arabic:
        return arabic;
      case Language.Persian:
        return persian;
      case Language.Kurdish:
        return kurdish;
      case Language.Turkmen:
        return turkmen;
      case Language.English:
      default:
        return english;
    }
  }
}
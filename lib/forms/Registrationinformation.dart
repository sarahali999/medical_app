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
    final localizations = AppLocalizations(selectedLanguage);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: localizations.accountInformation),
        SizedBox(height: 16),
        _buildUsernameField(localizations),
        SizedBox(height: 16),
        _buildEmailField(localizations),
        SizedBox(height: 16),
        _buildPasswordField(localizations),
        SizedBox(height: 16),
        _buildPhoneNumberField(localizations),
      ],
    );
  }

  Widget _buildUsernameField(AppLocalizations localizations) {
    return CustomTextField(
      localizations.username,
      usernameController,
      textStyle: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  Widget _buildEmailField(AppLocalizations localizations) {
    return CustomTextField(
      localizations.email,
      emailController,
      textStyle: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  Widget _buildPasswordField(AppLocalizations localizations) {
    return CustomTextField(
      localizations.password,
      passwordController,
      textStyle: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  Widget _buildPhoneNumberField(AppLocalizations localizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.phoneNumber8,
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
            labelText: localizations.phoneNumber,
            labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          ),
          initialCountryCode: 'IQ',
          onChanged: (phone) {
            print(phone.completeNumber);
          },
          validator: (phone) {
            if (phone == null || phone.number.isEmpty) {
              return localizations.pleaseEnterPhoneNumber;
            }
            return null;
          },
        ),
      ],
    );
  }
}
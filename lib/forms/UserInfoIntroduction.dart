// import 'package:flutter/material.dart';
// import 'package:introduction_screen/introduction_screen.dart';
// import 'package:provider/provider.dart';
// import 'personalinfopage.dart';
// import 'medicalinfopage.dart';
// import 'emergencycontactpage.dart';
// import 'language_service.dart';
// import 'styles.dart';
// import 'user_data_provider.dart';
// import 'package:medicapp/languages/lang.dart';
//
// class UserInfoIntroduction extends StatelessWidget {
//   final Language language;
//
//   UserInfoIntroduction({required this.language});
//
//   @override
//   Widget build(BuildContext context) {
//     return IntroductionScreen(
//       pages: [
//         PageViewModel(
//           title: LanguageService.getText('personalInfo', language),
//           body: LanguageService.getText('personalInfoDesc', language),
//           decoration: PageDecoration(
//             titleTextStyle: AppStyles.headerStyle,
//             bodyTextStyle: TextStyle(fontSize: 16),
//           ),
//           image: Center(
//             child: Image.asset('assets/personal_info_icon.png', height: 175.0),
//           ),
//           footer: PersonalInfoPage(language: language),
//         ),
//         PageViewModel(
//           title: LanguageService.getText('medicalInfo', language),
//           body: LanguageService.getText('medicalInfoDesc', language),
//           decoration: PageDecoration(
//             titleTextStyle: AppStyles.headerStyle,
//             bodyTextStyle: TextStyle(fontSize: 16),
//           ),
//           image: Center(
//             child: Image.asset('assets/medical_info_icon.png', height: 175.0),
//           ),
//           footer: MedicalInfoPage(language: language),
//         ),
//         PageViewModel(
//           title: LanguageService.getText('emergencyContact', language),
//           body: LanguageService.getText('emergencyContactDesc', language),
//           decoration: PageDecoration(
//             titleTextStyle: AppStyles.headerStyle,
//             bodyTextStyle: TextStyle(fontSize: 16),
//           ),
//           image: Center(
//             child: Image.asset('assets/emergency_contact_icon.png', height: 175.0),
//           ),
//           footer: EmergencyContactPage(language: language),
//         ),
//       ],
//       onDone: () {
//         // Handle form submission
//         final userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
//         // Here you can access all the collected data from userDataProvider
//         // and send it to your backend or process it as needed
//         print('Form submitted');
//         print('First Name: ${userDataProvider.firstName}');
//         // ... print other fields or process the data
//
//         // Navigate to the next screen or show a confirmation dialog
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (_) => ConfirmationPage(language: language)),
//         );
//       },
//       showSkipButton: false,
//       next: Icon(Icons.arrow_forward, color: AppStyles.primaryColor),
//       done: Text(
//         LanguageService.getText('done', language),
//         style: TextStyle(fontWeight: FontWeight.w700, color: AppStyles.primaryColor),
//       ),
//       dotsDecorator: DotsDecorator(
//         size: Size(10.0, 10.0),
//         color: AppStyles.secondaryColor,
//         activeSize: Size(22.0, 10.0),
//         activeColor: AppStyles.primaryColor,
//         activeShape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(25.0)),
//         ),
//       ),
//     );
//   }
// }
//
// // You might want to create a simple confirmation page
// class ConfirmationPage extends StatelessWidget {
//   final Language language;
//
//   ConfirmationPage({required this.language});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(LanguageService.getText('confirmation', language)),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.check_circle, color: Colors.green, size: 100),
//             SizedBox(height: 20),
//             Text(
//               LanguageService.getText('formSubmittedSuccessfully', language),
//               style: TextStyle(fontSize: 20),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
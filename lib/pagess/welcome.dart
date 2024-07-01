// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class WelcomeScreen extends StatefulWidget {
//   const WelcomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<WelcomeScreen> createState() => _WelcomeScreenState();
// }
//
// class _WelcomeScreenState extends State<WelcomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/iii.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Stack(
//           alignment: Alignment.bottomCenter,
//           children: [
//             Container(
//               height: 60,
//               width: 60,
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.7),
//               ),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: 30,
//                   backgroundColor: Colors.blue, // Replace with ConstColors.primaryColor
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Image.asset(
//                       '', // Replace with DefaultImages.appIcon
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Text(
//                       "Movi",
//                       style: TextStyle(
//                         fontFamily: 'Changa-VariableFont_wght',
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       "start",
//                       style: TextStyle(
//                         fontFamily: 'Changa-VariableFont_wght',
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   "كل ما تحتاجه خلال رحلتك من فحوصات وادوية",
//                   style: TextStyle(
//                     fontFamily: 'Changa-VariableFont_wght',
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 25),
//               child: CustomButton(
//                 width: MediaQuery.of(context).size.width / 3,
//                 text: "تخطي",
//                 onTap: () {
//                   Get.off(
//                     const LoginScreen(),
//                     transition: Transition.rightToLeft,
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Placeholder classes for ConstColors, DefaultImages, CustomButton, and LoginScreen
// // These should be replaced with actual implementations.
//
// class ConstColors {
//   static const primaryColor = Colors.blue; // Define your actual color
// }
//
// class DefaultImages {
//   static const appIcon = 'assets/images/app_icon.png'; // Define your actual image path
// }
//
// class CustomButton extends StatelessWidget {
//   final double width;
//   final String text;
//   final VoidCallback onTap;
//
//   const CustomButton({
//     Key? key,
//     required this.width,
//     required this.text,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onTap,
//       child: Text(text),
//       style: ElevatedButton.styleFrom(
//         fixedSize: Size(width, 50),
//       ),
//     );
//   }
// }
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: Center(child: const Text('Login Screen')),
//     );
//   }
// }

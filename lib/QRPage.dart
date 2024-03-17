import 'package:flutter/material.dart';
import 'personal_info.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatelessWidget {
  final PersonalInfoPage personalInfo;

  const QRPage({Key? key, required this.personalInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Generate QR code using personalInfo data
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Assuming you have a widget to display QR code, replace this with your actual implementation
            Text(
              'QR Code will be displayed here',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Perform action when button is pressed
              },
              child: Text('Save QR Code'),
            ),
          ],
        ),
      ),
    );
  }
}

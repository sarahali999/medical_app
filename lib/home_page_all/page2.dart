import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Add this for animations
import 'package:http/http.dart' as http;
import 'dart:convert';

class Quicksupportnumbers extends StatefulWidget {
  Quicksupportnumbers({Key? key}) : super(key: key);

  @override
  _QuicksupportnumbersState createState() => _QuicksupportnumbersState();
}

class _QuicksupportnumbersState extends State<Quicksupportnumbers> {
  List<Map<String, dynamic>> supportNumbers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSupportNumbers();
  }

  Future<void> fetchSupportNumbers() async {
    final response = await http.get(Uri.parse('https://medicalpoint-api.tatwer.tech/api/Mobile/GetAllCenters'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        supportNumbers = (data['items'] as List)
            .map((item) => {
          'name': item['centerName'],
          'number': item['phoneNumCenter'] ?? 'غير متوفر',
        })
            .toList()
            .cast<Map<String, dynamic>>(); // Cast to the correct type
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load support numbers');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'أرقام الدعم السريع',
            style: TextStyle(
              color: Color(0xFF5BB9AE),
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
          child: SafeArea(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: supportNumbers.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final number = supportNumbers[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    onTap: () => _makePhoneCall(number['number']!),
                    title: Text(
                      number['name']!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5BB9AE),
                      ),
                    ),
                    subtitle: Text(
                      number['number']!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black45,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.phone, color: Colors.green),
                      onPressed: () => _makePhoneCall(number['number']!),
                    ),
                  ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, curve: Curves.easeInOut),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'map.dart';
import '../languages/lang.dart';
import 'package:latlong2/latlong.dart';

class Quicksupportnumbers extends StatefulWidget {
  final Language selectedLanguage; // تمرير اللغة المختارة عند بناء الصفحة

  Quicksupportnumbers({Key? key, required this.selectedLanguage}) : super(key: key);

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
          'number': item['phoneNumCenter'] ?? quickSupportTranslations[widget.selectedLanguage.toString().split('.').last]?['numberUnavailable']!,
          'lat': item['lot'],
          'lng': item['lag'],
        })
            .toList()
            .cast<Map<String, dynamic>>();
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

  void _navigateToMap(BuildContext context, Map<String, dynamic> location) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapPage(
          selectedLanguage: widget.selectedLanguage,
          initialLocation: LatLng(location['lat'], location['lng']),
          locationName: location['name'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            quickSupportTranslations[widget.selectedLanguage.toString().split('.').last]!['supportTitle']!,
            style: const TextStyle(
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
            ? Center(
          child: Text(
            quickSupportTranslations[widget.selectedLanguage.toString().split('.').last]!['loading']!,
            style: const TextStyle(fontSize: 18),
          ),
        )
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
                    onTap: () => _navigateToMap(context, number),
                    title: Text(
                      number['name']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5BB9AE),
                      ),
                    ),
                    subtitle: Text(
                      number['number']!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black45,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.phone, color: Colors.green),
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

// Translation map for all languages
Map<String, Map<String, String>> quickSupportTranslations = {
  'Arabic': {
    'supportTitle': 'أرقام الدعم السريع',
    'numberUnavailable': 'غير متوفر',
    'loading': 'جاري التحميل...',
  },
  'English': {
    'supportTitle': 'Quick Support Numbers',
    'numberUnavailable': 'Unavailable',
    'loading': 'Loading...',
  },
  'Persian': {
    'supportTitle': 'شماره‌های پشتیبانی سریع',
    'numberUnavailable': 'در دسترس نیست',
    'loading': 'در حال بارگذاری...',
  },
  'Kurdish': {
    'supportTitle': 'ژمارەی پشتیوانی خێرا',
    'numberUnavailable': 'بەردەست نیە',
    'loading': 'بارکردنەوە...',
  },
  'Turkmen': {
    'supportTitle': 'Çalt goldaw belgileri',
    'numberUnavailable': 'Elýeterli däl',
    'loading': 'Ýüklenýär...',
  },
};

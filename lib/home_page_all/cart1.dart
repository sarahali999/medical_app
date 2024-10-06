import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:medicapp/languages/lang.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

class MedicationListWidget extends StatefulWidget {
  final Language language;

  MedicationListWidget({Key? key, required this.language}) : super(key: key);

  @override
  _MedicationListWidgetState createState() => _MedicationListWidgetState();
}

class _MedicationListWidgetState extends State<MedicationListWidget> with SingleTickerProviderStateMixin {
  List<dynamic> medications = [];
  bool isLoading = true;
  String? errorMessage;
  String? jwtToken;
  double opacity = 0.0;
  late ui.TextDirection textDirection;

  @override
  void initState() {
    super.initState();
    setTextDirection();
    fetchJwtTokenAndMedications();
  }

  void setTextDirection() {
    textDirection = widget.language == Language.Arabic ||
        widget.language == Language.Persian ||
        widget.language == Language.Kurdish
        ? ui.TextDirection.rtl
        : ui.TextDirection.ltr;
  }

  Future<void> fetchJwtTokenAndMedications() async {
    await fetchJwtToken();
    if (jwtToken != null) {
      fetchMedications();
    } else {
      setState(() {
        isLoading = false;
        errorMessage = getLocalizedText(
          "فشل في جلب رمز JWT.",
          "Failed to fetch JWT token.",
          "دریافت توکن JWT ناموفق بود.",
          "وەرگرتنی تۆکنی JWT سەرکەوتوو نەبوو.",
          "JWT belginamany almak başartmady.",
        );
      });
    }
  }

  Future<void> fetchJwtToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      jwtToken = prefs.getString('token');
    });
  }

  Future<void> fetchMedications() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://medicalpoint-api.tatwer.tech/api/Mobile/GetPatientDispenseLaboratoryMaterial?PageNumber=1&PageSize=11',
        ),
        headers: {
          'Authorization': 'Bearer $jwtToken',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          medications = data['value']['items'];
          isLoading = false;
          opacity = 1.0;
        });
      } else {
        throw Exception(getLocalizedText(
          'فشل في تحميل الأدوية',
          'Failed to load medications',
          'بارگیری داروها ناموفق بود',
          'بارکردنی دەرمانەکان سەرکەوتوو نەبوو',
          'Derman serişdelerini ýükläp bolmady',
        ));
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = e.toString();
      });
    }
  }

  String getLocalizedText(String arabic, String english, String persian, String kurdish, String turkmen) {
    switch (widget.language) {
      case Language.Arabic:
        return arabic;
      case Language.English:
        return english;
      case Language.Persian:
        return persian;
      case Language.Kurdish:
        return kurdish;
      case Language.Turkmen:
        return turkmen;
      default:
        return english;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: textDirection,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            getLocalizedText(
              'مواد مختبر المريض',
              'Patient Laboratory Materials',
              'مواد آزمایشگاهی بیمار',
              'کەرەستەکانی تاقیگەی نەخۆش',
              'Näsag barlaghanasynyň materiallary',
            ),
            style: TextStyle(
              color: Color(0xFF5CBBE3),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : errorMessage != null
            ? Center(
          child: Text(
            errorMessage!,
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
        )
            : medications.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/no.svg',
                width: 200,
                height: 200,
              ),
              SizedBox(height: 20),
              Text(
                getLocalizedText(
                  'لم يتم صرف الدواء بعد',
                  'The medication has not been dispensed yet',
                  'دارو هنوز توزیع نشده است',
                  'دەرمانەکە هێشتا دابەش نەکراوە',
                  'Derman entek paýlanmady',
                ),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5CBBE3),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
            : AnimatedOpacity(
          opacity: opacity,
          duration: Duration(milliseconds: 500),
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: medications.length,
            itemBuilder: (context, index) {
              final medication = medications[index];
              final labMaterial = medication['laboratoryMaterial'];
              final center = labMaterial['center'];

              return Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF5CBBE3), Colors.white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${getLocalizedText("المحلول", "Solution", "محلول", "چارەسەر", "Çözgüt")}: ${labMaterial['solutionName'] ?? "N/A"}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      _buildInfoRow(Icons.science,
                          '${getLocalizedText("الاختبارات لكل عدة", "Tests Per Kit", "آزمایش در هر کیت", "تاقیکردنەوە بۆ هەر کیت", "Her toplumdaky barlaglar")}: ${labMaterial['testsPerKit'] ?? "N/A"}'),
                      _buildInfoRow(Icons.category,
                          '${getLocalizedText("عدد العدة", "Kit Count", "تعداد کیت", "ژمارەی کیت", "Toplum sany")}: ${labMaterial['kitCount'] ?? "N/A"}'),
                      _buildInfoRow(Icons.business,
                          '${getLocalizedText("المورد", "Supplier", "تأمین کننده", "دابینکەر", "Üpjün ediji")}: ${labMaterial['supplier'] ?? "N/A"}'),
                      _buildInfoRow(Icons.factory,
                          '${getLocalizedText("المنتج", "Producer", "تولید کننده", "بەرهەمهێنەر", "Öndüriji")}: ${labMaterial['producer'] ?? "N/A"}'),
                      Divider(),
                      Text(
                        getLocalizedText(
                          "معلومات المركز",
                          "Center Information",
                          "اطلاعات مرکز",
                          "زانیاری سەنتەر",
                          "Merkez barada maglumat",
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5CBBE3),
                        ),
                      ),
                      _buildInfoRow(Icons.local_hospital,
                          '${getLocalizedText("المركز", "Center", "مرکز", "سەنتەر", "Merkez")}: ${center['centerName'] ?? "N/A"}'),
                      _buildInfoRow(Icons.location_on,
                          '${getLocalizedText("الموقع", "Location", "مکان", "شوێن", "Ýerleşýän ýeri")}: ${center['addressCenter'] ?? "N/A"}'),
                      Divider(),
                      _buildInfoRow(
                        Icons.calendar_today,
                        '${getLocalizedText("تاريخ الإنتاج", "Production Date", "تاریخ تولید", "بەرواری بەرهەمهێنان", "Öndürilen senesi")}: ${labMaterial['productionDate'] != null ? DateFormat('yyyy-MM-dd').format(DateTime.parse(labMaterial['productionDate'])) : "N/A"}',
                      ),
                      _buildInfoRow(
                        Icons.hourglass_empty,
                        '${getLocalizedText("تاريخ انتهاء الصلاحية", "Expiry Date", "تاریخ انقضا", "بەرواری بەسەرچوون", "Möhleti gutarýan senesi")}: ${labMaterial['expiryDate'] != null ? DateFormat('yyyy-MM-dd').format(DateTime.parse(labMaterial['expiryDate'])) : "N/A"}',
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
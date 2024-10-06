import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medicapp/languages/lang.dart';

class Cart2 extends StatefulWidget {
  final Language language;

  Cart2({Key? key, required this.language}) : super(key: key);

  @override
  _Cart2State createState() => _Cart2State();
}

class _Cart2State extends State<Cart2> {
  List<dynamic> receipts = [];
  bool isLoading = true;
  String? errorMessage;
  String? jwtToken;
  late TextDirection textDirection;

  @override
  void initState() {
    super.initState();
    setTextDirection();
    fetchJwtToken();
  }

  void setTextDirection() {
    textDirection = widget.language == Language.Arabic ||
        widget.language == Language.Persian ||
        widget.language == Language.Kurdish
        ? TextDirection.rtl
        : TextDirection.ltr;
  }

  Future<void> fetchJwtToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      jwtToken = prefs.getString('token');
    });
    fetchPatientReceipts();
  }

  Future<void> fetchPatientReceipts() async {
    if (jwtToken == null) {
      setState(() {
        errorMessage = getLocalizedText(
            'الرمز غير متوفر',
            'Token is not available',
            'توکن در دسترس نیست',
            'تۆکن بەردەست نییە',
            'Token elýeterli däl'
        );
        isLoading = false;
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('https://medicalpoint-api.tatwer.tech/api/Mobile/GetPatientReceipts'),
        headers: {
          'Authorization': 'Bearer $jwtToken',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          receipts = data['data'];
          isLoading = false;
        });
      } else {
        throw Exception(getLocalizedText(
            'فشل في تحميل الإيصالات',
            'Failed to load receipts',
            'بارگیری رسیدها ناموفق بود',
            'بارکردنی پسووڵەکان سەرکەوتوو نەبوو',
            'Reseptleri ýükläp bolmady'
        ));
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
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
                'الحالة المرضية الكاملة',
                'Complete Medical Condition',
                'وضعیت کامل پزشکی',
                'دۆخی تەندروستی تەواو',
                'Doly lukmançylyk ýagdaýy'
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
            ? Center(child: Text(errorMessage!, style: TextStyle(color: Colors.red, fontSize: 18)))
            : receipts.isEmpty
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
                    'لا يوجد تشخيص',
                    'No diagnosis',
                    'تشخیصی وجود ندارد',
                    'هیچ نەخۆشییەک نییە',
                    'Anyklaýyş ýok'
                ),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF5CBBE3)),
              ),
            ],
          ),
        )
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: receipts.length,
            itemBuilder: (context, index) {
              final receipt = receipts[index];
              final notes = receipt['notes'] ?? getLocalizedText(
                  'لا توجد ملاحظات متاحة',
                  'No notes available',
                  'یادداشتی در دسترس نیست',
                  'هیچ تێبینیەک بەردەست نییە',
                  'Bellik ýok'
              );

              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(
                    getLocalizedText(
                        'ملاحظات الحالة المرضية:',
                        'Medical Condition Notes:',
                        'یادداشت‌های وضعیت پزشکی:',
                        'تێبینیەکانی دۆخی تەندروستی:',
                        'Lukmançylyk ýagdaýy boýunça bellikler:'
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5CBBE3),
                    ),
                  ),
                  subtitle: Text(
                    notes,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
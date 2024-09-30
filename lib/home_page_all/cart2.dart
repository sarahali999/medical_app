import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Cart2 extends StatefulWidget {
  @override
  _Cart2State createState() => _Cart2State();
}

class _Cart2State extends State<Cart2> {
  List<dynamic> receipts = [];
  bool isLoading = true;
  String? errorMessage;
  String? jwtToken;

  @override
  void initState() {
    super.initState();
    fetchJwtToken();
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
        errorMessage = 'Token is not available';
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
        throw Exception('Failed to load receipts');
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'الحالة المرضية الكاملة',
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
          ? Center(child: Text('لا توجد معلومات متاحة', style: TextStyle(fontSize: 18)))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: receipts.length,
          itemBuilder: (context, index) {
            final receipt = receipts[index];
            // Extract the 'notes' field
            final notes = receipt['notes'] ?? 'لا توجد ملاحظات متاحة';

            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(
                  'ملاحظات الحالة المرضية:',
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
    );
  }
}

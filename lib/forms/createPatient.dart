import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> submitPatientData({
  required String firstName,
  required String secondName,
  required String thirdName,
  required int gender,
  required String address,
  required String birthYear,
  required String country,
  required String province,
  required String district,
  required String alley,
  required String house,
  required int bloodType,
  required String email,
  required String chronicDiseases,
  required String allergies,
  required String emergencyContactFullName,
  required String emergencyContactAddress,
  required String emergencyContactCountry,
  required String emergencyContactProvince,
  required String emergencyContactDistrict,
  required String emergencyContactAlley,
  required String emergencyContactHouse,
  required String emergencyContactPhoneNumber,
  required String emergencyContactRelationship,
  required String password,
  required String phoneNumber,
  required String username,
}) async {
  final url = Uri.parse('http://medicalpoint-api.tatwer.tech/Patients/CreatePatient');

  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'FirstName': firstName,
      'SecondName': secondName,
      'ThirdName': thirdName,
      'Gender': gender,
      'Address': address,
      'BirthYear': birthYear,
      'Country': country,
      'Province': province,
      'District': district,
      'Alley': alley,
      'House': house,
      'BloodType': bloodType,
      'Email': email,
      'ChronicDiseases': chronicDiseases,
      'Allergies': allergies,
      'EmergencyContactFullName': emergencyContactFullName,
      'EmergencyContactAddress': emergencyContactAddress,
      'EmergencyContactCountry': emergencyContactCountry,
      'EmergencyContactProvince': emergencyContactProvince,
      'EmergencyContactDistrict': emergencyContactDistrict,
      'EmergencyContactAlley': emergencyContactAlley,
      'EmergencyContactHouse': emergencyContactHouse,
      'EmergencyContactPhoneNumber': emergencyContactPhoneNumber,
      'EmergencyContactRelationship': emergencyContactRelationship,
      'Password': password,
      'PhoneNumber': phoneNumber,
      'Username': username,
    }),
  );

  if (response.statusCode == 200) {
    // Successfully sent data
    print('Patient data submitted successfully');
  } else {
    // Failed to send data
    print('Failed to submit patient data');
  }
}

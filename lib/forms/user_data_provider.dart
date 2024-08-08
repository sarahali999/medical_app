import 'package:flutter/foundation.dart';
class UserDataProvider extends ChangeNotifier {
  String firstName = '';
  String secondName = '';
  String thirdName = '';
  DateTime? dateOfBirth;
  String gender = '';
  String phoneNumber = '';
  String bloodType = '';
  String chronicDiseases = '';
  String allergies = '';
  String emergencyContactName = '';
  String emergencyContactRelationship = '';
  String emergencyContactPhone = '';

  void updatePersonalInfo({
    String? firstName,
    String? secondName,
    String? thirdName,
    DateTime? dateOfBirth,
    String? gender,
    String? phoneNumber,
  }) {
    if (firstName != null) this.firstName = firstName;
    if (secondName != null) this.secondName = secondName;
    if (thirdName != null) this.thirdName = thirdName;
    if (dateOfBirth != null) this.dateOfBirth = dateOfBirth;
    if (gender != null) this.gender = gender;
    if (phoneNumber != null) this.phoneNumber = phoneNumber;
    notifyListeners();
  }

  void updateMedicalInfo({
    String? bloodType,
    String? chronicDiseases,
    String? allergies,
  }) {
    if (bloodType != null) this.bloodType = bloodType;
    if (chronicDiseases != null) this.chronicDiseases = chronicDiseases;
    if (allergies != null) this.allergies = allergies;
    notifyListeners();
  }

  void updateEmergencyContact({
    String? name,
    String? relationship,
    String? phone,
  }) {
    if (name != null) this.emergencyContactName = name;
    if (relationship != null) this.emergencyContactRelationship = relationship;
    if (phone != null) this.emergencyContactPhone = phone;
    notifyListeners();
  }
}
class Patient {
  final String fullName;
  final int birthYear;
  final String bloodType;
  final String chronicDiseases;
  final String allergies;
  final String phoneNumber;
  final String email;
  final String gender;
  final String country;
  final String province;
  final String district;
  final String alley;
  final String house;
  final String emergencyContactFullName;
  final String emergencyContactAddress;
  final String emergencyContactPhoneNumber;
  final int emergencyContactRelationship;

  Patient({
    required this.fullName,
    required this.birthYear,
    required this.bloodType,
    required this.chronicDiseases,
    required this.allergies,
    required this.phoneNumber,
    required this.email,
    required this.gender,
    required this.country,
    required this.province,
    required this.district,
    required this.alley,
    required this.house,
    required this.emergencyContactFullName,
    required this.emergencyContactAddress,
    required this.emergencyContactPhoneNumber,
    required this.emergencyContactRelationship,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      fullName: json['user']['firstName'] ?? '',
      birthYear: int.parse(json['birthYear'] ?? '0'),
      bloodType: _bloodTypeToString(json['bloodType'] ?? 0),
      chronicDiseases: json['chronicDiseases'] ?? '',
      allergies: json['allergies'] ?? '',
      phoneNumber: json['user']['phoneNumber'] ?? '',
      email: json['user']['email'] ?? '',
      gender: _genderToString(json['gender'] ?? 0),
      country: json['country'] ?? '',
      province: json['province'] ?? '',
      district: json['district'] ?? '',
      alley: json['alley'] ?? '',
      house: json['house'] ?? '',
      emergencyContactFullName: json['emergencyContactFullName'] ?? '',
      emergencyContactAddress: json['emergencyContactAddress'] ?? '',
      emergencyContactPhoneNumber: json['emergencyContactPhoneNumber'] ?? '',
      emergencyContactRelationship: json['emergencyContactRelationship'] ?? 0,
    );
  }

  static String _bloodTypeToString(int bloodType) {
    switch (bloodType) {
      case 1:
        return 'A';
      case 2:
        return 'B';
      case 3:
        return 'AB';
      case 4:
        return 'O';
      default:
        return 'Unknown';
    }
  }

  static String _genderToString(int gender) {
    switch (gender) {
      case 1:
        return 'Male';
      case 2:
        return 'Female';
      default:
        return 'Unknown';
    }
  }
}

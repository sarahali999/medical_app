// File: lib/models/user_details.dart

class UserDetails {
  String? message;
  Data? data;
  bool? error;

  UserDetails({this.message, this.data, this.error});

  UserDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    error = json['error'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = this.error;
    return data;
  }
}

class Data {
  int? gender;

  String? address;
  String? country;
  String? province;
  String? district;
  String? alley;
  String? house;
  int? bloodType;
  String? chronicDiseases;
  String? allergies;
  String? birthYear;
  String? emergencyContactFullName;
  String? emergencyContactAddress;
  String? emergencyContactCountry;
  String? emergencyContactProvince;
  String? emergencyContactDistrict;
  String? emergencyContactAlley;
  String? emergencyContactHouse;
  String? emergencyContactPhoneNumber;
  int? emergencyContactRelationship;
  String? randomCode;
  String? userId;
  User? user;
  dynamic createdBy;
  dynamic createdById;
  dynamic modifiedBy;
  dynamic modifiedById;
  dynamic deletedBy;
  dynamic deletedById;
  String? createdAt;
  String? modifiedAt;
  dynamic deletedAt;
  bool? isDeleted;
  String? id;

  Data({
    this.gender,
    this.address,
    this.country,
    this.province,
    this.district,
    this.alley,
    this.house,
    this.bloodType,
    this.chronicDiseases,
    this.allergies,
    this.birthYear,
    this.emergencyContactFullName,
    this.emergencyContactAddress,
    this.emergencyContactCountry,
    this.emergencyContactProvince,
    this.emergencyContactDistrict,
    this.emergencyContactAlley,
    this.emergencyContactHouse,
    this.emergencyContactPhoneNumber,
    this.emergencyContactRelationship,
    this.randomCode,
    this.userId,
    this.user,
    this.createdBy,
    this.createdById,
    this.modifiedBy,
    this.modifiedById,
    this.deletedBy,
    this.deletedById,
    this.createdAt,
    this.modifiedAt,
    this.deletedAt,
    this.isDeleted,
    this.id
  });

  Data.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    address = json['address'];
    country = json['country'];
    province = json['province'];
    district = json['district'];
    alley = json['alley'];
    house = json['house'];
    bloodType = json['bloodType'];
    chronicDiseases = json['chronicDiseases'];
    allergies = json['allergies'];
    birthYear = json['birthYear'];
    emergencyContactFullName = json['emergencyContactFullName'];
    emergencyContactAddress = json['emergencyContactAddress'];
    emergencyContactCountry = json['emergencyContactCountry'];
    emergencyContactProvince = json['emergencyContactProvince'];
    emergencyContactDistrict = json['emergencyContactDistrict'];
    emergencyContactAlley = json['emergencyContactAlley'];
    emergencyContactHouse = json['emergencyContactHouse'];
    emergencyContactPhoneNumber = json['emergencyContactPhoneNumber'];
    emergencyContactRelationship = json['emergencyContactRelationship'];
    randomCode = json['randomCode'];
    userId = json['userId'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    createdBy = json['createdBy'];
    createdById = json['createdById'];
    modifiedBy = json['modifiedBy'];
    modifiedById = json['modifiedById'];
    deletedBy = json['deletedBy'];
    deletedById = json['deletedById'];
    createdAt = json['createdAt'];
    modifiedAt = json['modifiedAt'];
    deletedAt = json['deletedAt'];
    isDeleted = json['isDeleted'];
    id = json['id'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['country'] = this.country;
    final String? randomCode;

    data['province'] = this.province;
    data['district'] = this.district;
    data['alley'] = this.alley;
    data['house'] = this.house;
    data['bloodType'] = this.bloodType;
    data['chronicDiseases'] = this.chronicDiseases;
    data['allergies'] = this.allergies;
    data['birthYear'] = this.birthYear;
    data['emergencyContactFullName'] = this.emergencyContactFullName;
    data['emergencyContactAddress'] = this.emergencyContactAddress;
    data['emergencyContactCountry'] = this.emergencyContactCountry;
    data['emergencyContactProvince'] = this.emergencyContactProvince;
    data['emergencyContactDistrict'] = this.emergencyContactDistrict;
    data['emergencyContactAlley'] = this.emergencyContactAlley;
    data['emergencyContactHouse'] = this.emergencyContactHouse;
    data['emergencyContactPhoneNumber'] = this.emergencyContactPhoneNumber;
    data['emergencyContactRelationship'] = this.emergencyContactRelationship;
    data['randomCode'] = this.randomCode;
    data['userId'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['createdBy'] = this.createdBy;
    data['createdById'] = this.createdById;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedById'] = this.modifiedById;
    data['deletedBy'] = this.deletedBy;
    data['deletedById'] = this.deletedById;
    data['createdAt'] = this.createdAt;
    data['modifiedAt'] = this.modifiedAt;
    data['deletedAt'] = this.deletedAt;
    data['isDeleted'] = this.isDeleted;
    data['id'] = this.id;
    return data;
  }
}

class User {
  String? username;
  String? password;
  int? role;
  String? phoneNumber;
  String? email;
  String? firstName;
  String? secondName;
  String? thirdName;
  String? createdAt;
  String? modifiedAt;
  dynamic deletedAt;
  bool? isDeleted;
  String? id;

  User({
    this.username,
    this.password,
    this.role,
    this.phoneNumber,
    this.email,
    this.firstName,
    this.secondName,
    this.thirdName,
    this.createdAt,
    this.modifiedAt,
    this.deletedAt,
    this.isDeleted,
    this.id
  });

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    role = json['role'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    firstName = json['firstName'];
    secondName = json['secondName'];
    thirdName = json['thirdName'];
    createdAt = json['createdAt'];
    modifiedAt = json['modifiedAt'];
    deletedAt = json['deletedAt'];
    isDeleted = json['isDeleted'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['role'] = this.role;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['secondName'] = this.secondName;
    data['thirdName'] = this.thirdName;
    data['createdAt'] = this.createdAt;
    data['modifiedAt'] = this.modifiedAt;
    data['deletedAt'] = this.deletedAt;
    data['isDeleted'] = this.isDeleted;
    data['id'] = this.id;
    return data;
  }
}
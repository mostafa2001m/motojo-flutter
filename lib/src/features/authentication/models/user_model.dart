import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;
   String? photoUrl;
   String? accountType;
   

  UserModel(
     {
    this.id,
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.password,
    this.photoUrl,
    this.accountType,
  });

// Serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNo': phoneNo,
      'password': password,
      'photoUrl': photoUrl,
      'email': email,
    };
  }

  // Deserialization
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      fullName: map['fullName'],
      phoneNo: map['phoneNo'],
      password: map['password'],
      photoUrl: map['photoUrl'],
      email: map['email'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "Phone": phoneNo,
      "Password": password,
      "PhotoUrl": photoUrl,
      "AccountType":accountType
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      fullName: data["FullName"],
      email: data["Email"],
      phoneNo: data["Phone"],
      password: data["Password"],
      photoUrl: data["PhotoUrl"],
      accountType:data["AccountType"]
    );
  }
}

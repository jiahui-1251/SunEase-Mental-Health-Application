import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? UserID;
  final String UserName;
  final String email;
  final String password;
  final String UserType;

  const UserModel({
    this.UserID,
    required this.UserName,
    required this.email,
    required this.password,
    required this.UserType,
  });

  Map<String, dynamic> toJson() {
    return {
      "UserID": UserID,
      "Email": email,
      "UserName": UserName,
      "Password": password,
      "UserType": UserType,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return UserModel(
      UserID: document.id,
      email: data["Email"],
      password: data["Password"],
      UserName: data["UserName"],
      UserType: data["UserType"],
    );
  }
}


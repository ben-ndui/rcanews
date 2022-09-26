import 'package:cloud_firestore/cloud_firestore.dart';

class SmoothUserModel {
  String userId;
  String firstName;
  String lastName;
  String pseudo;
  String email;

  SmoothUserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.pseudo,
    required this.email,
  });

  factory SmoothUserModel.fromJson(json) {
    print(json.data());
    return SmoothUserModel(
      userId: json['userId'] ?? "",
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      pseudo: json['pseudo'] ?? "",
      email: json['email'] ?? "",
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'pseudo': pseudo,
      'email': email,
    };
  }

  void updateUserFields(SmoothUserModel userModel){
    userId = userModel.userId;
    firstName = userModel.firstName;
    lastName = userModel.lastName;
    pseudo = userModel.pseudo;
    email = userModel.email;
  }
}

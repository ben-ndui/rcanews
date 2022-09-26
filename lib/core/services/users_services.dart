import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rcanews/core/models/smooth_user_model.dart';

class UsersServices {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  final String collName = "users";
  final String all = "all";

  FirebaseFirestore getInstance() => _instance;

  String getNewId() {
    return _instance.collection(collName).doc().id;
  }

  Future<SmoothUserModel> getUser(User user) {
    print(user.uid);
    return _instance
        .collection(collName)
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot doc) => SmoothUserModel.fromJson(doc));
  }

  SmoothUserModel userFromFirebaseUser(event) =>
      SmoothUserModel.fromJson(event);

  void saveUser(SmoothUserModel userModel) {
    try {
      _instance
          .collection(collName)
          .doc(userModel.userId)
          .set(userModel.toJson());
    } on FirebaseException catch (e) {
      print("Can't save user ${e.toString()}");
    }
  }

  void updateUser(SmoothUserModel userModel) {
    try {
      _instance
          .collection(collName)
          .doc(userModel.userId)
          .update(userModel.toJson());
    } on FirebaseException catch (e) {
      print("Can't update user ${e.toString()}");
    }
  }

  void deleteUser(SmoothUserModel userModel) {
    try {
      _instance.collection(collName).doc(userModel.userId).delete();
    } on FirebaseException catch (e) {
      print("Can't delete user ${e.toString()}");
    }
  }

  Stream<List<SmoothUserModel>>? getAllUsers() {
    try {
      return _instance.collection(collName).snapshots().map((event) =>
          event.docs.map((e) => SmoothUserModel.fromJson(e)).toList());
    } on FirebaseException catch (e) {
      //SmoothError(message: "Can't get all user favorite ${e.toString()}");
      return null;
    }
  }
}

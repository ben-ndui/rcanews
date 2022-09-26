import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rcanews/core/models/smooth_article.dart';

class ArticlesServices{
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  final String collName = "articles";
  final String all = "all";

  FirebaseFirestore getInstance() => _instance;

  String getNewId() {
    return _instance.collection(collName).doc().id;
  }

  void saveArticle(SmoothArticle article) {
    try {
      _instance
          .collection(collName)
          .doc(article.uid)
          .set(article.toJson());
    } on FirebaseException catch (e) {
      print("Can't save articles ${e.toString()}");
    }
  }

  void updateArticles(SmoothArticle article) {
    try {
      _instance
          .collection(collName)
          .doc(article.uid)
          .update(article.toJson());
    } on FirebaseException catch (e) {
      print("Can't update articles ${e.toString()}");
    }
  }

  void deleteArticles(SmoothArticle article) {
    try {
      _instance
          .collection(collName)
          .doc(article.uid)
          .delete();
    } on FirebaseException catch (e) {
      print("Can't delete articles ${e.toString()}");
    }
  }

  Stream<List<SmoothArticle>>? getAllArticles() {
    try {
      return _instance
          .collection(collName)
          .snapshots()
          .map((event) => event.docs.map((e) => SmoothArticle.fromJson(e)).toList());
    } on FirebaseException catch (e) {
      //SmoothError(message: "Can't get all user favorite ${e.toString()}");
      return null;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rcanews/core/models/smooth_article.dart';
import 'package:rcanews/core/models/smooth_user_model.dart';
import 'package:rcanews/core/common/smooth_error.dart';

class FavoritesServices {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  final String collName = "favorites";
  final String all = "all";

  FirebaseFirestore getInstance() => _instance;

  void saveFavorite(SmoothUserModel userModel, SmoothArticle article) {
    try {
      _instance
          .collection(collName)
          .doc(userModel.userId)
          .collection(all)
          .doc(article.uid)
          .set(article.toJson());
    } on FirebaseException catch (e) {
      print("Can't save to favorite ${e.toString()}");
    }
  }

  void updateFavorite(SmoothUserModel userModel, SmoothArticle article) {
    try {
      _instance
          .collection(collName)
          .doc(userModel.userId)
          .collection(all)
          .doc(article.uid)
          .update(article.toJson());
    } on FirebaseException catch (e) {
      print("Can't update favorite ${e.toString()}");
    }
  }

  void deleteFavorite(SmoothUserModel userModel, SmoothArticle article) {
    try {
      _instance
          .collection(collName)
          .doc(userModel.userId)
          .collection(all)
          .doc(article.uid)
          .delete();
    } on FirebaseException catch (e) {
      print("Can't delete user favorite ${e.toString()}");
    }
  }

  Stream<List<SmoothArticle>>? getAllFavoritesByUser(SmoothUserModel userModel) {
    try {
      return _instance
          .collection(collName)
          .doc(userModel.userId)
          .collection(all)
          .snapshots()
          .map((event) => event.docs.map((e) => SmoothArticle.fromJson(e)).toList());
    } on FirebaseException catch (e) {
      //SmoothError(message: "Can't get all user favorite ${e.toString()}");
      return null;
    }
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rcanews/core/models/smooth_user_model.dart';
import 'package:rcanews/core/services/users_services.dart';
import 'package:rcanews/router/router.gr.dart';

class AuthenticationService extends ChangeNotifier{
  final FirebaseAuth _instance = FirebaseAuth.instance;

  FirebaseAuth auth() => _instance;

  Stream<User?> authChanges() {
    return _instance.authStateChanges();
  }

  Future<SmoothUserModel?> registerWithEmailAndPassword(
      SmoothUserModel userModel, String pass) async {
    try {
      final UserCredential credential =
          await _instance.createUserWithEmailAndPassword(
              email: userModel.email, password: pass);
      final User? user = credential.user;

      if (user != null) {
        final usr = SmoothUserModel(
          userId: user.uid,
          firstName: userModel.firstName,
          lastName: userModel.lastName,
          pseudo: userModel.pseudo,
          email: userModel.email,
        );
        UsersServices().saveUser(usr);
        return UsersServices().getUser(user);
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.toString()}");
      return null;
    }
  }

  Future<SmoothUserModel?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential credential = await _instance
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = credential.user;

      if (user != null) {
        print("login: ${user.uid}");
        return UsersServices().getUser(user);
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.toString()}");
      return null;
    }
  }

  Future<void> logout(BuildContext context) async {
    //print("alors ?");
    await FirebaseAuth.instance.signOut();
    notifyListeners();
    context.router.replace(const Home());
  }
}

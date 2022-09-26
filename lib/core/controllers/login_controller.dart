import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rcanews/core/common/configs.dart';
import 'package:rcanews/core/controllers/home_controller.dart';
import 'package:rcanews/core/models/smooth_user_model.dart';
import 'package:rcanews/core/services/authentication_services.dart';
import 'package:rcanews/core/common/smooth_colors.dart';
import 'package:rcanews/core/common/smooth_enums.dart';
import 'package:rcanews/core/widgets/smooth_text.dart';
import 'package:rcanews/router/router.gr.dart';

class LoginController extends ChangeNotifier {
  TextEditingController pseudoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  String pseudo = "";
  String email = "";
  String firstName = "";
  String lastName = "";
  String pwd = "";

  SmoothType type = SmoothType.login;

  bool activeForm = false;

  bool isLoading = false;

  void toggleLoading(){
    isLoading = !isLoading;
    notifyListeners();
  }

  void setValue(String whichOne, String val) {
    switch (whichOne) {
      case "pseudo":
        pseudo = val;
        break;
      case "email":
        email = val;
        break;
      case "first":
        firstName = val;
        break;
      case "last":
        lastName = val;
        break;
      case "pwd":
        pwd = val;
        break;
      default:
        break;
    }
    notifyListeners();
  }

  void submit(BuildContext context) {
    toggleLoading();
    switch (type) {
      case SmoothType.login:
        login(context);
        break;
      case SmoothType.register:
        register(context);
        break;
      default:
        break;
    }
    notifyListeners();
  }

  void register(BuildContext context) {
    final userModel = SmoothUserModel(
      userId: "userId",
      firstName: firstName,
      lastName: lastName,
      pseudo: pseudo,
      email: email,
    );
    AuthenticationService()
        .registerWithEmailAndPassword(userModel, pwd)
        .then(
      (value) {
        if (value != null) {
          context.read<HomeController>().initCurrentUser(value);
          context.router.replace(const Home());
          toggleLoading();
        } else {
          toggleLoading();
          buildSmoothSnackbar(
            context: context,
            message:
                "Création de compute impossible, veuillez réessayer ultérieurement s'il vous plait !",
          );
        }
      },
    );
  }

  void login(BuildContext context) {
    AuthenticationService().loginWithEmailAndPassword(email, pwd).then(
      (result) {
        if (result != null) {
          context.read<HomeController>().initCurrentUser(result);
          context.router.replace(const Home());
          toggleLoading();
        } else {
          toggleLoading();
          buildSmoothSnackbar(
            context: context,
            message:
                "Connexion impossible, veuillez vérifier vos identifiants de connexion s'il vous plait !",
          );
        }
      },
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      buildSmoothSnackbar({
    required BuildContext context,
    required String message,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: SmoothColors.danger,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SmoothConfig.screenWidth!),
        ),
        content: SmoothText(
          text: message,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void toggleForm() {
    activeForm = !activeForm;

    if (activeForm) {
      type = SmoothType.register;
    } else {
      type = SmoothType.login;
    }
    notifyListeners();
  }
}

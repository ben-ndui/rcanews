import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rcanews/core/common/configs.dart';
import 'package:rcanews/core/controllers/login_controller.dart';
import 'package:rcanews/core/common/smooth_colors.dart';
import 'package:rcanews/core/common/smooth_enums.dart';
import 'package:rcanews/core/common/smooth_utils.dart';
import 'package:rcanews/core/widgets/smooth_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Consumer<LoginController>(
      builder: (context, controller, child) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            smoothFadeIn(
              child: Container(
                alignment: Alignment.center,
                width: SmoothConfig.screenWidth,
                height: SmoothConfig.screenHeight,
                child: Image.asset(
                  "assets/images/back2.jpg",
                  width: SmoothConfig.screenWidth,
                  height: SmoothConfig.screenHeight,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SmoothConfig.screenWidth! * 0.11,
                    ),
                    child: const SmoothText(
                      text:
                          "Une fois connecté, tu pourras publier et partager ton artiste du moment !!",
                      align: TextAlign.justify,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  buildLoginForm(controller, context),
                  SizedBox(height: SmoothConfig.screenWidth! * 0.12),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SmoothText(
                        text: controller.activeForm
                            ? "J'ai déja un compte"
                            : "Je n'ai pas encore de compte",
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Switch(
                        value: controller.activeForm,
                        onChanged: (val) => controller.toggleForm(),
                        activeColor: SmoothColors.danger,
                        inactiveTrackColor:
                            SmoothColors.secondary.withOpacity(0.5),
                        activeTrackColor: SmoothColors.secondary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: SmoothConfig.screenWidth! * 0.07,
                horizontal: SmoothConfig.screenWidth! * 0.07,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      context.router.pop();
                    },
                    style: TextButton.styleFrom(side: BorderSide.none),
                    child: SmoothText(
                      text: "Retour à l'accueil",
                      style: TextStyle(
                        color: SmoothColors.danger,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: controller.isLoading,
              child: Container(
                color: SmoothColors.white,
                width: SmoothConfig.screenWidth,
                height: SmoothConfig.screenHeight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/json/world2.json"),
                    SmoothText(
                      text: "Connexion en cours..",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: SmoothColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildLoginForm(LoginController controller, BuildContext context) {
    switch (controller.type) {
      case SmoothType.register:
        return smoothFadeIn(
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildTextFormField(
                  label: "Pseudo",
                  placeHolder: "pseudo",
                  controller: controller.pseudoController,
                  onSubmitted: (val) => controller.setValue("pseudo", val),
                ),
                buildTextFormField(
                  label: "Email",
                  placeHolder: "email",
                  controller: controller.emailController,
                  onSubmitted: (val) => controller.setValue("email", val),
                ),
                buildTextFormField(
                  label: "Nom",
                  placeHolder: "nom",
                  controller: controller.firstNameController,
                  onSubmitted: (val) => controller.setValue("first", val),
                ),
                buildTextFormField(
                  label: "Prénom",
                  placeHolder: "prénom",
                  controller: controller.lastNameController,
                  onSubmitted: (val) => controller.setValue("last", val),
                ),
                buildTextFormField(
                  label: "Mot de passe",
                  placeHolder: "*******",
                  hidden: true,
                  controller: controller.pwdController,
                  onSubmitted: (val) => controller.setValue("pwd", val),
                ),
                SizedBox(
                  height: SmoothConfig.screenHeight! * 0.05,
                ),
                buildSmoothButton(
                    title: "Je m'inscris",
                    action: () {
                      controller.submit(context);
                    }),
              ],
            ),
          ),
        );
      default:
        return smoothFadeIn(
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildTextFormField(
                  label: "Email",
                  placeHolder: "email",
                  controller: controller.emailController,
                  onSubmitted: (val) => controller.setValue("email", val),
                ),
                buildTextFormField(
                  label: "Mot de passe",
                  placeHolder: "*******",
                  hidden: true,
                  controller: controller.pwdController,
                  onSubmitted: (val) => controller.setValue("pwd", val),
                ),
                SizedBox(
                  height: SmoothConfig.screenHeight! * 0.05,
                ),
                buildSmoothButton(
                    title: "Me connecter",
                    action: () {
                      controller.submit(context);
                    }),
              ],
            ),
          ),
        );
    }
  }

  Widget buildTextFormField({
    required String label,
    required String placeHolder,
    bool? hidden,
    TextEditingController? controller,
    void Function(String)? onSubmitted,
  }) {
    return smoothFadeIn(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SmoothConfig.screenWidth! * 0.12,
          vertical: SmoothConfig.screenWidth! * 0.03,
        ),
        child: TextFormField(
          controller: controller,
          obscureText: hidden ?? false,
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
          onFieldSubmitted: onSubmitted,
          onChanged: onSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: SmoothConfig.screenWidth! * 0.05,
              vertical: SmoothConfig.screenWidth! * 0.05,
            ),
            alignLabelWithHint: true,
            labelText: label,
            hintText: placeHolder,
            border: const UnderlineInputBorder(),
          ),
        ),
      ),
    );
  }
}

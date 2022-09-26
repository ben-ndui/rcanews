import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rcanews/core/common/configs.dart';
import 'package:rcanews/core/common/smooth_colors.dart';
import 'package:rcanews/core/common/smooth_utils.dart';
import 'package:rcanews/core/widgets/smooth_drawer/smooth_drawer_controller.dart';
import 'package:rcanews/core/widgets/smooth_text.dart';

class DrawerDetails extends StatefulWidget {
  const DrawerDetails({Key? key}) : super(key: key);

  @override
  State<DrawerDetails> createState() => _DrawerDetailsState();
}

class _DrawerDetailsState extends State<DrawerDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SmoothDrawerController>(
      builder: (context, controller, child) {
        return Scaffold(
          body: Stack(
            children: [
              smoothFadeIn(
                child: Container(
                  alignment: Alignment.center,
                  width: SmoothConfig.screenWidth,
                  height: SmoothConfig.screenHeight,
                  child: Image.asset(
                    "assets/images/back3.jpg",
                    width: SmoothConfig.screenWidth,
                    height: SmoothConfig.screenHeight,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              buildBody(context: context, controller: controller),
            ],
          ),
        );
      },
    );
  }

  Widget buildBody({
    required BuildContext context,
    required SmoothDrawerController controller,
  }) {
    return ListView(
      children: [
        buildSmoothAppBar(context, controller.getScaffoldKey(), details: true),
        buildPageTitle(title: controller.pageTitle),
        body(pageTitle: controller.pageTitle),
      ],
    );
  }

  Widget body({required String pageTitle}) {
    switch (pageTitle) {
      case "Propos":
        return aboutUsScreen();
      case "Nous contacter":
        return contactUsScreen();
      case "CGU / CGV":
        return cgucgvScreen();
      default:
        return premiumScreen();
    }
  }

  Widget premiumScreen() {
    return smoothFadeIn(
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SmoothConfig.screenWidth! * 0.04),
            child: Column(
              children: [
                SmoothText(
                  align: TextAlign.justify,
                  text:
                      "Le mode premium arrivera bientôt avec de nombreuses fonctionalités tel qu'une messagerie instantané innovante, la prise en charge du 'SANGO' deuxieme langue officiel centrafricains, le partage des articles via les réseaux sociaux (Facebook, Instagram, Twitter) et bien d'autres fonctionnalité sympatique à venir !",
                  style: TextStyle(
                    color: SmoothColors.black,
                  ),
                ),
                SizedBox(
                  height: SmoothConfig.screenHeight! * 0.05,
                ),
                //buildSmoothButton(title: "Acceder")
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget cgucgvScreen() {
    return smoothFadeIn(
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SmoothConfig.screenWidth! * 0.04),
            child: Column(
              children: [
                SmoothText(
                  text:
                      "Reveille cliquer sur le lien suivant pour acceder à notre CGU / CGV.",
                  style: TextStyle(
                    color: SmoothColors.primary,
                  ),
                ),
                SizedBox(
                  height: SmoothConfig.screenHeight! * 0.05,
                ),
                buildSmoothButton(title: "Acceder")
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget contactUsScreen() {
    return smoothFadeIn(
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SmoothConfig.screenWidth! * 0.04),
            child: SmoothText(
              align: TextAlign.justify,
              text:
                  "Pour toute collaboration ou demande de partenariat, veuillez s'il vous plait utiliser les moyens de communication suivant :",
              style: TextStyle(fontSize: SmoothConfig.screenWidth! * 0.04),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: SmoothConfig.screenWidth! * 0.01,
              horizontal: SmoothConfig.screenWidth! * 0.04,
            ),
            child: SmoothText(
              align: TextAlign.justify,
              text: "- contact.smoothdesign@gmail.com",
              style: TextStyle(
                fontSize: SmoothConfig.screenWidth! * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: SmoothConfig.screenWidth! * 0.01,
              horizontal: SmoothConfig.screenWidth! * 0.04,
            ),
            child: SmoothText(
              align: TextAlign.justify,
              text: "- via instagram : @smoothandesign",
              style: TextStyle(
                fontSize: SmoothConfig.screenWidth! * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget aboutUsScreen() {
    return smoothFadeIn(
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SmoothConfig.screenWidth! * 0.04),
            child: SmoothText(
              align: TextAlign.justify,
              text:
                  "RCA News est une application de type informative développé par Smooth & Design.\n\nElle a pour objectif de centraliser, mettre en avant et faire découvrir des artistes centrafricains basés partout ailleurs dans le monde a leur pairs.\n\nOn peut y découvrir des artistes selon les catégories suivants :",
              style: TextStyle(fontSize: SmoothConfig.screenWidth! * 0.04),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: SmoothConfig.screenWidth! * 0.01,
              horizontal: SmoothConfig.screenWidth! * 0.04,
            ),
            child: SmoothText(
              align: TextAlign.justify,
              text: "- Art",
              style: TextStyle(
                fontSize: SmoothConfig.screenWidth! * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: SmoothConfig.screenWidth! * 0.01,
              horizontal: SmoothConfig.screenWidth! * 0.04,
            ),
            child: SmoothText(
              align: TextAlign.justify,
              text: "- Musique",
              style: TextStyle(
                fontSize: SmoothConfig.screenWidth! * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: SmoothConfig.screenWidth! * 0.01,
              horizontal: SmoothConfig.screenWidth! * 0.04,
            ),
            child: SmoothText(
              align: TextAlign.justify,
              text:
                  "Ou tout simplement suivre l'actualité via un cannal ou application dédié !",
              style: TextStyle(fontSize: SmoothConfig.screenWidth! * 0.04),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: SmoothConfig.screenWidth! * 0.01,
              horizontal: SmoothConfig.screenWidth! * 0.04,
            ),
            child: SmoothText(
              align: TextAlign.justify,
              text:
                  "L'objectif final serait de proposer cette application a la radio nationnal centrafricaine 'RADIO NDEKE LUKA' et permettre ainsi à tout les centrafricains et centrafricaine de disposer d'une application dédié à l'information tel que CNEWS, BFMNEWS ou autres. ",
              style: TextStyle(fontSize: SmoothConfig.screenWidth! * 0.04),
            ),
          ),
        ],
      ),
    );
  }
}

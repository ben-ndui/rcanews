import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rcanews/core/common/configs.dart';
import 'package:rcanews/core/controllers/home_controller.dart';
import 'package:rcanews/core/models/smooth_article.dart';
import 'package:rcanews/core/common/smooth_colors.dart';
import 'package:rcanews/core/common/smooth_enums.dart';
import 'package:rcanews/core/common/smooth_utils.dart';
import 'package:rcanews/core/widgets/smooth_article_widget.dart';
import 'package:rcanews/core/widgets/smooth_text.dart';

class HomeDetails extends StatelessWidget {
  const HomeDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, child) {
        return Scaffold(
          extendBody: true,
          body: buildBody(context: context, controller: controller),
        );
      },
    );
  }

  Widget buildBody({
    required BuildContext context,
    required HomeController controller,
  }) {
    return ListView(
      shrinkWrap: true,
      children: [
        buildSmoothAppBar(context, controller.getScaffoldKey(),
            details: true, fromBottom: true),
        body(controller),
      ],
    );
  }

  Widget body(HomeController controller) {
    switch (controller.viewType) {
      case SmoothType.article:
        return buildArticleBody(controller);
      case SmoothType.listDetail:
        return buildListBody(controller);
      default:
        return buildArticleBody(controller);
    }
  }

  Widget buildArticleBody(HomeController controller) {
    return Column(
      children: [
        buildPageTitle(title: controller.articleSelected!.title),
        FadeIn(
          duration: const Duration(milliseconds: 800),
          child: Container(
            alignment: Alignment.center,
            width: SmoothConfig.screenWidth,
            height: SmoothConfig.screenHeight! * 0.35,
            color: SmoothColors.black.withOpacity(0.3),
            child: FaIcon(
              FontAwesomeIcons.image,
              size: SmoothConfig.screenWidth! * 0.1,
              color: SmoothColors.primary,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            vertical: SmoothConfig.screenWidth! * 0.02,
            horizontal: SmoothConfig.screenWidth! * 0.04,
          ),
          padding: EdgeInsets.symmetric(
            vertical: SmoothConfig.screenWidth! * 0.02,
            horizontal:
                SmoothConfig.screenWidth! * (controller.dezip ? 0.02 : 0.04),
          ),
          decoration: BoxDecoration(
            color: controller.dezip
                ? SmoothColors.transparent
                : SmoothColors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: controller.dezip
                ? []
                : [
                    BoxShadow(
                      color: SmoothColors.secondary.withOpacity(0.2),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                    )
                  ],
          ),
          child: Column(
            //shrinkWrap: true,
            children: [
              SmoothText(
                align: TextAlign.justify,
                text: controller.articleSelected!.description.length > 300 &&
                        !controller.dezip
                    ? "${controller.articleSelected!.description.substring(0, 500)}...."
                    : controller.articleSelected!.description,
                style: const TextStyle(),
              ),
              GestureDetector(
                onTap: () => controller.toggleDezip(),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        SmoothText(
                          align: TextAlign.justify,
                          text: controller.dezip ? "Réduire" : "Lire la suite",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: SmoothColors.secondary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(
                          width: 50.0,
                          height: 1.0,
                          color: SmoothColors.secondary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildListBody(HomeController controller) {
    return ListView(
      shrinkWrap: true,
      children: [
        buildPageTitle(title: controller.menuType!.title),
        StreamBuilder<List<SmoothArticle>>(
          stream: null,
          builder: (ctx, snap) {
            if (!snap.hasData) {
              return Container(
                alignment: Alignment.topCenter,
                width: SmoothConfig.screenWidth,
                height: SmoothConfig.screenHeight,
                padding: EdgeInsets.symmetric(
                  horizontal: SmoothConfig.screenWidth! * 0.045,
                ),
                child: SmoothText(
                  align: TextAlign.center,
                  text:
                      "Aucun article disponible dans cette catégorie pour le moment !",
                  style: TextStyle(
                    color: SmoothColors.black.withOpacity(0.5),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              );
            }
            if (snap.hasError) {
              return Container();
            }

            if (snap.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            final all = snap.data;

            return ListView.builder(
              shrinkWrap: true,
              itemCount: all!.length,
              itemBuilder: (ctx, index) {
                final article = all[index];
                return SmoothArticleWidget(
                  article: article,
                  pos: index,
                  action: () {
                    controller.selectArticle(ctx, article);
                  },
                );
              },
            );
          },
        )
      ],
    );
  }
}

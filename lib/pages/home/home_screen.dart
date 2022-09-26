import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rcanews/core/common/configs.dart';
import 'package:rcanews/core/controllers/home_controller.dart';
import 'package:rcanews/core/models/smooth_article.dart';
import 'package:rcanews/core/services/articles_services.dart';
import 'package:rcanews/core/services/authentication_services.dart';
import 'package:rcanews/core/services/favorites_services.dart';
import 'package:rcanews/core/common/smooth_colors.dart';
import 'package:rcanews/core/common/smooth_error.dart';
import 'package:rcanews/core/common/smooth_utils.dart';
import 'package:rcanews/core/widgets/bottomFloatingNavBar/smooth_custom_floating_bottom_nav_controller.dart';
import 'package:rcanews/core/widgets/bottomFloatingNavBar/smooth_custom_floating_bottom_bar.dart';
import 'package:rcanews/core/widgets/smooth_article_widget.dart';
import 'package:rcanews/core/widgets/smooth_drawer/smooth_drawer.dart';
import 'package:rcanews/core/widgets/smooth_loader.dart';
import 'package:rcanews/core/widgets/smooth_text.dart';
import 'package:rcanews/pages/authentication/auth_redirect.dart';

import '../../router/router.gr.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, child) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: SmoothDrawer().buildSmoothDrawer(),
          extendBody: true,
          backgroundColor: SmoothColors.white,
          body: Stack(
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
              buildBody(context: context, controller: controller),
            ],
          ),
          floatingActionButton: controller.currentUser != null
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SmoothConfig.screenWidth! * 0.2),
                  child: FloatingActionButton(
                    clipBehavior: Clip.antiAlias,
                    backgroundColor: SmoothColors.primary,
                    onPressed: () {
                      context.router.push(const Article());
                    },
                    child: const FaIcon(FontAwesomeIcons.plus),
                  ),
                )
              : Container(),
        );
      },
    );
  }

  Widget buildBody({
    required BuildContext context,
    required HomeController controller,
  }) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildSmoothAppBar(context, _scaffoldKey),
            buildPageTitle(title: controller.homeTitle.toUpperCase()),
            body(controller),
          ],
        ),
        const SmoothCustomFloatingBottomNavBar(),
      ],
    );
  }

  Widget body(HomeController controller) {
    return Consumer<SmoothBottomCustomFloatingNavController>(
      builder: (context, smoothBCFController, child) {
        switch (smoothBCFController.selected) {
          case 0:
            return controller.currentUser != null
                ? StreamBuilder<List<SmoothArticle>>(
                    stream: FavoritesServices().getAllFavoritesByUser(
                      controller.currentUser!,
                    ),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const SmoothLoader();
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SmoothLoader();
                      }

                      if (snapshot.hasError) {
                        return SmoothError(message: snapshot.error.toString());
                      }

                      final allArticles = snapshot.data;

                      return allArticles != null && allArticles.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: allArticles.length,
                                itemExtent: 230,
                                padding: EdgeInsets.only(
                                  bottom: SmoothConfig.screenHeight! * 0.1,
                                ),
                                itemBuilder: (ctx, index) {
                                  final article = allArticles[index];
                                  return SmoothArticleWidget(
                                    article: article,
                                    pos: index,
                                    action: () {
                                      controller.selectArticle(
                                        context,
                                        article,
                                      );
                                    },
                                  );
                                },
                              ),
                            )
                          : buildNoData();
                    })
                : Expanded(
                    child: Container(
                      width: SmoothConfig.screenWidth,
                      height: SmoothConfig.screenHeight,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SmoothText(
                            text: "Vous n'avez pas de favories pour le moment",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: SmoothColors.black.withOpacity(0.5),
                            ),
                          ),
                          SizedBox(
                            height: SmoothConfig.screenWidth! * 0.05,
                          ),
                          Consumer<HomeController>(
                            builder: (context, controller, child) {
                              return controller.currentUser != null
                                  ? Container()
                                  : buildSmoothButton(
                                      title: "Je me connect ou crée mon compte",
                                      action: () {
                                        context.router.push(const Login());
                                      });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
          case 1:
            return Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  buildNewsList(),
                  buildMenuList(),
                ],
              ),
            );
          case 2:
            return controller.currentUser != null
                ? Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SmoothText(
                              text:
                                  "${controller.currentUser!.firstName} ${controller.currentUser!.lastName}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SmoothConfig.screenWidth! * 0.045,
                              ),
                            ),
                            SmoothText(
                              text: controller.currentUser!.pseudo,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: SmoothColors.primary,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SmoothText(text: "Email : ${controller.currentUser!.email}"),
                            ),
                          ],
                        ),
                        buildSmoothButton(title: "Me déconnecter", bgColor: SmoothColors.danger, action: (){
                          controller.logout(context);
                        }),
                      ],
                    ),
                  )
                : const SmoothRedirect();
          default:
            return Container();
        }
      },
    );
  }

  Widget buildNewsList() {
    return Consumer<HomeController>(
      builder: (context, controller, child) {
        return smoothFadeInRight(
          child: Container(
            alignment: Alignment.center,
            width: SmoothConfig.screenWidth,
            height: SmoothConfig.screenHeight! * 0.4,
            child: StreamBuilder<List<SmoothArticle>>(
                stream: ArticlesServices().getAllArticles(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return buildNoData();
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SmoothLoader();
                  }

                  if (snapshot.hasError) {
                    return SmoothError(message: snapshot.error.toString());
                  }

                  final allArticles = snapshot.data;

                  return allArticles!.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const ScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            vertical: SmoothConfig.screenWidth! * 0.05,
                          ),
                          itemCount: allArticles.length,
                          itemBuilder: (ctx, index) {
                            final article = allArticles[index];

                            return SmoothArticleWidget(
                              article: article,
                              pos: index,
                              action: () {
                                controller.selectArticle(context, article);
                              },
                            );
                          },
                        )
                      : buildNoData();
                }),
          ),
        );
      },
    );
  }

  Widget buildNoData() {
    return smoothFadeIn(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SmoothConfig.screenWidth! * 0.05),
            child: SmoothText(
              align: TextAlign.center,
              text:
                  "Aucun articles en favori pour le moment !",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: SmoothColors.black.withOpacity(0.5),
              ),
            ),
          ),
          Consumer<HomeController>(
            builder: (context, controller, child) {
              return controller.currentUser != null
                  ? Container()
                  : buildSmoothButton(
                      title: "Je me connect ou crée un compte",
                      action: () {
                        context.router.push(const Login());
                      });
            },
          ),
        ],
      ),
    );
  }

  Widget buildMenuList() {
    return Consumer<HomeController>(
      builder: (context, controller, child) {
        return FadeInUp(
          duration: const Duration(seconds: 1),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: controller.getMenuItems().length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              final menu = controller.getMenuItems()[index];
              return GestureDetector(
                onTap: () {
                  controller.setSelectedMenu(context: context, menu: menu);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: SmoothConfig.screenWidth! * 0.02,
                      horizontal: SmoothConfig.screenWidth! * 0.04),
                  padding: EdgeInsets.symmetric(
                    horizontal: SmoothConfig.screenWidth! * 0.02,
                    vertical: SmoothConfig.screenWidth! * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: SmoothColors.white,
                    border: Border(
                      bottom: BorderSide(
                          color: SmoothColors.black.withOpacity(0.2),
                          width: 0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      FaIcon(menu.leadingIcon),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SmoothConfig.screenWidth! * 0.02,
                          ),
                          child: SmoothText(text: menu.title),
                        ),
                      ),
                      IconButton(
                        style: IconButton.styleFrom(
                          hoverColor: SmoothColors.transparent,
                          shadowColor: SmoothColors.transparent,
                          highlightColor: SmoothColors.transparent,
                          elevation: 0.0,
                        ),
                        onPressed: () {
                          controller.setSelectedMenu(
                            context: context,
                            menu: menu,
                          );
                        },
                        icon: FaIcon(
                          menu.trailingIcon,
                          size: SmoothConfig.screenWidth! * 0.04,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

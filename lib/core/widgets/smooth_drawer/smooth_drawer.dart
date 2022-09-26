import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rcanews/core/widgets/smooth_drawer/smooth_drawer_controller.dart';

import '../../common/configs.dart';
import '../../common/smooth_colors.dart';
import '../../common/smooth_utils.dart';
import '../smooth_text.dart';

class SmoothDrawer {
  BuildContext? context;

  SmoothDrawer({this.context});

  Drawer buildSmoothDrawer() {
    return Drawer(
      shape: buildRoundedRectangleBorder(),
      child: Consumer<SmoothDrawerController>(
        builder: (context, controller, child) {
          return Stack(
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
              Column(
                children: [
                  DrawerHeader(child: Container()),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.getItems().length,
                      itemBuilder: (ctx, index) {
                        final item = controller.getItems()[index];

                        return ListTile(
                          leading: FaIcon(item.leadingIcon),
                          title: SmoothText(text: item.title),
                          onTap: (){
                            controller.setPageTitle(context, item.title);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  EdgeInsets buildEdgeInsetsCard() {
    return EdgeInsets.symmetric(
      vertical: SmoothConfig.screenWidth! * 0.01,
      horizontal: SmoothConfig.screenWidth! * 0.05,
    );
  }

  EdgeInsets buildEdgeInsets() {
    return EdgeInsets.symmetric(
      vertical: SmoothConfig.screenWidth! * 0.05,
      horizontal: SmoothConfig.screenWidth! * 0.02,
    );
  }

  RoundedRectangleBorder buildRoundedRectangleBorder() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(SmoothConfig.screenWidth! * 0.08),
        bottomRight: Radius.circular(SmoothConfig.screenWidth! * 0.08),
      ),
    );
  }
}

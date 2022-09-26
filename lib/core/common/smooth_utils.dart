import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rcanews/core/common/configs.dart';
import 'package:rcanews/core/controllers/home_controller.dart';
import 'package:rcanews/core/common/smooth_colors.dart';
import 'package:rcanews/core/widgets/smooth_text.dart';

Widget buildPageTitle({required String title}) {
  return smoothFadeIn(
    delay: 300,
    child: Container(
      //color: SmoothColors.secondary,
      width: SmoothConfig.screenWidth,
      padding: EdgeInsets.symmetric(
        horizontal: SmoothConfig.screenHeight! * 0.01,
        vertical: SmoothConfig.screenHeight! * 0.01,
      ),
      child: SmoothText(
        text: title,
        align: TextAlign.center,
        style: TextStyle(
          color: SmoothColors.primary,
          fontWeight: FontWeight.w300,
          fontSize: SmoothConfig.screenWidth! * 0.05,
        ),
      ),
    ),
  );
}

Widget buildSmoothAppBar(
  BuildContext context,
  GlobalKey<ScaffoldState> scaffoldKey, {
  bool? details,
  bool? fromBottom,
}) {
  return FadeInDown(
    duration: const Duration(milliseconds: 800),
    child: Container(
      alignment: Alignment.bottomCenter,
      width: SmoothConfig.screenWidth,
      height: SmoothConfig.screenHeight! *
          (details != null && details ? 0.08 : 0.12),
      //padding: EdgeInsets.only(top: SmoothConfig.screenHeight! * 0.05),
      decoration: BoxDecoration(
        color: SmoothColors.transparent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            onPressed: () {
              if (details != null && details) {
                context.router.pop();
                context.read<HomeController>().dezip
                    ? context.read<HomeController>().toggleDezip()
                    : null;
              } else {
                scaffoldKey.currentState?.openDrawer();
              }
            },
            icon: FaIcon(
              details != null && details
                  ? fromBottom != null && fromBottom
                      ? FontAwesomeIcons.chevronDown
                      : FontAwesomeIcons.chevronLeft
                  : FontAwesomeIcons.bars,
              color: SmoothColors.primary,
              size: SmoothConfig.screenWidth! * 0.045,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SmoothConfig.screenWidth! * 0.03,
              ),
              child: SmoothText(
                text: formatSmoothDate(date: DateTime.now()),
                align: TextAlign.end,
                style: TextStyle(
                  color: SmoothColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildSmoothButton({required String title, Color? bgColor, void Function()? action}) {
  return smoothFadeIn(
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SmoothConfig.screenWidth! * 0.1,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextButton(
              onPressed: action,
              style: TextButton.styleFrom(
                backgroundColor: bgColor ?? SmoothColors.primary,
                foregroundColor: SmoothColors.white,
                padding: EdgeInsets.symmetric(
                  vertical: SmoothConfig.screenWidth! * 0.04,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    SmoothConfig.screenWidth!,
                  ),
                ),
              ),
              child: SmoothText(
                text: title,
                style: TextStyle(color: SmoothColors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

String formatSmoothDate({required DateTime date}) {
  return DateFormat.yMMMEd("fr_FR").format(date);
}

Widget smoothFadeIn({required Widget child, int? delay}) {
  return FadeIn(
    duration: const Duration(milliseconds: 800),
    delay: const Duration(milliseconds: 200),
    child: child,
  );
}

Widget smoothFadeInRight({required Widget child, int? delay}) {
  return FadeInRight(
    duration: const Duration(milliseconds: 800),
    delay: const Duration(milliseconds: 200),
    child: child,
  );
}

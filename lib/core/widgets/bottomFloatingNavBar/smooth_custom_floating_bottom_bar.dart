import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rcanews/core/common/configs.dart';
import 'package:rcanews/core/common/smooth_colors.dart';
import 'package:rcanews/core/widgets/bottomFloatingNavBar/smooth_custom_floating_bottom_nav_controller.dart';
import 'package:rcanews/core/widgets/smooth_custom_button_icon.dart';

class SmoothCustomFloatingBottomNavBar extends StatelessWidget {
  const SmoothCustomFloatingBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildSmoothCustomBottomBar();
  }

  Widget buildSmoothCustomBottomBar() {
    return Consumer<SmoothBottomCustomFloatingNavController>(
      builder: (context, controller, child) {
        return FadeInUp(
          duration: const Duration(milliseconds: 800),
          child: Container(
            width: SmoothConfig.screenWidth,
            height: 60.0,
            margin: buildEdgeInsets(),
            decoration: buildBoxDecoration(),
            child: ListView.builder(
              itemExtent: SmoothConfig.screenWidth! * 0.31,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.getItems(context: context).length,
              itemBuilder: (ctx, index) {
                final item = controller.getItems(context: context)[index];
                return item;
              },
            ),
          ),
        );
      },
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      color: SmoothColors.white,
      borderRadius: BorderRadius.circular(SmoothConfig.screenWidth!),
      boxShadow: [
        BoxShadow(
          color: SmoothColors.black.withOpacity(0.1),
          spreadRadius: 0.0,
          blurRadius: 10.0,
        ),
      ],
    );
  }

  EdgeInsets buildEdgeInsets() {
    return EdgeInsets.symmetric(
      vertical: SmoothConfig.screenWidth! * 0.04,
      horizontal: SmoothConfig.screenWidth! * 0.034,
    );
  }
}

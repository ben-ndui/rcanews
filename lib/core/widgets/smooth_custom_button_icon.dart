import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rcanews/core/common/configs.dart';
import 'package:rcanews/core/common/smooth_colors.dart';

class SmoothCustomButtonIcon extends StatelessWidget {
  final IconData icon;
  final Color? bgColor;
  final void Function()? action;
  final bool? left;

  const SmoothCustomButtonIcon({Key? key, required this.icon, this.bgColor, this.action, this.left}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildSmoothCustomButton();
  }

  Widget buildSmoothCustomButton() {
    return GestureDetector(
      onTap: action,
      child: FadeIn(
        duration: const Duration(milliseconds: 800),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bgColor ?? SmoothColors.white,
            borderRadius: BorderRadius.only(
              topLeft: left != null && left!
                  ? Radius.circular(SmoothConfig.screenWidth! * 0.08)
                  : Radius.zero,
              bottomLeft: left != null && left!
                  ? Radius.circular(SmoothConfig.screenWidth! * 0.08)
                  : Radius.zero,
              topRight: left != null && !left!
                  ? Radius.circular(SmoothConfig.screenWidth! * 0.08)
                  : Radius.zero,
              bottomRight: left != null && !left!
                  ? Radius.circular(SmoothConfig.screenWidth! * 0.08)
                  : Radius.zero,
            ),
          ),
          child: FadeIn(
            duration: const Duration(seconds: 1),
            child: FaIcon(
              icon,
              color: bgColor != null ? SmoothColors.white : SmoothColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

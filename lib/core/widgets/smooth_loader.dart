import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rcanews/core/common/smooth_utils.dart';

import '../common/configs.dart';

class SmoothLoader extends StatelessWidget {
  const SmoothLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildSmoothLoader();
  }

  Widget buildSmoothLoader() {
    return smoothFadeIn(
      child: Container(
        alignment: Alignment.center,
        width: SmoothConfig.screenWidth,
        child: Lottie.asset(
          "assets/json/loading_files.json",
          width: SmoothConfig.screenWidth! * 0.5,
        ),
      ),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rcanews/core/common/configs.dart';
import 'package:rcanews/core/controllers/splash_controller.dart';
import 'package:rcanews/core/common/smooth_colors.dart';
import 'package:rcanews/core/common/smooth_utils.dart';
import 'package:rcanews/core/widgets/smooth_text.dart';
import 'package:rcanews/router/router.gr.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    SmoothConfig().init(context);
    SmoothConfig().initThemesSize();

    return Consumer<SplashController>(
      builder: (context, controller, child) {
        return Scaffold(
          body: buildBody(context: context, controller: controller),
        );
      },
    );
  }

  Widget buildBody({
    required BuildContext context,
    required SplashController controller,
  }) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      onPageChanged: controller.setSelected,
      itemCount: controller.getPages().length,
      itemBuilder: (ctx, pageIndex) {
        final page = controller.getPages()[pageIndex];
        return smoothFadeIn(
          child: Container(
            width: SmoothConfig.screenWidth,
            height: SmoothConfig.screenHeight,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        smoothFadeIn(
                          child: Container(
                            child: Lottie.asset(
                              page.imgUrl,
                              width: SmoothConfig.screenWidth,
                              //height: SmoothConfig.screenHeight! * 0.3,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SmoothConfig.screenHeight! * 0.05,
                        ),
                        smoothFadeIn(
                          child: SmoothText(
                            text: page.description,
                            style: TextStyle(
                              color: SmoothColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: SmoothConfig.screenWidth! * 0.045,
                            ),
                          ),
                        ),
                        smoothFadeIn(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: SmoothConfig.screenWidth! * 0.07),
                            child: SmoothText(
                              text: page.subTitle,
                              align: TextAlign.center,
                              style: TextStyle(
                                color: SmoothColors.primary,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.italic,
                                fontSize: SmoothConfig.screenWidth! * 0.045,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                page.isLast != null && page.isLast!
                    ? smoothFadeIn(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: SmoothConfig.screenWidth! * 0.05,
                            horizontal: SmoothConfig.screenWidth! * 0.05,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FadeInRight(
                                duration: const Duration(milliseconds: 800),
                                child: IconButton(
                                  onPressed: () {
                                    context.router.push(const Home());
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.arrowRight,
                                    color: SmoothColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                page.isLast == null
                    ? smoothFadeIn(
                        child: Container(
                          height: 16.5,
                          margin: EdgeInsets.symmetric(
                            vertical: SmoothConfig.screenWidth! * 0.07,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (ctx, index) {
                              return controller.buildDots(index);
                            },
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}

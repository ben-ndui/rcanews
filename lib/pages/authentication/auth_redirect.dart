import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rcanews/core/common/configs.dart';
import 'package:rcanews/core/models/smooth_user_model.dart';
import 'package:rcanews/core/common/smooth_utils.dart';
import 'package:rcanews/core/widgets/smooth_text.dart';
import 'package:rcanews/router/router.gr.dart';

import '../../core/common/smooth_colors.dart';

class SmoothRedirect extends StatelessWidget {
  const SmoothRedirect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  StreamBuilder<SmoothUserModel> buildBody() {
    return StreamBuilder<SmoothUserModel>(
      stream: null,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return NoData(context);
        } else if (snapshot.data != null) {
          return Container();
        } else {
          context.router.push(const Login());
          return Expanded(
            child: Container(
              width: SmoothConfig.screenWidth,
              height: SmoothConfig.screenHeight,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmoothText(
                    text: "Vous n'êtes pas connectés, connectez-vous pour avoir accès à toutes les fonctionnalité de RCA News !",
                    style: TextStyle(fontStyle: FontStyle.italic, color: SmoothColors.black.withOpacity(0.5)),
                  ),
                  SizedBox(height: SmoothConfig.screenWidth! * 0.05,),
                  buildSmoothButton(title: "Je me connecte", action: (){
                    context.router.push(const Login());
                  })
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget NoData(BuildContext context) {
    return Expanded(
      child: Container(
        width: SmoothConfig.screenWidth,
        height: SmoothConfig.screenHeight,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SmoothConfig.screenWidth! * 0.085),
              child: SmoothText(
                align: TextAlign.center,
                text: "Vous n'êtes pas connectés, connectez-vous pour avoir accès à toutes les fonctionnalité de RCA News !",
                style: TextStyle(fontStyle: FontStyle.italic, color: SmoothColors.black.withOpacity(0.5)),
              ),
            ),
            SizedBox(height: SmoothConfig.screenWidth! * 0.05,),
            buildSmoothButton(title: "Je me connecte", action: (){
              context.router.push(const Login());
            })
          ],
        ),
      ),
    );
  }
}

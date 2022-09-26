import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:rcanews/core/common/configs.dart';
import 'package:rcanews/core/models/smooth_page_model.dart';
import 'package:rcanews/core/common/smooth_colors.dart';

class SplashController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> getScaffoldKey() => _scaffoldKey;

  int selected = 0;

  List<SmoothPageModel> getPages() {
    return [
      SmoothPageModel(
        title: "Page 1",
        subTitle: "Connectes-toi à tes racines !",
        description: "RCA News,",
        imgUrl: 'assets/json/world2.json',
      ),
      SmoothPageModel(
        title: "Page 2",
        subTitle: "Dépasse tes limites, outre passe les frontières !",
        description: "",
        imgUrl: 'assets/json/world.json',
      ),
      SmoothPageModel(
        title: "Page 3",
        subTitle: "Découvres, Échange, Partages",
        description: "",
        imgUrl: 'assets/json/discover.json',
        isLast: true,
      ),
    ];
  }

  void setSelected(int value) {
    selected = value;
    notifyListeners();
  }

  Widget buildDots(int index) {
    return FadeIn(
      child: Container(
        width: 10.0,
        height: 10.0,
        margin: const EdgeInsets.all(3.0),
        padding: const EdgeInsets.all(3.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: SmoothColors.transparent,
          borderRadius: BorderRadius.circular(SmoothConfig.screenWidth!),
          border: Border.all(color: SmoothColors.primary, width: 0.5),
        ),
        child: selected == index
            ? FadeIn(
                duration: const Duration(milliseconds: 800),
                child: Container(
                  width: 5.0,
                  height: 5.0,
                  decoration: BoxDecoration(
                    color: SmoothColors.primary,
                    borderRadius:
                        BorderRadius.circular(SmoothConfig.screenWidth!),
                  ),
                ),
              )
            : Container(),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    selected = 0;
    super.dispose();
  }
}

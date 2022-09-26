import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rcanews/core/controllers/home_controller.dart';
import 'package:rcanews/core/common/smooth_colors.dart';
import 'package:rcanews/core/widgets/smooth_custom_button_icon.dart';

class SmoothBottomCustomFloatingNavController extends ChangeNotifier {
  int selected = 1;

  void setSelected(int newValue) {
    selected = newValue;
    //print(selected);
    notifyListeners();
  }

  List<Widget> getItems({required BuildContext context}) {
    final homeController = context.read<HomeController>();
    return [
      SmoothCustomButtonIcon(
        icon: FontAwesomeIcons.solidHeart,
        left: true,
        bgColor: selected == 0 ? SmoothColors.primary : null,
        action: () {
          setSelected(0);
          homeController.setTitle("Mes favories");
        },
      ),
      SmoothCustomButtonIcon(
        icon: FontAwesomeIcons.home,
        bgColor: selected == 1 ? SmoothColors.primary : null,
        action: () {
          setSelected(1);
          homeController.setTitle("Actualités");
        },
      ),
      SmoothCustomButtonIcon(
        icon: FontAwesomeIcons.solidUser,
        left: false,
        bgColor: selected == 2 ? SmoothColors.primary : null,
        action: () {
          setSelected(2);
          homeController.setTitle("Mon compte");
        },
      ),
    ];
  }

  void setHomeTitle({required BuildContext ctx}) {
    final homeController = ctx.read<HomeController>();
    switch (selected) {
      case 0:
        homeController.setTitle("Mes favories");
        break;
      case 1:
        homeController.setTitle("RCA News");
        break;
      case 2:
        homeController.setTitle("Mon compte");
        break;
      default:
        homeController.setTitle("RCA News");
        break;
    }
  }
}

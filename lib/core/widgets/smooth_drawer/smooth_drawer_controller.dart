import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rcanews/router/router.gr.dart';

import '../../models/smooth_item_model.dart';

class SmoothDrawerController extends ChangeNotifier{
  String pageTitle = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> getScaffoldKey() => _scaffoldKey;

  void setPageTitle(BuildContext context, String title){
    pageTitle = title;
    notifyListeners();
    context.router.push(const DrawerScreen());
  }

  List<SmoothItemModel> getItems() {
    return [
      SmoothItemModel(title: "Propos", subTitle: "", leadingIcon: FontAwesomeIcons.a, trailingIcon: FontAwesomeIcons.arrowRight),
      SmoothItemModel(title: "Nous contacter", subTitle: "", leadingIcon: FontAwesomeIcons.addressBook, trailingIcon: FontAwesomeIcons.arrowRight),
      SmoothItemModel(title: "CGU / CGV", subTitle: "", leadingIcon: FontAwesomeIcons.book, trailingIcon: FontAwesomeIcons.arrowRight),
      SmoothItemModel(title: "Premium", subTitle: "", leadingIcon: FontAwesomeIcons.bank, trailingIcon: FontAwesomeIcons.arrowRight),
    ];
  }

}
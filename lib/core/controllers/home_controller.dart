import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rcanews/core/models/smooth_article.dart';
import 'package:rcanews/core/models/smooth_item_model.dart';
import 'package:rcanews/core/models/smooth_user_model.dart';
import 'package:rcanews/core/services/articles_services.dart';
import 'package:rcanews/core/common/smooth_enums.dart';
import 'package:rcanews/router/router.gr.dart';

import '../services/authentication_services.dart';

class HomeController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  SmoothArticle? articleSelected;

  SmoothType viewType = SmoothType.article;

  SmoothItemModel? menuType;

  String homeTitle = "Actualités";

  List<SmoothArticle> favorites = [];

  SmoothUserModel? currentUser;

  GlobalKey<ScaffoldState> getScaffoldKey() => _scaffoldKey;

  bool dezip = false;

  void toggleDezip() {
    dezip = !dezip;
    notifyListeners();
  }

  /*List<SmoothArticle> getAllArticles() {
    return [
      SmoothArticle(
        uid: "",
        title: "Que se passe t-il dans la tête de Poutine, décryptage !",
        subTitle: "subTitle",
        description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Where does it come from? Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.",
        publishedOn: DateTime.now(),
        closedOn: DateTime.now(),
        type: "",
      ),
      SmoothArticle(
        uid: "",
        title: "Selon Jean-Luc Reichman, on vit dans le deni !",
        subTitle: "subTitle",
        description: "description",
        publishedOn: DateTime.now(),
        closedOn: DateTime.now(),
        type: "",
      ),
      SmoothArticle(
        uid: "",
        title: "Qui est donc Lulu, la terreur des pistes de danse ?",
        subTitle: "subTitle",
        description: "description",
        publishedOn: DateTime.now(),
        closedOn: DateTime.now(),
        type: "",
      ),
      SmoothArticle(
        uid: "",
        title: "République Centrafricaine, le nouvel eldorado européen ! ",
        subTitle: "subTitle",
        description: "description",
        publishedOn: DateTime.now(),
        closedOn: DateTime.now(),
        type: "",
      ),
      SmoothArticle(
        uid: "",
        title: "GTA 6, des pirates de plus en plus jeune, que faire ?",
        subTitle: "subTitle",
        description: "description",
        publishedOn: DateTime.now(),
        closedOn: DateTime.now(),
        type: "",
      ),
    ];
  }*/

  void selectArticle(BuildContext context, SmoothArticle article) {
    articleSelected = article;
    viewType = SmoothType.article;
    notifyListeners();
    context.router.push(const HomeDetail());
  }

  List<SmoothItemModel> getMenuItems() {
    return [
      SmoothItemModel(
          title: "Art",
          subTitle: "Art",
          leadingIcon: FontAwesomeIcons.artstation,
          trailingIcon: FontAwesomeIcons.chevronRight),
      SmoothItemModel(
          title: "Musique",
          subTitle: "Musique",
          leadingIcon: FontAwesomeIcons.music,
          trailingIcon: FontAwesomeIcons.chevronRight),
      SmoothItemModel(
          title: "Actualités",
          subTitle: "Art",
          leadingIcon: FontAwesomeIcons.newspaper,
          trailingIcon: FontAwesomeIcons.chevronRight),
    ];
  }

  void setSelectedMenu(
      {required BuildContext context, required SmoothItemModel menu}) {
    viewType = SmoothType.listDetail;
    menuType = menu;
    notifyListeners();
    context.router.push(const HomeDetail());
  }

  void setTitle(String s) {
    homeTitle = s;
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    articleSelected = null;
    dezip = false;
    menuType = null;
    viewType = SmoothType.article;
    super.dispose();
  }

  void initCurrentUser(SmoothUserModel value) {
    currentUser = value;
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    //print("ici");
    await AuthenticationService().logout(context).whenComplete((){
      currentUser = null;
      notifyListeners();
    });
  }
}

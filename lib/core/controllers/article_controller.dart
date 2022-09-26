import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rcanews/core/models/smooth_article.dart';
import 'package:rcanews/core/services/articles_services.dart';
import 'package:rcanews/core/common/smooth_enums.dart';
import 'package:rcanews/router/router.gr.dart';

class ArticleController extends ChangeNotifier {
  SmoothArticle? selectedArticle;
  SmoothType formType = SmoothType.add;

  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  String title = "";
  String subTitle = "";
  String description = "";
  String type = "";

  DateTime publishedOn = DateTime.now();
  DateTime closedOn = DateTime.now();

  void setFormType(SmoothType fType) {
    formType = fType;
    notifyListeners();
  }

  void setValue(String whichOne, val) {
    switch (whichOne) {
      case "title":
        title = val;
        break;
      case "sub":
        subTitle = val;
        break;
      case "desc":
        description = val;
        break;
      case "type":
        type = val;
        break;
      case "published":
        publishedOn = val;
        break;
      case "close":
        closedOn = val;
        break;
    }
    notifyListeners();
  }

  void submit(BuildContext context) {
    switch (formType) {
      case SmoothType.add:
        final uid = ArticlesServices().getNewId();
        final article = SmoothArticle(
          uid: uid,
          title: title,
          subTitle: subTitle,
          description: description,
          publishedOn: DateTime.now(),
          closedOn: closedOn,
          type: type,
        );
        ArticlesServices().saveArticle(article);
        break;
      case SmoothType.edit:
        if(selectedArticle != null){
          final article = SmoothArticle(
            uid: selectedArticle!.uid,
            title: title,
            subTitle: subTitle,
            description: description,
            publishedOn: DateTime.now(),
            closedOn: closedOn,
            type: type,
          );
          ArticlesServices().updateArticles(article);
        }
        break;
      default:
        break;
    }
    context.router.replace(const Home());
  }
}


import '../common/smooth_enums.dart';

class SmoothArticle {
  String uid;
  String title;
  String subTitle;
  String description;
  DateTime publishedOn;
  DateTime closedOn;
  bool? favorite;
  String type;

  SmoothArticle({
    required this.uid,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.publishedOn,
    required this.closedOn,
    this.favorite = false,
    required this.type,
  });

  void setFavorite(bool fav){
    favorite = fav;
  }

  factory SmoothArticle.fromJson(map) {
    return SmoothArticle(
      uid: map['uid'],
      title: map['title'],
      subTitle: map['subTitle'],
      description: map['description'],
      publishedOn: DateTime.parse(map['publishedOn']),
      closedOn: DateTime.parse(map['closedOn']),
      favorite: map['favorite'] ?? false,
      type: map['type'] ?? "Actu",
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'uid': uid,
      'title': title,
      'subTitle': subTitle,
      'description': description,
      'publishedOn': publishedOn,
      'closedOn': closedOn,
      'favorite': favorite,
      'type': type,
    };
  }
}

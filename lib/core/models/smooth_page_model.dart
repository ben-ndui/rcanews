class SmoothPageModel {
  final String title;
  final String subTitle;
  final String description;
  final String imgUrl;
  final bool? isLast;

  SmoothPageModel({
    required this.title,
    required this.subTitle,
    required this.description,
    required this.imgUrl,
    this.isLast,
  });
}

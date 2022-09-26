import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rcanews/core/common/configs.dart';
import 'package:rcanews/core/models/smooth_article.dart';
import 'package:rcanews/core/common/smooth_colors.dart';
import 'package:rcanews/core/common/smooth_utils.dart';
import 'package:rcanews/core/widgets/smooth_text.dart';

class SmoothArticleWidget extends StatelessWidget {
  final SmoothArticle article;
  final int pos;
  final void Function()? action;

  const SmoothArticleWidget({Key? key, required this.article, required this.pos, this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildSmoothCard();
  }

  Widget buildSmoothCard() {
    return smoothFadeIn(
      delay: 300 * pos,
      child: GestureDetector(
        onTap: action,
        child: Container(
          width: SmoothConfig.screenWidth! * 0.6,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(
            horizontal: SmoothConfig.screenWidth! * 0.03,
            vertical: SmoothConfig.screenWidth! * 0.03,
          ),
          decoration: BoxDecoration(
            color: SmoothColors.white,
            borderRadius: BorderRadius.circular(
              SmoothConfig.screenWidth! * 0.045,
            ),
            boxShadow: [
              BoxShadow(
                color: SmoothColors.secondary.withOpacity(0.2),
                spreadRadius: 0.0,
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: SmoothConfig.screenWidth,
                height: SmoothConfig.screenHeight,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    SmoothConfig.screenWidth! * 0.2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    SmoothConfig.screenWidth! * 0.05,
                  ),
                  child: Image.asset(
                    "assets/images/image_test.jpeg",
                    width: SmoothConfig.screenWidth,
                    height: SmoothConfig.screenHeight,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          //TODO: like this article
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.solidHeart,
                          color: article.favorite != null && article.favorite!
                              ? SmoothColors.danger
                              : SmoothColors.white,
                        ),
                      )
                    ],
                  ),
                  Expanded(child: Container()),
                  Container(
                    width: SmoothConfig.screenWidth,
                    height: SmoothConfig.screenHeight! * 0.15,
                    margin: EdgeInsets.symmetric(
                      horizontal: SmoothConfig.screenWidth! * 0.02,
                      vertical: SmoothConfig.screenWidth! * 0.02,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: SmoothConfig.screenWidth! * 0.02,
                      vertical: SmoothConfig.screenWidth! * 0.02,
                    ),
                    decoration: BoxDecoration(
                      color: SmoothColors.white,
                      borderRadius: BorderRadius.circular(
                        SmoothConfig.screenWidth! * 0.055,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: SmoothColors.black.withOpacity(0.5),
                          spreadRadius: 0.0,
                          blurRadius: 10.0,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SmoothText(
                            text: article.title,
                            align: TextAlign.start,
                            style: TextStyle(
                              color: SmoothColors.primary,
                              fontSize: SmoothConfig.screenWidth! * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SmoothText(
                              text: formatSmoothDate(date: article.publishedOn),
                              align: TextAlign.start,
                              style: TextStyle(
                                color: SmoothColors.primary,
                                fontSize: SmoothConfig.screenWidth! * 0.03,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

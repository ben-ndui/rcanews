import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rcanews/core/common/configs.dart';
import 'package:rcanews/core/controllers/article_controller.dart';
import 'package:rcanews/core/common/smooth_colors.dart';
import 'package:rcanews/core/common/smooth_utils.dart';
import 'package:rcanews/core/widgets/smooth_text.dart';

class CreateArticle extends StatelessWidget {
  const CreateArticle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: SmoothConfig.screenWidth,
              height: SmoothConfig.screenHeight,
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/back3.jpg",
                fit: BoxFit.cover,
                width: SmoothConfig.screenWidth,
                height: SmoothConfig.screenHeight,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildPageTitle(title: "Ajouter un article"),
                buildBody(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    return Consumer<ArticleController>(
      builder: (context, controller, child) {
        return ListView(
          shrinkWrap: true,
          children: [
            Container(
              width: SmoothConfig.screenWidth,
              height: SmoothConfig.screenHeight! * 0.08,
              margin: EdgeInsets.symmetric(
                horizontal: SmoothConfig.screenWidth! * 0.1,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: SmoothColors.white,
                borderRadius:
                    BorderRadius.circular(SmoothConfig.screenWidth! * 0.02),
                boxShadow: [
                  BoxShadow(
                      color: SmoothColors.black.withOpacity(0.06),
                      blurRadius: 10.0,
                      spreadRadius: 0.0),
                ],
              ),
              child: FaIcon(
                FontAwesomeIcons.newspaper,
                size: SmoothConfig.screenWidth! * 0.1,
                color: SmoothColors.secondary,
              ),
            ),
            Form(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildSmoothTextFormField(
                    controller: controller.titleController,
                    label: 'Titre',
                    hint: 'titre',
                    onChange: (val) => controller.setValue("title", val),
                  ),
                  buildSmoothTextFormField(
                    controller: controller.subTitleController,
                    label: 'Sous titre',
                    hint: 'sous titre',
                    onChange: (val) => controller.setValue("sub", val),
                  ),
                  buildSmoothTextFormField(
                    controller: controller.titleController,
                    label: 'Type',
                    hint: 'type: musique, art',
                    onChange: (val) => controller.setValue("type", val),
                  ),
                  buildSmoothTextFormField(
                    controller: controller.titleController,
                    label: 'Description',
                    hint: 'description',
                    maxLine: 6,
                    onChange: (val) => controller.setValue("desc", val),
                  ),
                ],
              ),
            ),
            buildSpacer(),
            buildSmoothButton(
                title: "Ajouter", action: () => controller.submit(context)),
            buildSpacer(),
            TextButton(
                onPressed: () {
                  context.router.pop();
                },
                child: const SmoothText(
                  text: "Annuler",
                  style: TextStyle(),
                ))
          ],
        );
      },
    );
  }

  SizedBox buildSpacer() => SizedBox(
        height: SmoothConfig.screenHeight! * 0.05,
      );

  Widget buildSmoothTextFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required void Function(String)? onChange,
    int? maxLine,
  }) {
    return smoothFadeIn(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SmoothConfig.screenWidth! * 0.04,
          horizontal: SmoothConfig.screenWidth! * 0.1,
        ),
        child: TextFormField(
          controller: controller,
          maxLines: maxLine ?? 1,
          onChanged: onChange,
          onFieldSubmitted: onChange,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: SmoothColors.primary),
            ),
          ),
        ),
      ),
    );
  }
}

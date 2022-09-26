import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rcanews/core/common/configs.dart';

class SmoothText extends StatelessWidget {
  final String text;
  final double? ratio;
  final TextAlign? align;
  final TextStyle? style;

  const SmoothText({
    Key? key,
    required this.text,
    this.ratio,
    this.align,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: style ?? TextStyle(
        fontSize: SmoothConfig.screenWidth! * (ratio ?? 0.045),
      ),
      textAlign: align,
    );
  }
}

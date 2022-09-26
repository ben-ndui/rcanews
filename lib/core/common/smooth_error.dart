import 'package:flutter/material.dart';
import 'package:rcanews/core/common/configs.dart';
import 'package:rcanews/core/common/smooth_colors.dart';
import 'package:rcanews/core/widgets/smooth_text.dart';

class SmoothError extends StatefulWidget {
  final String message;

  const SmoothError({Key? key, required this.message}) : super(key: key);

  @override
  State<SmoothError> createState() => _SmoothErrorState();
}

class _SmoothErrorState extends State<SmoothError> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: SmoothConfig.screenWidth,
      height: SmoothConfig.screenHeight,
      decoration: BoxDecoration(color: SmoothColors.danger),
      child: SmoothText(
        text: widget.message,
        style: TextStyle(color: SmoothColors.white),
      ),
    );
  }
}

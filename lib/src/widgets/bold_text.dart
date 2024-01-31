import 'package:flutter/cupertino.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';


class BoldText extends StatelessWidget {
  Color color;
  final String text;
  double size;
  int maxLines;
  TextOverflow textOverflow;
  final TextStyle? style;
  BoldText(
      {super.key,
      this.color = AppColors.white,
      required this.text,
      this.style,
      this.size = 2.8,
      this.maxLines = 1,
      this.textOverflow = TextOverflow.ellipsis});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: textOverflow,
      style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.fontFamily,
              fontSize: responsivefonts(size, context))
          .merge(style),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';


class MediumText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  int maxLines;
  TextOverflow textOverflow;
  final TextStyle? style;
  MediumText(
      {super.key,
      this.color = AppColors.white,
      required this.text,
      this.size = 2,
      this.style,
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
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.fontFamily,
              fontSize: responsivefonts(size, context))
          .merge(style),
    );
  }
}
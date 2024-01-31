import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';


class LightText extends StatelessWidget {
  Color color;
  final String text;
  double size;
  int? maxline;
  LightText(
      {super.key,
      this.color = AppColors.white,
      required this.text,
      this.size = 1.5,
      this.maxline});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxline != null ? maxline : null,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontFamily: AppFonts.fontFamily,
        fontSize: responsivefonts(size, context),
      ),
    );
  }
}

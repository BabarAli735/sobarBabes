import 'package:flutter/material.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
import 'package:sobarbabe/src/widgets/medium_text.dart';


class CustomOutLineButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final Color iconColor;
  final ButtonStyle? style;
  final bool isImage;
  final IconData? icon;
  const CustomOutLineButton({
    required this.text,
    required this.onPressed,
    this.style,
    this.isImage = false,
    this.icon,
    this.textColor = AppColors.white,
    this.iconColor = AppColors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightPercentageToDP(7, context),
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(
                color: AppColors.white, width: 1), // Set the border color here
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Set the BorderRadius
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isImage
                ? Image(image: AssetImage(AppImages.background))
                : Icon(
                    icon,
                    color: iconColor,
                    size: responsivefonts(5, context),
                  ),
            Container(
                margin: EdgeInsets.only(left: widthPercentageToDP(20, context)),
                child: MediumText(text: text, style: TextStyle()))
          ],
        ),
      ),
    );
  }
}

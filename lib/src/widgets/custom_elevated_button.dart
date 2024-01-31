import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
import 'package:sobarbabe/src/widgets/medium_text.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;
  final ButtonStyle? buttonStyle;
  final double height;
  final double? width;

  CustomElevatedButton(
      {required this.text,
      required this.onPressed,
      this.buttonColor = AppColors.secondary,
      this.textColor = AppColors.white,
      this.height = 7,
      this.width = 0,
      this.buttonStyle});

  @override
  Widget build(BuildContext context) {
 
    return SizedBox(
      height: heightPercentageToDP(height, context),
      width: width! > 0 ? widthPercentageToDP(width!, context) : null,
      child: ElevatedButton(
        onPressed:  onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              // Set the BorderRadius
            ),
          ),
        ).merge(buttonStyle),
        child: Center(
          // child: authProvider.loading
          //     ? Container(
          //         height: widthPercentageToDP(5, context),
          //         width: widthPercentageToDP(5, context),
          //         child: const CircularProgressIndicator(
          //           color: AppColors.white,
          //           strokeWidth: 2,
          //         ),
          //       )
          //     : MediumText(
          //         text: text,
          //         color: textColor,
          //       ),
          child: MediumText(
                  text: text,
                  color: textColor,
                )
        ),
      ),
    );
  }
}

class CustomElevatedButtonWithIcon extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;
  final ButtonStyle? buttonStyle;
  final double height;
  final double? width;

  const CustomElevatedButtonWithIcon(
      {super.key,
      required this.text,
      required this.onPressed,
      this.buttonColor = AppColors.red,
      this.textColor = AppColors.white,
      this.height = 7,
      this.width = 0,
      this.buttonStyle});

  @override
  Widget build(BuildContext context) {
   

    return SizedBox(
      height: heightPercentageToDP(height, context),
      width: width! > 0 ? widthPercentageToDP(width!, context) : null,
      child: ElevatedButton(
        onPressed:  onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              // Set the BorderRadius
            ),
          ),
        ).merge(buttonStyle),
        child: Center(
          child: Container(
                  height: widthPercentageToDP(5, context),
                  width: widthPercentageToDP(5, context),
                  child: const CircularProgressIndicator(
                    color: AppColors.white,
                    strokeWidth: 2,
                  ),
                )
              
        ),
      ),
    );
  }
}

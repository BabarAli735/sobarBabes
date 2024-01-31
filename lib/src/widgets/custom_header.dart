import 'package:flutter/material.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
import 'package:sobarbabe/src/widgets/bold_text.dart';


class CustomHeader extends StatefulWidget {
  const CustomHeader({super.key});

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: widthPercentageToDP(3, context)),
      margin: EdgeInsets.only(top: heightPercentageToDP(2, context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BoldText(text: 'My Sites'),
          CircleAvatar(
            backgroundImage: const AssetImage(AppImages. background),
            radius: widthPercentageToDP(8, context),
          )
        ],
      ),
    );
  }
}

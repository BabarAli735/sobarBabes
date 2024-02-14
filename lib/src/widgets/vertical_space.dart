import 'package:flutter/material.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';

class VerticalSpace extends StatelessWidget {
  final double? height;
  const   VerticalSpace({super.key, this.height = 1});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightPercentageToDP(height!, context),
    );
  }
}
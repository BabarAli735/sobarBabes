import 'package:flutter/widgets.dart';
import 'dart:math' as math; // Import the math library

// Function to get screen width and height
double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

// Helper function to convert width percentage to pixels
double widthPercentageToDP(double widthPercent, BuildContext context) {
  return (getScreenWidth(context) * widthPercent / 100).roundToDouble();
}

// Helper function to convert height percentage to pixels
double heightPercentageToDP(double heightPercent, BuildContext context) {
  return (getScreenHeight(context) * heightPercent / 100).roundToDouble();
}

// Helper functions for responsive scaling
double scale(double size, BuildContext context) {
  return (getScreenWidth(context) / 350) * size;
}

double verticalScale(double size, BuildContext context) {
  return (getScreenHeight(context) / 680) * size;
}

double moderateScale(double size, double factor, BuildContext context) {
  return size + (scale(size, context) - size) * factor;
}

double responsivefonts(double fontSize, BuildContext context) {
  final tempHeight = (16 / 9) * getScreenWidth(context);
  return math.sqrt(
          math.pow(tempHeight, 2) + math.pow(getScreenWidth(context), 2)) *
      (fontSize / 100);
}
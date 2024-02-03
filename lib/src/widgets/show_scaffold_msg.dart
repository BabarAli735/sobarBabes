
import 'package:flutter/material.dart';
import 'package:sobarbabe/src/constants/them.dart';

void showScaffoldMessage({
  BuildContext? context, // removed
  required String message,
  Color? bgcolor,
  Duration? duration,
}) {
  SnackBar(
    content: Text(message, style: const TextStyle(fontSize: 18)),
    duration: duration ?? const Duration(seconds: 5),
    backgroundColor: bgcolor ?? APP_PRIMARY_COLOR,
  );
}

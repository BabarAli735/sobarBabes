import 'package:flutter/material.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
import 'package:sobarbabe/src/widgets/medium_text.dart';


class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool showIcon;
  final bool prefixIcon;
  final bool obsecure;
  final bool enabled;
  final FocusNode? focusNode;
  CustomTextField({
    required this.hintText,
    this.controller,
    this.showIcon = false,
    this.enabled = true,
    this.prefixIcon = false,
    this.obsecure = false,
    this.focusNode,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightPercentageToDP(7, context),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obsecure,
        enabled: enabled,
        focusNode: focusNode,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.white),
          hintText: hintText,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white)),
          focusColor: Colors.white,
          fillColor: Colors.white,
          suffixIcon: showIcon
              ? IconButton(
                  icon: const Icon(Icons.remove_red_eye),
                  color: Colors.white,
                  onPressed: () {},
                )
              : null,
          prefixIcon: prefixIcon
              ? Container(
                  margin: EdgeInsets.only(
                      bottom: heightPercentageToDP(0.1, context)),
                  width: widthPercentageToDP(5, context),
                  alignment: Alignment.center,
                  child: MediumText(text: '+44'),
                )
              : null,
        ),
      ),
    );
  }
}

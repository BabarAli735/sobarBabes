import 'package:flutter/material.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
import 'package:sobarbabe/src/widgets/medium_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  const CustomAppBar({super.key, required this.title });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: MediumText(text: title,size: responsivefonts(0.35, context),),
         centerTitle: false,
          iconTheme: const IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.black,
      );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}
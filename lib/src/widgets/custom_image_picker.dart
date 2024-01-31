import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
import 'package:sobarbabe/src/widgets/bold_text.dart';

class CustomImagePicker extends StatelessWidget {
  const CustomImagePicker({super.key});

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: BoldText(
        text: 'Choose your action',
        color: AppColors.black,
      ),
      actions: <Widget>[
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(widthPercentageToDP(2, context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () => {
                        
                      },
                      child: Icon(
                        Icons.camera_alt,
                        color: AppColors.secondary,
                        size: responsivefonts(5, context),
                      ),
                    ),
                    InkWell(
                      onTap: () => {
                       
                      },
                      child: Icon(
                        Icons.perm_media,
                        color: AppColors.secondary,
                        size: responsivefonts(5, context),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

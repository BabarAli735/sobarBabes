import 'package:flutter/material.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
import 'package:sobarbabe/src/routes/routes_names.dart';
import 'package:sobarbabe/src/widgets/bold_text.dart';
import 'package:sobarbabe/src/widgets/index.dart';


class DocumentCard extends StatelessWidget {
  const DocumentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      highlightColor: AppColors.brownGrey,
      child: Container(
        margin: EdgeInsets.only(top: heightPercentageToDP(2, context)),
        padding: EdgeInsets.all(widthPercentageToDP(3, context)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: AppColors.transparent,
          border: Border.all(color: AppColors.greyish, width: 1),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 4,
              color: Colors.black26,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                    height: heightPercentageToDP(5, context),
                    width: widthPercentageToDP(20, context),
                    child: const Image(
                      image: AssetImage(AppImages.background),
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  width: widthPercentageToDP(2, context),
                ),
                Column(
                  children: [
                    BoldText(
                      text: 'CSCS Card',
                      size: 1.8,
                    ),
                    LightText(
                      text: 'verified',
                      color: AppColors.green,
                    )
                  ],
                ),
              ],
            ),
            const Icon(
              Icons.check_circle,
              color: AppColors.green,
            )
          ],
        ),
      ),
    );
  }
}

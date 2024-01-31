import 'package:flutter/material.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';

class CrousalImageView extends StatelessWidget {
  final List items;
  final int index;
  const CrousalImageView({super.key, required this.items, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthPercentageToDP(80, context),
      margin: EdgeInsets.only(right: widthPercentageToDP(2, context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(widthPercentageToDP(2, context)),
        image: DecorationImage(
          image: NetworkImage(items[index]),
          fit: BoxFit.fill,
        ),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 4,
            color: Colors.black26,
          ),
        ],
      ),
    );
  }
}

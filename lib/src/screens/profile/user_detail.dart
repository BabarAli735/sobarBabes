import 'package:flutter/material.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
import 'package:sobarbabe/src/widgets/index.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({Key? key}) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image(
            height: heightPercentageToDP(30, context),
            width: widthPercentageToDP(100, context),
            image: NetworkImage(
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D'),
            fit: BoxFit.cover,
          ),
          VerticalSpace(),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: widthPercentageToDP(3, context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BoldText(
                      text: 'Janiffer',
                      color: AppColors.black,
                    ),
                    CustomElevatedButton(text: 'Request Chat', onPressed: () {})
                  ],
                ),
                VerticalSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BoldText(
                      text: 'Age',
                      color: AppColors.black,
                    ),
                    BoldText(
                      text: '25',
                      color: AppColors.black,
                    )
                  ],
                ),
                VerticalSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BoldText(
                      text: 'Relation',
                      color: AppColors.black,
                    ),
                    BoldText(
                      text: 'Single',
                      color: AppColors.black,
                    ),
                  ],
                ),
                VerticalSpace(),
                Row(children: [
                  BoldText(
                    text: 'About',
                    color: AppColors.black,
                  ),
                ]),
                Container(
                  child: Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                    maxLines: 4,
                    style: TextStyle(color: AppColors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

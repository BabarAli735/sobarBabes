import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sobarbabe/src/constants/access_token_manager.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
import 'package:sobarbabe/src/models/nearby_models.dart';
import 'package:sobarbabe/src/provider/home_provider.dart';
import 'package:sobarbabe/src/widgets/index.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({Key? key}) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  late HomeProvider homeProvider;
  late String data;
  NearByModel? nearByModel;
  late bool isRequestSent = false;
  late bool isFav = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Access the arguments data here
    data = (ModalRoute.of(context)!.settings.arguments as String?)!;
    print(data);
    _getUserData(data);
  }

  Future<void> _getUserData(String data) async {
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    nearByModel = await homeProvider.getUserDetail(data);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary, // Make the app bar transparent
          elevation: 0, // Remove the shadow
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // Use the back arrow icon
            onPressed: () {
              Navigator.pop(
                  context); // Navigate back when the button is pressed
            },
          ),
        ),
        body: nearByModel != null
            ? Stack(
                children: [
                  Column(
                    children: [
                      Image(
                        height: heightPercentageToDP(30, context),
                        width: widthPercentageToDP(100, context),
                        image: NetworkImage(nearByModel!.image),
                        fit: BoxFit.cover,
                      ),
                      VerticalSpace(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: widthPercentageToDP(3, context)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BoldText(
                                  text: nearByModel!.Name,
                                  color: AppColors.black,
                                ),
                                CustomElevatedButton(
                                    text: isRequestSent
                                        ? 'Cancel Request'
                                        : 'Request Chat',
                                    onPressed: () {
                                      isRequestSent = !isRequestSent;
                                      setState(() {});
                                    }),
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
                                  text: nearByModel!.age,
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
                                  text: nearByModel!.relation,
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
                                nearByModel!.about,
                                maxLines: 4,
                                style: TextStyle(color: AppColors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 10,
                    child: InkWell(
                      onTap: () async {
                        isFav = !isFav;
                        setState(() {});
                        var token = await AccessTokenManager.getNumber();
                        if (isFav) {
                          var data = {
                            "userId": nearByModel!.userId,
                            "Name": nearByModel!.Name,
                            'about': nearByModel!.about,
                            'relation': nearByModel!.relation,
                            'age': nearByModel!.age,
                            "image": nearByModel!.image,
                            "user": token
                          };

                          homeProvider.addToFavorite(data);
                        }
                      },
                      child: Icon(
                        Icons.favorite,
                        color: isFav ? AppColors.primary : AppColors.white,
                        size: widthPercentageToDP(15, context),
                      ),
                    ),
                  ),
                ],
              )
            : Center(child: CircularProgressIndicator()));
  }
}

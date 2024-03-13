import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sobarbabe/src/constants/access_token_manager.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
import 'package:sobarbabe/src/models/user_models.dart';
import 'package:sobarbabe/src/provider/auth_provider.dart';
import 'package:sobarbabe/src/provider/home_provider.dart';
import 'package:sobarbabe/src/routes/routes_names.dart';

import 'package:sobarbabe/src/widgets/index.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeProvider homeProvider;
  late AuthenticationProvider authenticationProvider;
  late Map<dynamic, String> userProfileData = {};
  late Map<dynamic, String> matchProfileData = {};

  @override
  void initState() {
    super.initState();
    // Start the confetti loop
    Future.delayed(Duration.zero, () {
      loadData();
      authenticationProvider =
          Provider.of<AuthenticationProvider>(context, listen: false);
      _loadUserProfileData(authenticationProvider);
    });
  }

  // Define your markers
  Future<void> _loadUserProfileData(authenticationProvider) async {
    try {
      var token = await AccessTokenManager.getNumber();
      userProfileData = await authenticationProvider.getUserDetail(token!);

      setState(() {});
    } catch (error) {
      // Handle any errors that may occur during data loading
      print("Error loading user profile data: $error");
    }
  }

  void loadData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('NearBy').get();

    List<Map<String, dynamic>> documentData = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    // Generate a random index within the range of the list
    Random random = Random();
    int randomIndex = random.nextInt(documentData.length);

    // Get the map data at the randomly generated index
    Map<String, dynamic> randomMap = documentData[randomIndex];
    matchProfileData = randomMap.cast<dynamic, String>();

    setState(() {});
    // Print the randomly selected map
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Match people around you',
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.primary,
        titleTextStyle: TextStyle(
            color: AppColors.white, fontSize: responsivefonts(2.4, context)),
      ),
      body: Stack(children: [
        Image.asset(
          'assets/images/home_image.png',
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(child: BoldText(text: "It's Match")),
            Center(
                child: MediumText(text: "You and Sarah have liked each other")),
            Container(
              margin: EdgeInsets.only(top: heightPercentageToDP(3, context)),
              padding: EdgeInsets.symmetric(
                  horizontal: widthPercentageToDP(15, context)),
              child: Stack(
                alignment: Alignment.center, // Wrap your Row with a Stack
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(userProfileData.isNotEmpty
                            ? userProfileData['userPhotoLink'].toString()
                            : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRseRj5MjxLYtgPrmGHS01YBytPjIkGKk8Zaw&s'),
                        radius: widthPercentageToDP(15, context),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(matchProfileData
                                .isNotEmpty
                            ? matchProfileData['image'].toString()
                            : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRseRj5MjxLYtgPrmGHS01YBytPjIkGKk8Zaw&s'),
                        radius: widthPercentageToDP(15, context),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                  Positioned(
                    child: Container(
                        height: widthPercentageToDP(20, context),
                        width: widthPercentageToDP(20, context),
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                          Icons.favorite,
                          size: responsivefonts(5, context),
                          color: AppColors.white,
                        )),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: MediumText(
                    text:
                        "You and ${matchProfileData['Name']} have liked each other")),
            VerticalSpace(
              height: heightPercentageToDP(2, context),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: widthPercentageToDP(3, context)),
              child: CustomElevatedButton(
                text: 'Message Her',
                onPressed: () => {
                  Navigator.pushNamed(context, RoutesName.ChatScreen,
                      arguments: matchProfileData['userId'].toString())
                },
                buttonColor: AppColors.white,
                textColor: AppColors.primary,
              ),
            )
          ]),
        )
      ]),
    );
  }
}

class MatchProfileData {
  final String image;
  final String name;
  // Add more properties as needed

  MatchProfileData({
    required this.image,
    required this.name,
    // Add more parameters as needed
  });

  // Factory method to create MatchProfileData from a map
  factory MatchProfileData.fromMap(Map<String, dynamic> map) {
    return MatchProfileData(
      image: map['image'],
      name: map['name'],
      // Initialize other properties similarly
    );
  }
}

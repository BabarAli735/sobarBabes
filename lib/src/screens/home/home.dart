import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sobarbabe/src/constants/them.dart';
import 'package:sobarbabe/src/helpers/responsive_functions.dart';
import 'package:sobarbabe/src/provider/home_provider.dart';
import 'dart:ui' as ui;

import 'package:sobarbabe/src/routes/routes_names.dart';
import 'package:sobarbabe/src/widgets/index.dart';

class HomeScreen extends StatefulWidget {
  static const LatLng _center = const LatLng(45.521563, -122.677433);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();
  late HomeProvider homeProvider;
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  // Define your markers
  final List _matchData =[];
var allData =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
  }

  loadData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('NearBy').get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  print('allData=='+allData.toString());
    // allData.forEach((doc) async {
    //   final Map<String, dynamic>? data = doc as Map<String, dynamic>?;

    //   // Explicitly specify the type of doc

    //   if (data != null) {
    //     _matchData.add(data);
    //     setState(() {});
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Match people around you',
        ),
        backgroundColor: AppColors.black,
        titleTextStyle: TextStyle(
            color: AppColors.white, fontSize: responsivefonts(2.4, context)),
      ),
      // body: GoogleMap(
      //   onMapCreated: _onMapCreated,
      //   markers: Set<Marker>.of(_markers),
      //   initialCameraPosition: const CameraPosition(
      //     target: HomeScreen._center,
      //     zoom: 11.0,
      //   ),
      // ),
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
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSu0gYR-As9-_w2_fjRc895mD_91WQ5p7N_9Q&s'),
                        radius: widthPercentageToDP(15, context),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSu0gYR-As9-_w2_fjRc895mD_91WQ5p7N_9Q&s'),
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
                margin: EdgeInsets.only(top: 20),
                child: MediumText(text: "You and Sarah have liked each other"))
          ]),
        )
      ]),
    );
  }
}

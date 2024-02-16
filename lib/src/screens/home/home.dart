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
  final List<Marker> _markers = <Marker>[];

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
    List<Marker> markers = [];
    allData.forEach((doc) async {
      final Map<String, dynamic>? data = doc as Map<String, dynamic>?;

      // Explicitly specify the type of doc

      if (data != null) {
        Uint8List? image = await loadNetworkImage(data['image']);
        final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
          image.buffer.asUint8List(),
          targetWidth: 200,
          targetHeight: 200,
        );
        final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
        final ByteData? byteData =
            await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
        final Uint8List? rezizesImageMarker =
            await byteData?.buffer.asUint8List();

        Marker marker = Marker(
          markerId: MarkerId(data['Name']),
          position: LatLng(data['lat'], data['lng']),
          infoWindow: InfoWindow(title: data['Name']),
          icon: BitmapDescriptor.fromBytes(rezizesImageMarker!),
          onTap: () => {
            Navigator.pushNamed(context, RoutesName.UserDetail,arguments: data['userId'])
          },
        );

        _markers.add(marker);
        setState(() {});
      }
    });
  }

  Future<Uint8List> loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));
    final imageInfo = await completer.future;
    final byteData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match people around you',),
        backgroundColor: AppColors.black,
        titleTextStyle: TextStyle(color: AppColors.white,fontSize: responsivefonts(2.4, context)),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: Set<Marker>.of(_markers),
        initialCameraPosition: const CameraPosition(
          target: HomeScreen._center,
          zoom: 11.0,
        ),
      ),
    );
  }
}

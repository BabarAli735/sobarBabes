import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class HomeScreen extends StatefulWidget {
  static const LatLng _center = const LatLng(45.521563, -122.677433);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  // Define your markers
  final List<Marker> _markers = <Marker>[];
  List<LatLng> _lating = [
    LatLng(45.521563, -122.677433),
    LatLng(45.531563, -122.667433),
    LatLng(45.531563, -122.667433)
  ];
  List<Map<String, dynamic>> data = [
    {
      'id': '1',
      'position': const LatLng(45.521563, -122.677433),
      'assetPath': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D'
    },
    {
      'id': '2',
      'position': const LatLng(45.531563, -122.667433),
      'assetPath': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D'
    },
    {
      'id': '3',
      'position': const LatLng(45.531563, -122.667433),
      'assetPath': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D'
    },
  ];
  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

 

  loadData() async {
    for (var i = 0; i < _lating.length; i++) {
      Uint8List? image = await loadNetworkImage(data[i]['assetPath']);
      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
          image.buffer.asUint8List(),
          targetWidth: 200,
          targetHeight: 200,

          );
      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData =
          await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
          final Uint8List? rezizesImageMarker=await byteData?.buffer.asUint8List();
      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
            position: _lating[i],
            infoWindow: InfoWindow(title: 'Title of marker' + i.toString()),
            icon: BitmapDescriptor.fromBytes(rezizesImageMarker!)
            ),
    
      );
      setState(() {});
    }
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
        title: Text('Maps Sample App'),
        backgroundColor: Colors.green[700],
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchResultsState();
}

class SearchResultsState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.flag),
        onPressed: () {
          _goToFuji();
        },
      ),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: tokyoPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {tokyoMarker, fujiMarker},
      ),
    );
  }

  Future<void> _disposeController() async {
    final GoogleMapController controller = await _controller.future;
    controller.dispose();
    print('is disposed!!!!');
  }

  Future<void> _goToFuji() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(fujiPosition));
  }
}

CameraPosition tokyoPosition = CameraPosition(target: LatLng(35.6895, 139.6917), zoom: 10);
CameraPosition fujiPosition = CameraPosition(target: LatLng(35.3606, 138.7278), zoom: 9);

Marker tokyoMarker = Marker(
  markerId: MarkerId('tokyo'),
  position: LatLng(35.6895, 139.6917),
  infoWindow: InfoWindow(title: 'Tokyo'),
);

Marker fujiMarker = Marker(
  markerId: MarkerId('fuji'),
  position: LatLng(35.3606, 138.7278),
  infoWindow: InfoWindow(title: 'Mount Fuji'),
);

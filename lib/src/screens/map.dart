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
          _goToLosAngeles();
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
        initialCameraPosition: vegasPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {vegasMarker, losAngelesMarker},
      ),
    );
  }

  Future<void> _disposeController() async {
    final GoogleMapController controller = await _controller.future;
    controller.dispose();
  }

  Future<void> _goToLosAngeles() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(losAngelesPosition));
  }
}

CameraPosition vegasPosition = CameraPosition(target: LatLng(36.0953103, -115.1992098), zoom: 10);
CameraPosition losAngelesPosition = CameraPosition(target: LatLng(34.0345471, -118.2643037), zoom: 9);

Marker vegasMarker = Marker(
  markerId: MarkerId('vegas'),
  position: LatLng(36.0953103, -115.1992098),
  infoWindow: InfoWindow(title: 'Las Vegas'),
);

Marker losAngelesMarker = Marker(
  markerId: MarkerId('losAngeles'),
  position: LatLng(34.0345471, -118.2643037),
  infoWindow: InfoWindow(title: 'Los Angeles'),
);

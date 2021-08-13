import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MapsPage extends StatefulWidget {
  final String id;

  MapsPage({this.id});

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(-3.750589, -38.509452),
    zoom: 17
  );
  FirebaseFirestore _db = FirebaseFirestore.instance;
  
  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _showSuccessScreen(String title) {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: Text("Ok")
            )
          ],
        );
      }
    );
  }

  _addMarker(LatLng latLng) async {
    List<Placemark> placemarks = await _getUserLocationBaseOnMarker(latLng);

    Marker marker = Marker(
      markerId: MarkerId("marker-${latLng.latitude}-${latLng.longitude}"),
      position: LatLng(latLng.latitude, latLng.longitude),
      infoWindow: InfoWindow(
        title: placemarks.first.name
      )
    );

    Map<String, dynamic> travel = {};
    travel["name"] = placemarks.first.name;
    
    setState(() {
      this._markers.add(marker);
      _db.collection("travels").add(travel);
    });
  }

  Future<List<Placemark>> _getUserLocationBaseOnMarker(LatLng latLng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    return placemarks;
  }

  _moveCamera() async {
    GoogleMapController googleMapController = await _controller.future;

    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(_cameraPosition)
    );
  }

  _getUserLocation() async {
    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10
    ).listen((Position position) {
      setState(() {
        this._cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 17
        );

        _moveCamera();
      });
    });
  }

  _getTravelById(String travelId) async {
    print(travelId);
    if (travelId != null) {
      DocumentSnapshot documentSnapshot = await _db.collection("travels").doc(travelId).get();
      var address = documentSnapshot.get("name");

      List<Location> location = await locationFromAddress(address);

      Marker marker = Marker(
        markerId: MarkerId("marker-${location.first.latitude}-${location.first.longitude}"),
        position: LatLng(location.first.latitude, location.first.longitude),
        infoWindow: InfoWindow(
          title: address
        )
      );

      setState(() {
        this._cameraPosition = CameraPosition(
          target: LatLng(location.first.latitude, location.first.longitude),
          zoom: 18,
        );
        this._markers.add(marker);
        _moveCamera();
      });
    } else {
      _getUserLocation();
    }
  }

  @override
  void initState() {
    super.initState();
    // _getUserLocation();
    _getTravelById(widget.id);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa"),
      ),

      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _cameraPosition,
          onMapCreated: _onMapCreated,
          onLongPress: _addMarker, 
          markers: _markers,
          myLocationEnabled: true,
        )
      ),
    );
  }
}
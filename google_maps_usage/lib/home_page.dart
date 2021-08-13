import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  // Set<Polygon> _polygons = {};
  Set<Polyline> _polylines = {};
  double _zoom;
  // Position _position;
  CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(-3.751297, -38.510039),
    zoom: 17
  );

  /*Marker marker = Marker(
    markerId: MarkerId("my-location"),
    position: LatLng(-3.751297, -38.510039),
  );*/
  // String _error;

   _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      this._cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 17
      );
    });

    _moveCamera();
  }

  _onMapCreated(GoogleMapController googleMapController) {
    _controller.complete(googleMapController);
  }

  _moveCamera() async {
    GoogleMapController googleMapController = await _controller.future;

    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(_cameraPosition)
    );
  }

  _loadMarkers() {
    /*Marker marker = Marker(
      markerId: MarkerId("sopping-marker"),
      position: LatLng(-3.757490, -38.489529),
      infoWindow: InfoWindow(
        title: "Shopping Iguatemi"
      ),
      onTap: () {
        setState(() {
          this._zoom = 80;
        });

        _moveCamera();
      }
    );

    setState(() {
      _markers.add(marker);
    });*/

    /*Polygon polygon = Polygon(
      polygonId: PolygonId("polygon1"),
      fillColor: Colors.transparent,
      strokeWidth: 10,
      strokeColor: Colors.red,
      points: [
        LatLng(-3.757490, -38.489529),
        LatLng(-3.751039, -38.490379),
        LatLng(-3.748630, -38.492186),
        LatLng(-3.745993, -38.500685),
        LatLng(-3.744015, -38.507122),
        LatLng(-3.745760, -38.507905),
        LatLng(-3.747676, -38.508549),
        LatLng(-3.750591, -38.509440)
      ]
    );

    setState(() {
      this._polygons.add(polygon);
    });*/

    Polyline polyline = Polyline(
      polylineId: PolylineId("polyline1"),
      color: Colors.blue,
      jointType: JointType.mitered,
      points: [
        LatLng(-3.757490, -38.489529),
        LatLng(-3.751039, -38.490379),
        LatLng(-3.748630, -38.492186),
        LatLng(-3.745993, -38.500685),
        LatLng(-3.744015, -38.507122),
        LatLng(-3.745760, -38.507905),
        LatLng(-3.747676, -38.508549),
        LatLng(-3.750591, -38.509440)
      ],
      startCap: Cap.roundCap,
      endCap: Cap.roundCap
    );

    setState(() {
      this._polylines.add(polyline);
    });
  }

  _addLocaleListening() async {
    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10
    ).listen((Position position) {
      Marker marker = Marker(
        markerId: MarkerId("my-location"),
        position: LatLng(position.latitude, position.longitude)
      );

      setState(() {
        this._cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 17
        );

        this._markers.add(marker);
      });
    });

    // print(positionStream);
  }

  _getDataFromAdress() async {
    List<Location> location = await locationFromAddress("José Vilar 3121, Fortaleza");
    List<Placemark> placemarks = await placemarkFromCoordinates(location.first.latitude, location.first.longitude, localeIdentifier: "pt_BR");

    setState(() {
      this._cameraPosition = CameraPosition(
        target: LatLng(location.first.latitude, location.first.longitude),
        zoom: 17
      );
    });

    print(placemarks.first.name);
  }

  @override
  void initState() {
    super.initState();
    // _loadMarkers();
    // _getLocation();
    // _addLocaleListening();
    // _getMarker();
    _getDataFromAdress();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapas")
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done,), 
        onPressed: _moveCamera,
      ),

      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _cameraPosition,
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          markers: _markers,
          // polygons: _polygons,
          // polylines: _polylines,
        ),
      ),
    );
  }
}
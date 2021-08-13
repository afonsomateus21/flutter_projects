import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/model/destination_model.dart';
import 'package:uber/model/request_model.dart';
import 'package:uber/model/user_model.dart';
import 'package:uber/route_generator.dart';
import 'dart:io';

import 'package:uber/util/firebase_user.dart';
import 'package:uber/util/request_status.dart';

class PassengerPage extends StatefulWidget {
  @override
  _PassengerPageState createState() => _PassengerPageState();
}

class _PassengerPageState extends State<PassengerPage> {
  List<String> _menuItem = [
    "settings", "logout"
  ];
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(-3.750611, -38.509452),
  );
  TextEditingController _addressController = TextEditingController();
  // controls 
  bool _showDestinationAddressField = true;
  String _buttonText = "Chamar Uber";
  Color _buttonColor = Color(0xff1ebbd8);
  Function _buttonFunction;

  _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
  }
  
  _logout() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.signOut();
    Navigator.pushReplacementNamed(
      context, 
      RouteGenerator.LOGIN_ROUTE
    );
  }

  _choiceMenu(String choice) {
    switch(choice) {
      case "logout":
        _logout();
        break;

      case "settings":
        break;
    }
  }

  _userLocationListener() async {
    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
      distanceFilter: 10,
      desiredAccuracy: LocationAccuracy.high
    ).listen((Position position) {
      setState(() {
        if (position != null) {
          _showPassengerMarker(position);
          _cameraPosition = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 18
          );

          _moveCamera(_cameraPosition);
        }
      });
    });
  }

  _moveCamera(CameraPosition cameraPosition) async {
    GoogleMapController googleMapController = await _controller.future;

    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition)
    );
  }

  _showPassengerMarker(Position position) async {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        devicePixelRatio: pixelRatio 
      ), 
      "images/passageiro.png"
    ).then((BitmapDescriptor icon) {
      Marker passengerMarker = Marker(
        markerId: MarkerId("passenger-marker"),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(
          title: "Meu local"
        ),
        icon: icon
      );

      setState(() {
        this._markers.add(passengerMarker);
      });
    });
  }

  _getLastLocation() async {
    Position position = await Geolocator.getLastKnownPosition();

    setState(() {
      if (position != null) {
        _showPassengerMarker(position);
        _cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 18
        );

        _moveCamera(_cameraPosition);
      }
    });
  }

  _saveRequest(Destination destination) async {
    Request request = Request();

    UserModel passenger = await FirebaseUser.getLoggedUserData();
    
    request.destination = destination;
    request.passenger = passenger;
    request.status = RequestStatus.WAITING;

    FirebaseFirestore db = FirebaseFirestore.instance;

    // save request
    db.collection("requests")
      .doc(request.id)
      .set(request.toMap());

    // save active request
    Map<String, dynamic> activeRequestData = {};

    activeRequestData["request_id"] = request.id;
    activeRequestData["user_id"] = passenger.userId;
    activeRequestData["status"] = RequestStatus.WAITING;

    db.collection("active_request")
      .doc(passenger.userId)
      .set(activeRequestData);
  } 

  _orderUber() async {
    String address = _addressController.text;

    if (address.isNotEmpty) {
      List<Location> addresses = await locationFromAddress(address);
      
      if (addresses != null && addresses.length > 0) {
        List<Placemark> placemarks = await placemarkFromCoordinates(addresses.first.latitude, addresses.first.longitude);
        Placemark placemark = placemarks.first;

        Destination destination = Destination();
        destination.city = placemark.locality;
        destination.cep = placemark.postalCode;
        destination.neighborhood = placemark.subLocality;
        destination.street = placemark.thoroughfare;
        destination.number = placemark.subThoroughfare;
        destination.latitude = addresses.first.latitude;
        destination.longitude = addresses.first.longitude;

        String confirmationAddress;

        confirmationAddress = "\n Cidade: " + destination.city;
        confirmationAddress += "\n Rua: " + destination.street + ", " + destination.number;
        confirmationAddress += "\n Bairro: " + destination.neighborhood;

        showDialog(
          context: context, 
          builder: (context) {
            return AlertDialog(
              title: Text("Confirmação do Endereço"),
              content: Text(confirmationAddress),
              contentPadding: EdgeInsets.all(16),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context), 
                  child: Text(
                    "Cancelar",
                    style: TextStyle(
                      color: Colors.red
                    ),
                  )
                ),

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _saveRequest(destination); 
                  },
                  child: Text(
                    "Confirmar",
                    style: TextStyle(
                      color: Colors.green
                    ),
                  )
                )
              ],
            );
          }
        );
      }
    }
  }

  _changeMainButton(String text, Color color, Function buttonFunction) {
    setState(() {
      _buttonText = text;
      _buttonColor = color;
      _buttonFunction = buttonFunction;
    });
  }

  _statusUberNotOrdered() {
    setState(() {
      _showDestinationAddressField = true;
    });
    _changeMainButton(
      "Chamar Uber", 
      Color(0xff1ebbd8), 
      () {
        _orderUber();
      }
    );
  }

  _statusWaiting() {
    setState(() {
      _showDestinationAddressField = false;
    });
    _changeMainButton(
      "Cancelar", 
      Colors.red,
      () {
        _cancelUber();
      }
    );
  }

  _cancelUber() {

  }

  _addListenerActiveRequest() async {
    User firebaseUser = FirebaseUser.getCurrentUser();

    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("active_request")
      .doc(firebaseUser.uid)
      .snapshots()
      .listen((snapshot) {
        if (snapshot.data() != null) {
          Map<String, dynamic> data = snapshot.data();
          String status = data["status"];
          String requestId = data["request_id"];

          switch(status) {
            case RequestStatus.WAITING:
              _statusWaiting();
              break;

            case RequestStatus.GOING:
              break;

            case RequestStatus.INITIALIZED:
              break;

            case RequestStatus.FINISHED:
              break;
          }
        } else {
          _statusUberNotOrdered();
        }
      });
  }

  @override
  void initState() {
    super.initState();
    _getLastLocation();
    _userLocationListener();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Passageiro"),
        backgroundColor: Colors.black,
        actions: [
          PopupMenuButton<String>(
            onSelected: _choiceMenu,
            icon: Icon(Icons.more_vert_rounded),
            itemBuilder: (context) {
              return _menuItem.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
      ),

      body: Container(  
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: _cameraPosition,
              onMapCreated: _onMapCreated,
              // myLocationEnabled: true,
              myLocationButtonEnabled: false,
              markers: _markers,
            ),

            Visibility(
              visible: _showDestinationAddressField,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white
                        ),
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            icon: Row(
                              mainAxisSize: MainAxisSize.min,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Icon(Icons.location_on, color: Colors.green)
                                ),
                              ],
                            ),
                            hintText: "Meu local",
                            border: InputBorder.none,
                            // contentPadding: EdgeInsets.only(left: 15, top: 16)
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 55,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white
                        ),
                        child: TextField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            icon: Row(
                              mainAxisSize: MainAxisSize.min,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Icon(Icons.local_taxi, color: Colors.black)
                                ),
                              ],
                            ),
                            hintText: "Digite o destino",
                            border: InputBorder.none,
                            // contentPadding: EdgeInsets.only(left: 15, top: 16)
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
              )
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: Platform.isIOS 
                  ? EdgeInsets.fromLTRB(20, 10, 20, 25)
                  : EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: _buttonFunction,
                  child: Text(
                    _buttonText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(_buttonColor),
                    padding: MaterialStateProperty.all(EdgeInsets.all(15))
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber/model/destination_model.dart';
import 'package:uber/model/user_model.dart';


class Request {
  String _id;
  String _status;
  UserModel _passenger;
  UserModel _driver;
  Destination _destination;

  Request() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference reference = db.collection("requests").doc();

    this._id = reference.id;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> passengerData = {
      "username": this._passenger.username,
      "email": this._passenger.userEmail,
      "kindOfUser": this._passenger.userKind,
      "userId": this._passenger.userId,
    };

    Map<String, dynamic> destinationData = {
      "street": this._destination.street,
      "number": this._destination.number,
      "neighborhood": this._destination.neighborhood,
      "cep": this._destination.cep,
      "latitude": this._destination.latitude,
      "longitude": this._destination.longitude
    };

    Map<String, dynamic> requestData = {
      "id": this._id,
      "status": this._status,
      "passenger": passengerData,
      "driver": null,
      "destination": destinationData,
    };

    return requestData;
  }

  String get id => this._id;

  String get status => this._status;

  UserModel get passenger => this._passenger;

  UserModel get driver => this._driver;

  Destination get destination => this._destination;

  set id(String id) {
    this._id = id;
  }

  set status(String status) {
    this._status = status;
  }

  set passenger(UserModel passenger) {
    this._passenger = passenger;
  }

  set driver(UserModel driver) {
    this._driver = driver;
  }

  set destination(Destination destination) {
    this._destination = destination;
  }
}
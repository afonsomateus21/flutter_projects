import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_travels/maps_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = StreamController<QuerySnapshot>.broadcast();
  FirebaseFirestore _db = FirebaseFirestore.instance;

  _addTravel() {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (_) => MapsPage())
    );
  }

  _openMap(String id) async {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (_) => MapsPage(id: id))
    );
  }

  _removeTravel(String id) {
    _db.collection("travels").doc(id).delete();
  }

  _getTravels() async {
    final stream = _db.collection("travels")
      .snapshots();

    stream.listen((data) {
      _controller.add(data);
    });
  }

  @override
  void initState() {
    super.initState();
    _getTravels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Viagens"),
        backgroundColor: Color(0xff0066cc),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: _controller.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Align(
              alignment: Alignment.center,
              child: Text("Não foi possível carregar os dados."),
            );
          }

          else if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data;
            List<DocumentSnapshot> travels = querySnapshot.docs.toList();

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: travels.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot item = travels[index];
                      String travelTitle = item["name"];
                      
                      return GestureDetector(
                        onTap: () {
                          _openMap(item.id);
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(travelTitle),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _removeTravel(item.id);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ),
                      );
                    }
                  )
                )
              ],
            );
          }

          return Padding(
            padding: EdgeInsets.all(8),
            child: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          );
        }

 
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTravel();
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xff0066cc),
      ),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber/route_generator.dart';

class DriverPage extends StatefulWidget {
  @override
  _DriverPageState createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  List<String> _menuItem = [
    "settings", "logout"
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Motorista"),
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

      body: Container(),
    );
  }
}
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.cyan,
        child: Center(
          child: Text(
            "Settings Page",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0
            )
          )
        )
      )
    );
  }
}
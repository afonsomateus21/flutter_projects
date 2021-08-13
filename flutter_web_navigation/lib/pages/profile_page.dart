import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.cyan,
        child: Center(
          child: Text(
            "Profile Page",
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
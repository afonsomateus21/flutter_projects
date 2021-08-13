import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.cyan,
        child: Center(
          child: Text(
            "Home Page",
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
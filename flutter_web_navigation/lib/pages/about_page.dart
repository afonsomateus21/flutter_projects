import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  final String name;

  const AboutPage(this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.cyan,
        child: Center(
          child: Text(
            "About Page ... and here is the parameter passed: $name",
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
import 'package:flutter/material.dart';

class HomeMobileAppBar extends StatefulWidget {
  @override
  _HomeMobileAppBarState createState() => _HomeMobileAppBarState();
}

class _HomeMobileAppBarState extends State<HomeMobileAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff1dc690),
      title: Text("Home"),
    );
  }
}
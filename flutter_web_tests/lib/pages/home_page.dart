import 'package:flutter/material.dart';
import 'package:flutter_web_tests/locator.dart';
import 'package:flutter_web_tests/router_generator.dart';
import 'package:flutter_web_tests/services/navigation_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home")
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              locator<NavigationService>().navigateTo(PROFILE_ROUTE);
            }, 
            child: Text(
              "Profile"
            )
          )
        ),
      ),
    );
  }
}
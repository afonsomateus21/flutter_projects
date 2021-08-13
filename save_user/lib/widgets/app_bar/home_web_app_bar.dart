import 'package:flutter/material.dart';
import 'package:save_user/route_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeWebAppBar extends StatefulWidget {
  @override 
  _HomeWebAppBarState createState() => _HomeWebAppBarState();
}

class _HomeWebAppBarState extends State<HomeWebAppBar>  {
  _logout(context) async {
    final preferences = await SharedPreferences.getInstance();

    preferences.setBool("logged", false);

    Navigator.pushReplacementNamed(
      context, 
      RouteGenerator.LOGIN_PAGE
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff1dc690),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Home",
          ),
          
          TextButton(
            onPressed: () {
              _logout(context);
            },
            child: Text(
              "Sair",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15
              ),
            ),
          )
        ]
      ),
    );
  }
}
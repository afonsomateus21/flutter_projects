import 'package:flutter/material.dart';
import 'package:save_user/route_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeMobileDrawer extends StatelessWidget {
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
    return Drawer(
      child: Align(
        alignment: Alignment.topCenter,
        child: TextButton(
          onPressed: () {
            _logout(context);
          },
          child: Text(
            "Sair",
            style: TextStyle(
              color: Color(0xff1dc690),
              fontSize: 15
            ),
          ),
        ),
      )
    );
  }
}
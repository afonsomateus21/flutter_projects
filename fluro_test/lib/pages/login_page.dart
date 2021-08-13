import 'package:fluro_test/router.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Text('Please Login'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        onPressed: () {
          var username = "";
          // Navigator.pushReplacementNamed(context, "/home/$username");
          if (username.isNotEmpty)
            Routes.router.navigateTo(context, "/home/$username");
        },
      ),
    );
  }
}
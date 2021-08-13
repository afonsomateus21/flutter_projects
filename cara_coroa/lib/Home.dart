import 'dart:math';

import 'package:cara_coroa/PlayScreen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override 
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _openPlayScreen() {
    int option = Random().nextInt(2);

    Navigator.push(
      context, 
      MaterialPageRoute(builder: (contex) => PlayScreen(option))
    );
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff61bd86),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("images/logo.png"),
            GestureDetector(
              child: Image.asset("images/botao_jogar.png"),
              onTap: () => {_openPlayScreen()},
            ),
          ]
        ),
      ),
    );
  }
}
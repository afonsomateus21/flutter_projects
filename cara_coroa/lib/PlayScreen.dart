import 'package:cara_coroa/Home.dart';
import 'package:flutter/material.dart';

class PlayScreen extends StatefulWidget {
  int _option;

  PlayScreen(this._option);

  @override 
  _PlayScreen createState() => _PlayScreen();
}

class _PlayScreen extends State<PlayScreen> {
  List _options = ["images/moeda_cara.png", "images/moeda_coroa.png"];

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff61bd86),
      body: Container(
        padding: EdgeInsets.all(10),
        // width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(this._options[widget._option]),
            GestureDetector(
              child: Image.asset("images/botao_voltar.png"),
              onTap: () => {Navigator.pop(context)},
            ),
          ]
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import 'dart:convert';

class Home extends StatefulWidget {
  @override 
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _bitcoinInformations = '';

  void _getBitcoinData() async {
    String url = "https://blockchain.info/ticker";

    http.Response response = await http.get(url);

    Map<String, dynamic> result = json.decode(response.body);

    setState(() {
      _bitcoinInformations = "${result["BRL"]["symbol"]} ${result["BRL"]["sell"]}";
    });
  }

  @override 
  Widget build(BuildContext buildContext) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/bitcoin.png"),

            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                _bitcoinInformations,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 30),
              child: RaisedButton(
                onPressed: _getBitcoinData,
                child: Text(
                  "Atualizar",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
                color: Colors.orange,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              )
            )
          ],
        ),
      ),
    );
  }
}
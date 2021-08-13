import 'package:flutter/material.dart';
import 'dart:math';

class Jogo extends StatefulWidget {
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  var _imageApp = AssetImage("images/padrao.png");
  var _message = "Escolha uma opção abaixo:";

  void _selectOption(String userChoice) {
    var options = ["pedra", "papel", "tesoura"];
    var index = Random().nextInt(3);
    var appChoice = options[index];

    switch (appChoice) {
      case "pedra":
        setState(() {
          this._imageApp = AssetImage("images/pedra.png");
        });
        break;

      case "papel":
        setState(() {
          this._imageApp = AssetImage("images/papel.png");
        });
        break;

      case "tesoura":
        setState(() {
          this._imageApp = AssetImage("images/tesoura.png");
        });
        break;  
    }

    if (
      (userChoice == "pedra" && appChoice == "tesoura") ||
      (userChoice == "tesoura" && appChoice == "papel") ||
      (userChoice == "papel" && appChoice == "pedra")
    ) {
      setState(() {
        this._message = "Você venceu!! 🤗";
      });
    }

    else if (
      (appChoice == "pedra" && userChoice == "tesoura") ||
      (appChoice == "tesoura" && userChoice == "papel") ||
      (appChoice == "papel" && userChoice == "pedra")
    ) {
      setState(() {
        this._message = "Você perdeu 😢";
      });
    }

    else {
      setState(() {
        this._message = "Empate 😬";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JokenPo")
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        
        children: [
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Escolha do App:",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          Image(image: this._imageApp,),

          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "$_message",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          Row(
            children: [
              GestureDetector(
                onTap: () => _selectOption("pedra"),
                child: Image.asset("images/pedra.png", height: 95,),
              ),
              
              GestureDetector(
                onTap: () => _selectOption("papel"),
                child: Image.asset("images/papel.png", height: 95),
              ),

              GestureDetector(
                onTap: () => _selectOption("tesoura"),
                child: Image.asset("images/tesoura.png", height: 95),
              ),
            ],

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          )
        ],
      ),
    );
  }
}
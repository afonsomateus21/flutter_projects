import 'package:flutter/material.dart';

class EntradaSlider extends StatefulWidget {
  @override
  _EntradaSlider createState() => _EntradaSlider();
}

class _EntradaSlider extends State<EntradaSlider> {
  double _userChoice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada de dados"),
      ),

      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Slider(
              value: _userChoice, 
              min: 0,
              max: 5,
              label: "$_userChoice",
              divisions: 5,
              onChanged: (double value) => {
                setState(() => {
                  _userChoice = value
                })
              }
            ),

            RaisedButton(
              onPressed: () => {
                print(_userChoice.truncate())
              },
              
              child: Text(
                "Salvar",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            )
          ]
        ),
      )
    );
  }
}
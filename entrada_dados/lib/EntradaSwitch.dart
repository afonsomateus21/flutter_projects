import 'package:flutter/material.dart';

class EntradaSwitch extends StatefulWidget {
  @override
  _EntradaSwitch createState() => _EntradaSwitch();
}

class _EntradaSwitch extends State<EntradaSwitch> {
  bool _switchState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada de dados"),
      ),

      body: Container(
        child: Column(
          children: [
            /*Switch(
              value: _switchState, 
              onChanged: (bool value) => {
                setState(() => {
                  _switchState = value,
                  print(value)
                })
              }
            ),

            Text("Receber notificações?")*/

            SwitchListTile(
              value: _switchState, 
              title: Text("Receber notificações?"),
              onChanged: (bool value) => {
                setState(() => {
                  _switchState = value,
                })
              }
            ),

            RaisedButton(
              onPressed: () => {
                print(_switchState)
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
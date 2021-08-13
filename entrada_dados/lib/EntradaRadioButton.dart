import 'package:flutter/material.dart';

class EntradaRadioButton extends StatefulWidget {
  @override
  _EntradaRadioButton createState() => _EntradaRadioButton();
}

class _EntradaRadioButton extends State<EntradaRadioButton> {
  String _escolhaUsuario; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada de dados"),
      ),

      body: Container(
        child: Column(
          children: [
            /*Text("Masculino"),
            Radio(
              value: "m", 
              groupValue: _escolhaUsuario,
              onChanged: (String escolha) => {
                setState(() => {
                  _escolhaUsuario = escolha
                })
              }
            ),

            Text("Feminino"),
            Radio(
              value: "f", 
              groupValue: _escolhaUsuario,
              onChanged: (String escolha) => {
                setState(() => {
                  _escolhaUsuario = escolha
                })
              }
            ),*/

            RadioListTile(
              title: Text("Masculino"),
              value: "m", 
              groupValue: _escolhaUsuario, 
              onChanged: (String escolha) => {
                setState(() => {
                  _escolhaUsuario = escolha
                })
              }
            ),

            RadioListTile(
              title: Text("Feminino"),
              value: "f", 
              groupValue: _escolhaUsuario, 
              onChanged: (String escolha) => {
                setState(() => {
                  _escolhaUsuario = escolha
                })
              }
            ),

            RaisedButton(
              onPressed: () => {
                print(_escolhaUsuario),
              },
              
              child: Text(
                "Salvar",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
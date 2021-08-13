import 'package:flutter/material.dart';

class EntradaCheckBox extends StatefulWidget {
  @override
  _EntradaCheckBox createState() => _EntradaCheckBox();
}

class _EntradaCheckBox extends State<EntradaCheckBox> {
  bool _checkedComidaBrasileira = false;
  bool _checkedComidaMexicana = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada de dados"),
      ),

      body: Container(
        child: Column(
          children: [
            // Text("Comida Brasileira"),
            // Checkbox(
            //   value: _checked, 
            //   onChanged: (bool value) => {
            //     setState(() => {
            //       _checked = value
            //     })
            //   }
            // )

            CheckboxListTile(
              title: Text("Comida Brasileira"),
              subtitle: Text("A melhor comida do mundo!"),
              activeColor: Colors.lightGreen,
              selected: _checkedComidaBrasileira,
              secondary: Icon(Icons.add_box),
              value: _checkedComidaBrasileira, 
              onChanged: (bool value) => {
                setState(() => {
                  _checkedComidaBrasileira = value
                })
              }
            ),

            CheckboxListTile(
              title: Text("Comida Mexicana"),
              subtitle: Text("Aqui amamos pimenta!"),
              activeColor: Colors.lightGreen,
              selected: _checkedComidaMexicana,
              secondary: Icon(Icons.add_box),
              value: _checkedComidaMexicana, 
              onChanged: (bool value) => {
                setState(() => {
                  _checkedComidaMexicana = value
                })
              }
            ),

            RaisedButton(
              onPressed: () => {
                print(_checkedComidaBrasileira),
                print(_checkedComidaMexicana)
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
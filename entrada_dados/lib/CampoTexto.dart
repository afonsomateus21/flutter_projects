import 'package:flutter/material.dart';

class CampoTexto extends StatefulWidget {
  @override
  _CampoTextoState createState() => _CampoTextoState();
}

class _CampoTextoState extends State<CampoTexto> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada de dados"),
      ),

      body: Column(
        children: [
          Padding(
             padding: EdgeInsets.all(32),
             child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Digite um valor:"
              ),
              style: TextStyle(
                fontSize: 25
              ),
              // onChanged: (String e) => {
              //   print(e)
              // }, 
              onSubmitted: (String e) => {
                print(e)
              },
              controller: _textEditingController,
            ),
          ),

          RaisedButton(
            onPressed: () => {
              print(_textEditingController.text)
            },
            child: Text("Salvar"),
            color: Colors.lightBlue,
          )
        ],  
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _endereco = '';
  TextEditingController _cepController = TextEditingController();

  _recuperarCep() async {
    String cep = _cepController.text;
    String url = "https://viacep.com.br/ws/$cep/json/";

    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);

    setState(() {
      _endereco = "${retorno["logradouro"]}, ${retorno["bairro"]}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço web")
      ),

      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Insira seu cep: "
              ),

              controller: _cepController,
            ),
            
            RaisedButton(
              onPressed: _recuperarCep,
              child: Text("Clique aqui"),
            ),

            Text(_endereco),
          ],
        )
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Options extends StatefulWidget {
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  TextEditingController _controllerAlcool = TextEditingController();
  TextEditingController _controllerGasolina = TextEditingController(); 
  String _textoResultado = "";

  void _calcular() {
    double precoAlcool = double.tryParse(_controllerAlcool.text);
    double precoGasolina = double.tryParse(_controllerGasolina.text);
    
    if (precoAlcool == null || precoGasolina == null) {
      setState(() {
        _textoResultado = "Número inválido! Digite números maiores do que 0 e com o (.)";
      });
    } else {
      setState(() {
        _textoResultado = precoAlcool/precoGasolina >= 0.7 ? "A gasolina é a melhor opção" : "O álcool é a melhor opção";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Álcool ou Gasolina")
      ),

      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: Image.asset("images/logo.png"),
              ),

              Padding(
                child: Text(
                  "Saiba qual a melhor opção para abastecimento do seu carro",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                  ),
                ),
                padding: EdgeInsets.only(bottom: 10),
              ),

              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Preço Alcool, ex: 1.59",
                ),
                style: TextStyle(
                  fontSize: 22
                ),
                controller: _controllerAlcool,
              ),

              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Preço Gasolina, ex: 3.59",
                ),
                style: TextStyle(
                  fontSize: 22
                ),
                controller: _controllerGasolina,
              ),


              Padding(
                padding: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  onPressed: _calcular,
                  child: Text(
                    "Calcular",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "$_textoResultado",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
        )
      )
    );
  }
}
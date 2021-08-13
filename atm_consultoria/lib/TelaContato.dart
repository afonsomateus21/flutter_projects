import 'package:flutter/material.dart';

class TelaContato extends StatefulWidget {
  @override
  _TelaContato createState() => _TelaContato();
}

class _TelaContato extends State<TelaContato> {
  void _abrirEmpresa() {

  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Serviço"),
        backgroundColor: Colors.green,
      ),

      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Image.asset("images/detalhe_contato.png"),
                  Text(
                    "Contato",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("atendimento@atmconsultoria.com.br"),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Text("Telefone: (85) 98121-0595"),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Text("Celular: (85) 98121-0595"),
            )
            
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class TelaServico extends StatefulWidget {
  @override
  _TelaServico createState() => _TelaServico();
}

class _TelaServico extends State<TelaServico> {
  
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Image.asset("images/detalhe_servico.png"),
                  Text(
                    "Nossos Serviços",
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
              child: Text("Consultoria"),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
              child: Text("Preços"),
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Acompanhamento de Projetos"),
            )
            
          ],
        ),
      ),
    );
  }
}
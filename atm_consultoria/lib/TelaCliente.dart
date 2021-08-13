import 'package:flutter/material.dart';

class TelaCliente extends StatefulWidget {
  @override
  _TelaCliente createState() => _TelaCliente();
}

class _TelaCliente extends State<TelaCliente> {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Cliente"),
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
                  Image.asset("images/detalhe_cliente.png"),
                  Text(
                    "Clientes",
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
              child: Image.asset("images/cliente1.png"),
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Empresa de Software"),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Image.asset("images/cliente2.png"),
            ),
            
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Empresa de Auditoria"),
            ),
          ],
        ),
      ),
    );
  }
}
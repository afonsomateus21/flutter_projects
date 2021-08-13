import 'package:flutter/material.dart';

class TelaEmpresa extends StatefulWidget {
  @override
  _TelaEmpresa createState() => _TelaEmpresa();
}

class _TelaEmpresa extends State<TelaEmpresa> {
  void _abrirEmpresa() {

  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Empresa"),
        backgroundColor: Colors.green,
      ),

      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Image.asset("images/detalhe_empresa.png"),
                  Text(
                    "Sobre a empresa",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),

            Text(
              "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.",
              style: TextStyle(
                fontSize: 15
              ),
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }
}
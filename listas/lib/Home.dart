import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override 
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _itens = [];

  void _carregarItens() {
    _itens = [];
    for (int i=0; i < 10; i++) {
      Map<String, dynamic> item = Map();
      item["titulo"] = "Título referente ao valor ${i}";
      item["descricao"] = "Descrição referente ao item ${i}";

      _itens.add(item);
    }
  }

  @override 
  Widget build(BuildContext context) {
    _carregarItens();

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista")
      ),

      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: _itens.length,
          itemBuilder: (context, index) {
            
            // print("item ${}");
            return ListTile(
              onTap: () => {
                // print("clicou ${index}")
                showDialog(
                  context: context, 
                  builder: (context) {
                    return AlertDialog(
                      title: Text(_itens[index]["titulo"]),
                      content: Text(_itens[index]["descricao"]),
                      titlePadding: EdgeInsets.all(20),
                      titleTextStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.orange
                      ),
                      actions: [
                        FlatButton(
                          onPressed: () => {Navigator.pop(context)},
                          child: Text("Sim"),
                        ),

                        FlatButton(
                          onPressed: () => {Navigator.pop(context)},
                          child: Text("Não"),
                        )
                      ],
                    );
                  }
                )
              },
              // onLongPress: () => {
              //   print("segurou")
              // },
              title: Text(_itens[index]["titulo"]),
              subtitle: Text(_itens[index]["descricao"]),
            );
          }
        ),
      ),
    );
  }
}
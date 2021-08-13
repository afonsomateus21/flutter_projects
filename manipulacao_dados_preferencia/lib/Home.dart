import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override 
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _fieldController = TextEditingController();
  String _textSaved = "Nada salvo";

  _save() async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString("nome", _fieldController.text);
  }

  _read() async {
    final preferences = await SharedPreferences.getInstance();

    setState(() {
      _textSaved = preferences.getString("nome") ?? "Sem valor";
    });
  }

  _remove() async {
    final preferences = await SharedPreferences.getInstance();

    preferences.remove("nome");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manipulação de dados"),
      ),

      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Text(
              _textSaved,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),

            TextField(
              decoration: InputDecoration(
                labelText: "Digite algo"
              ),
              controller: _fieldController,
            ),

            Row(
              children: [
                ElevatedButton(
                  onPressed: _save, 
                  child: Text(
                    "Salvar",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: ElevatedButton(
                    onPressed: _read, 
                    child: Text(
                      "Ler",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: ElevatedButton(
                    onPressed: _remove, 
                    child: Text(
                      "Remover",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class Home extends StatefulWidget {
  @override 
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _toDoList = [];
  TextEditingController _toDoController = TextEditingController();
  
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    var file = File("${directory.path}/lista_tarefas.json");

    return file;
  }

  _saveFile() async {
    var file = await _getFile();
    String data = json.encode(_toDoList);

    file.writeAsString(data);
  }

  _readFile() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    
    } catch(error) {
      return null;
    }
  }

  _saveToDo() {
    Map<String, dynamic> toDo = Map();
    toDo["title"] = _toDoController.text;
    toDo["done"] = false;

    setState(() {
      _toDoList.add(toDo);
    });

    _saveFile();

    _toDoController.text = "";
  }

  Widget _createListItem(context, index) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: EdgeInsets.all(16),
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete,
              color: Colors.white,
            )
          ],
        ),
      ),
      onDismissed: (direction) {
        Map<String, dynamic> item = _toDoList[index];

        setState(() {
          _toDoList.removeAt(index);
        });

        _saveFile();

        final snackBar = SnackBar(
          content: Text("Tarefa removida!"),
          action: SnackBarAction(
            label: "Desfazer", 
            onPressed: () {
              setState(() {
                _toDoList.insert(index, item);
              });
            }
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }, 
      child: CheckboxListTile(
        title: Text(_toDoList[index]['title']),
        value: _toDoList[index]['done'],
        onChanged: (value) {
          setState(() {
            _toDoList[index]['done'] = value;
          });

          _saveFile();
        },
      )
    );
  }

  @override
  void initState() {
    super.initState();

    _readFile().then((data) {
      setState(() {
        _toDoList = json.decode(data);
      });
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.purple,
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _toDoList.length,
              itemBuilder: _createListItem
            )
          ),
        ] 
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked, 

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.purple,
        label: Text("Adicionar tarefa"),
        icon: Icon(Icons.add),
        elevation: 8,
        onPressed: () => {
          showDialog(
            context: context, 
            builder: (context) => AlertDialog(
              title: Text("Adicionar Tarefa"),
              content: TextField(
                decoration: InputDecoration(
                  labelText: "Digite sua tarefa",
                ),
                onChanged: (text) {
                  
                },
                controller: _toDoController,
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context), 
                  child: Text("Cancelar")
                ),

                ElevatedButton(
                  onPressed: () {
                    _saveToDo();
                    Navigator.pop(context);
                  }, 
                  child: Text("Salvar")
                )
              ]
            )
          )
        },
      ),
    );
  }
}
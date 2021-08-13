import 'package:flutter/material.dart';
import 'package:my_notes/helper/NoteHelper.dart';
import 'package:my_notes/model/Note.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


class Home extends StatefulWidget {
  @override 
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _noteTitleController = TextEditingController();
  TextEditingController _noteDescriptionController = TextEditingController();
  NoteHelper _database = NoteHelper();
  List<Note> _notes = [];

  _saveOrUpdateNote({Note selectedNote}) async {
    Note note = Note(_noteTitleController.text, _noteDescriptionController.text, DateTime.now().toString());

    if (selectedNote == null) {
      int id = await _database.saveNote(note);
    } else {
      selectedNote.title = _noteTitleController.text;
      selectedNote.description = _noteDescriptionController.text;
      selectedNote.date = DateTime.now().toString();
      int updated = await _database.updateNote(selectedNote);
    }
    
    _noteTitleController.clear();
    _noteDescriptionController.clear();

    _listNotes();
  }

  _listNotes() async {
    List notes = await _database.listNotes();
    
    List<Note> temporaryList = [];
    
    notes.forEach((noteItem) {
      Note note = Note.fromMap(noteItem);
      temporaryList.add(note);
    });

    setState(() {
      _notes = temporaryList;
    });

    temporaryList = null;
  }

  _removeNote(int id) async {
    int idDeleted = await _database.removeNote(id);

    _listNotes();
  }

  _formatDate(String date) {
    initializeDateFormatting('pt_BR');

    var format = DateFormat("d/M/y H:m:s");

    return format.format(DateTime.parse(date));
  }

  @override 
  void initState() {
    super.initState();
    _listNotes();
  }

  _showRegisterScreen({ Note note }) {
    String text = "";

    if (note == null) {
      _noteTitleController.text = "";
      _noteDescriptionController.text = "";
      text = "Salvar";
    } else {
      _noteTitleController.text = note.title;
      _noteDescriptionController.text = note.description;
      text = "Atualizar";
    }

    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text("$text Anotação"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _noteTitleController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Título",
                  hintText: "Digite o título..."
                ),
              ),

              TextField(
                controller: _noteDescriptionController,
                decoration: InputDecoration(
                  labelText: "Descrição",
                  hintText: "Digite a descrição..."
                ),
              )
            ]
          ),

          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context), 
              child: Text(
                "Cancelar",
                style: TextStyle(
                  color: Colors.blue
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                elevation: MaterialStateProperty.resolveWith<double>(  // As you said you dont need elevation. I'm returning 0 in both case
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return 0;
                    }
                    return 0; // Defer to the widget's default.
                  },
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                _saveOrUpdateNote(selectedNote: note);
                Navigator.pop(context);
              }, 
              child: Text(
                "$text",
                style: TextStyle(
                  color: Colors.blue
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                elevation: MaterialStateProperty.resolveWith<double>(  // As you said you dont need elevation. I'm returning 0 in both case
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return 0;
                    }
                    return 0; // Defer to the widget's default.
                  },
                ),
              ),
            )
          ],
        );
      }
    );
  }

  _showDeleteScreen(int id) {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text("Deseja remover a anotação?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: Text("Cancelar")
            ),

            TextButton(
              onPressed: () {
                _removeNote(id);
                Navigator.pop(context);
              }, 
              child: Text("Remover")
            ),
          ],
        );
      }
    );
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Anotações"),
        backgroundColor: Colors.green,
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return Card(
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text("${_formatDate(note.date)} - ${note.description}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showRegisterScreen(note: note);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Icon(
                              Icons.edit, 
                              color: Colors.green
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            _showDeleteScreen(note.id);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 0),
                            child: Icon(
                              Icons.remove_circle, 
                              color: Colors.red
                            ),
                          ),
                        )
                      ]
                    ),
                  ),
                );
              }
            ),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showRegisterScreen();
        }, 
        label: Text("Adicionar Anotação"),
        backgroundColor: Colors.green,
        icon: Icon(Icons.add),
      ),
    );
  }
}
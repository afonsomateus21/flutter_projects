import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
    Future<Database> _getConecction() async {
    final databasePath = await getDatabasesPath();
    final databaseName = join(databasePath, "banco.db");

    var database = openDatabase(
      databaseName,
      version: 1,
      onCreate: (db, recentVersion) {
        String sql = "CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR, age INTEGER)";
        db.execute(sql);
      }
    );

    return database;
  }

  _save() async {
    Database database = await _getConecction();

    Map<String, dynamic> userData = {
      "name": "Evandir Rodrigo",
      "age": 33
    };

    int userId = await database.insert("users", userData);

    print(userId);
  }

  _listUsers() async {
    Database database = await _getConecction();

    String sql = "SELECT * FROM users";
    List users = await database.rawQuery(sql);

    print(users.toString());
  }

  _searchByName(String name) async {
    Database database = await _getConecction();

    String sql = "SELECT * FROM users WHERE name LIKE '$name%'";
    List user = await database.rawQuery(sql);

    print(user.toString());
  }

  _updateUser() async {
    Database database = await _getConecction();

    String sql = "UPDATE users SET name='Matheus Anselmo', age=22 WHERE id=2";
    int rowsUpdated = await database.rawUpdate(sql);

    print(rowsUpdated);
  }

  _deleteUser() async {
    Database database = await _getConecction();
    
    int rowsUpdated = await database.delete("users", where: "id=?", whereArgs: [2]);

    print(rowsUpdated);
  }

  @override 
  Widget build(BuildContext context) {
    // _save();
    _listUsers();
    // _searchByName("Evandir");
    // _updateUser();
    // _deleteUser();
    return Scaffold(

    );
  }
}
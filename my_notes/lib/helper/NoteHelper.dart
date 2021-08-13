import 'package:my_notes/model/Note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NoteHelper {
  static final NoteHelper _connection = NoteHelper._internal();
  static final String tableName = "notes";
  Database _database;
  
  factory NoteHelper() {
    return _connection;
  }

  NoteHelper._internal() {}

  get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await databaseInitializer();
      return _database;
    }
  }

  _onCreate(Database database, int version) async {
    String sql = "CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, title VARCHAR, description TEXT, date DATETIME)";
    database.execute(sql);
  }

  Future<Database> databaseInitializer() async {
    final databasePath = await getDatabasesPath();
    final databaseLocation = join(databasePath, "my_notes.db");

    var database = await openDatabase(
      databaseLocation,
      version: 1,
      onCreate: _onCreate
    );

    return database;
  }

  Future<int> saveNote(Note note) async {
    var database = await databaseInitializer();
    int id = await database.insert(tableName, note.toMap());

    return id;
  }

  listNotes() async {
    var database = await databaseInitializer();
    String sql = "SELECT * FROM $tableName ORDER BY date DESC";
    List notes = await database.rawQuery(sql);

    return notes;
  }

  Future<int> updateNote(Note note) async {
    var database = await databaseInitializer();
    int id = await database.update(
      tableName, 
      note.toMap(),
      where: "id = ?",
      whereArgs: [note.id]
    );

    return id;
  }

  Future<int> removeNote(int id) async {
    var database = await databaseInitializer();
    
    int idDeleted = await database.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id]
    );

    return idDeleted;
  }
}


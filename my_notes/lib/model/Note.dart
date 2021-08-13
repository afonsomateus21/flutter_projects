class Note {
  int _id;
  String _title;
  String _description;
  String _date;

  Note(this._title, this._description, this._date);

  Note.fromMap(Map map) {
    this._id = map["id"];
    this._title = map["title"];
    this._description = map["description"];
    this._date = map["date"];
  }

  Map toMap() {
    Map<String, dynamic> note = {
      "title": this._title,
      "description": this._description,
      "date": this._date
    };

    if (this._id != null) {
      note["id"] = this._id;
    }

    return note;
  }

  int get id => this._id;

  String get title => this._title;

  String get description => this._description;

  String get date => this._date;

  set id(int id) {
    this._id = id;
  }

  set title(String title) {
    this._title = title;
  }

  set description(String description) {
    this._description = description;
  }

  set date(String date) {
    this._date = date;
  }
}
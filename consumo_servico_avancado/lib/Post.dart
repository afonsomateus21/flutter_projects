class Post {
  int _userId;
  int _id;
  String _title;
  String _body;

  Post(this._userId, this._id, this._title, this._body);

  int get userId => _userId;

  int get id => _id;

  String get title => _title;

  String get body => _body;

  set userId(int userId) {
    this._userId = _userId;
  }

  set id(int Id) {
    this._id = _id;
  }

  set title(String title) {
    this._title = title;
  }

  set body(String body) {
    this._body = body;
  }
}
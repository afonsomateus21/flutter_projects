class UserChat {
  String _name;
  String _message;
  String _photoPath;

  UserChat(this._name, this._message, this._photoPath);

  String get name => this._name;

  String get message => this._message;

  String get photoPath => this._photoPath;

  set name(String name) {
    this._name = name;
  }

  set message(String message) {
    this._message = message;
  }

  set photoPath(String photoPath) {
    this._photoPath = photoPath;
  }
}
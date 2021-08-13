class User {
  String _userId;
  String _name;
  String _email;
  String _password;
  String _imageUrl;

  User();

  String get userId => this._userId;

  String get name => this._name;

  String get email => this._email;

  String get password => this._password;

  String get imageUrl => this._imageUrl;

  set userId(String userId) {
    this._userId = userId;
  }

  set name(String name) {
    this._name = name;
  }

  set email(String email) {
    this._email = email;
  }

  set password(String password) {
    this._password = password;
  }

  set imageUrl(String imageUrl) {
    this._imageUrl = imageUrl;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "name": this._name,
      "email": this._email,
    };

    return map;
  }
}
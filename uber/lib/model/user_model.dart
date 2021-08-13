class UserModel {
  String _userId;
  String _username;
  String _userEmail;
  String _password;
  String _userKind;

  UserModel();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "username": _username,
      "email": _userEmail,
      "kindOfUser": _userKind
    };

    return map;
  }

  String get userId => this._userId;

  String get username => this._username;

  String get userEmail => this._userEmail;

  String get password => this._password;

  String get userKind => this._userKind;

  set userId(String userId) {
    this._userId = userId;
  }

  set username(String username) {
    this._username = username;
  }

  set userEmail(String userEmail) {
    this._userEmail = userEmail;
  }

  set password(String password) {
    this._password = password;
  }

  set userKind(String userKind) {
    this._userKind = userKind;
  }
}
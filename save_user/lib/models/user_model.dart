class User {
  String _email;
  String _password;
  bool _logged;

  User();

  String get email => this._email;

  String get password => this._password;

  bool get logged => this._logged;

  set email(String email) {
    this._email = email;
  }

  set password(String password) {
    this._password = password;
  }

  set logged(bool logged) {
    this._logged = logged;
  }
}
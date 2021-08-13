class Destination {
  String _street;
  String _number;
  String _city;
  String _neighborhood;
  String _cep;
  double _latitude;
  double _longitude;

  Destination();

  String get street => this._street;

  String get number => this._number;

  String get city => this._city;

  String get neighborhood => this._neighborhood;

  String get cep => this._cep;

  double get latitude => this._latitude;

  double get longitude => this._longitude;

  set street(String street) {
    this._street = street;
  }

  set number(String number) {
    this._number = number;
  }

  set city(String city) {
    this._city = city;
  }

  set neighborhood(String neighborhood) {
    this._neighborhood = neighborhood;
  }

  set cep(String cep) {
    this._cep = cep;
  }

  set latitude(double latitude) {
    this._latitude = latitude;
  }

  set longitude(double longitude) {
    this._longitude = longitude;
  }
}
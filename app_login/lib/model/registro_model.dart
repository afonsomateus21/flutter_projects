class RegisterResponseModel {
  final int id;
  final String token;
  final String error;

  RegisterResponseModel({this.id, this.token, this.error});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    // return RegisterResponseModel(id: json["id"] != null ? json["id"] : null , token: json["token"] != null ? json["token"] : "");
    return RegisterResponseModel(
      id: json["id"] != null ? json["id"] : null , 
      token: json["token"] != null ? json["token"] : "",
      error: json["error"] != null ? json["error"] : "");
  }
}

class RegisterRequestModel {
  String email;
  String senha;

  RegisterRequestModel({this.email, this.senha});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': senha.trim()
    };

    return map;
  } 
}
import 'package:app_login/model/login_model.dart';
import 'package:app_login/model/registro_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String _baseURL = "https://reqres.in/api";

class ApiService {
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    var url = Uri.parse(_baseURL + "/login");

    final response = await http.post(url, body: loginRequestModel.toJson());

    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao carregar dados.');
    }
  }

  Future<RegisterResponseModel> cadastrar(RegisterRequestModel registerRequestModel) async {
    var url = Uri.parse(_baseURL + "/register");

    final response = await http.post(url, body: registerRequestModel.toJson());

    if (response.statusCode == 200 || response.statusCode == 400) {
      return RegisterResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao carregar dados.');
    }
  }
}
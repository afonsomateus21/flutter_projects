import 'package:app_login/screens/Cadastro.dart';
import 'package:app_login/api/ApiService.dart';
import 'package:app_login/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  LoginRequestModel _loginRequestModel;
  bool _carregando = false;
  String _mensagemLogado = "";
  
  bool validarEmail() {
    if (_emailController.text.contains("@")) {
      return true;
    }

    return false;
  }

  Future<String> _hashSenha() async {
    String senha = await FlutterBcrypt.hashPw(password: _senhaController.text, salt: r'$2b$06$C6UzMDM.H6dfI/f/IKxGhu');

    return senha;
  }

  Widget _mostrarCarregando() {
    if (_carregando) {
      return Center(
        child: CircularProgressIndicator()
      );
    }

    return null;
  }

  _telaStatusLogado(String erro) {
    String mensagemCadastro = erro == "" ? "Usuário logado com sucesso!" : erro;

    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text(mensagemCadastro),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: Text("Ok")
            )
          ],
        );
      }
    );
  }

  _login() async {
    if (validarEmail()) {
      String senha = await _hashSenha();
      _loginRequestModel = LoginRequestModel(email: _emailController.text, senha: senha);
      
      ApiService apiService = ApiService();

      print(_loginRequestModel.toJson().toString());
      
      apiService.login(_loginRequestModel).then((value) {
        setState(() {
          this._carregando = false;
        });

        _telaStatusLogado(value.error);

        print(value.token);
        print(value.error);
      });
    }

    _emailController.clear();
    _senhaController.clear();
  }

  @override
  void initState() {
    super.initState();
    _loginRequestModel = LoginRequestModel();
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Color(0xff1dc690),
      ),
      
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Text(
                    "Bem-vindo!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
              ),
              
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: TextField(
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Digite seu email...",
                    hintStyle: TextStyle(
                      color: Colors.white
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(32)
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: TextField(
                  obscureText: true,
                  controller: _senhaController,
                  decoration: InputDecoration(
                    hintText: "Digite sua senha...",
                    hintStyle: TextStyle(
                      color: Colors.white
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(32)
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    this._carregando = true;
                  });
                  _login();
                }, 
                child: Text(
                  "Entrar",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color(0xff1dc690)
                  ),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.fromLTRB(20, 15, 20, 15)
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  )
                ),
              ),

              if (_carregando) _mostrarCarregando(),

              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => Cadastro()
                        )
                      );
                    },
                    child: Text(
                      "Não tem uma conta? Cadastre-se",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                )
              )
            ]
          ),
        ),
      ),
    );
  }
}
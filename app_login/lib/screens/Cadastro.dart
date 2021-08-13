import 'package:app_login/api/ApiService.dart';
import 'package:app_login/model/registro_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  RegisterRequestModel _registerRequestModel;
  String _mensagemErro = '';
  bool _carregando = false;
  
  @override
  void initState() {
    super.initState();
    _registerRequestModel = RegisterRequestModel();
  }

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

  _telaStatusCadastro(String erro) {
    String mensagemCadastro = erro == "" ? "Usuário cadastrado com sucesso!" : erro;

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

  _cadastrar() async {
    if (validarEmail()) {
      String senha = await _hashSenha();
      _registerRequestModel = RegisterRequestModel(email: _emailController.text, senha: senha);
      
      ApiService apiService = ApiService();

      print(_registerRequestModel.toJson().toString());

      apiService.cadastrar(_registerRequestModel).then((value) {
        setState(() {
          this._carregando = false;
        });

        _telaStatusCadastro(value.error);
        print(value.id);
        print(value.token);
        print(value.error);
      });
    }
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cadastre-se",
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
                    "Crie já sua conta!",
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
                  // _mostrarCarregando();
                  _cadastrar();
                }, 
                child: Text(
                  "Cadastrar",
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

              /*_carregando ?
              Center (
                child: CircularProgressIndicator(),
              ) :
              Center (
                child: Text(
                  _mensagem,
                  style: TextStyle(
                    color: Colors.white
                  )
                ),
              ),*/

              if (_carregando) _mostrarCarregando(),

              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      _mensagemErro,
                      style: TextStyle(
                        color: Colors.red,
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
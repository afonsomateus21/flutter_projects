import 'package:flutter/material.dart';
import 'package:whatsapp/Home.dart';
import 'package:whatsapp/Register.dart';
import 'package:whatsapp/RouteGenerator.dart';
import 'package:whatsapp/model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override 
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  _validateFields() {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (password.isNotEmpty) {
        setState(() {
          this._errorMessage = "";
        });
        
        User user = User();
        user.email = email;
        user.password = password;

        _loginUser(user);
      } else {
        setState(() {
          this._errorMessage = "Preencha a senha!";
        });
      }
    } else {
      setState(() {
        this._errorMessage = "Preencha o email!";
      });
    }
  }

  _loginUser(User user) {
    FirebaseAuth auth = FirebaseAuth.instance;
    
    auth.signInWithEmailAndPassword(
      email: user.email, 
      password: user.password
    ).then((firebaseUser) {
      Navigator.pushReplacementNamed(context, RouteGenerator.HOME_ROUTE);
    }).catchError((error) {
      setState(() {
        _errorMessage = "Erro ao autenticar usuário! Verifique email e senha e tente novamente";
      });
    });
  }

  Future _verifyLoggedUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    // auth.signOut();

    FirebaseUser loggedUser = await auth.currentUser();
    if (loggedUser != null) {
      Navigator.pushReplacementNamed(context, RouteGenerator.HOME_ROUTE);
    }
  }

  @override
  void initState() {
    _verifyLoggedUser();
    super.initState();
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xff075E54)
        ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset("images/logo.png", width: 200, height: 150),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "E-mail",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)
                      )
                    ),
                    controller: _emailController,
                  ),
                ),

                TextField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  style: TextStyle(
                    fontSize: 20
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "Senha",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)
                    )
                  ),
                  controller: _passwordController
                ),

                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      _validateFields();
                    }, 
                    child: Text(
                      "Entrar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(32, 16, 32, 16)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)))
                    ),
                  ),
                ),

                Center(
                  child: GestureDetector(
                    child: Text(
                      "Não tem conta? Cadastre-se",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => Register())
                      );
                    },
                  )
                ),

                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      _errorMessage,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
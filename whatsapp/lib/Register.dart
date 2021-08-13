import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/Home.dart';
import 'package:whatsapp/RouteGenerator.dart';
import 'package:whatsapp/model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  @override 
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  _validateFields() {
    String name = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    if (name.isNotEmpty) {
      if (email.isNotEmpty && email.contains("@")) {
        if (password.isNotEmpty && password.length > 6) {
          setState(() {
            this._errorMessage = "";
          });
          
          User user = User();
          user.name = name;
          user.email = email;
          user.password = password;

          _registerUser(user);
        } else {
          setState(() {
            this._errorMessage = "Senha inválida!";
          });
        }
      } else {
        setState(() {
          this._errorMessage = "Email inválido!";
        });
      }
    } else {
      setState(() {
        this._errorMessage = "Preencha o nome";
      });
    }
  }

  _registerUser(User user) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.createUserWithEmailAndPassword(
      email: user.email, 
      password: user.password
    ).then((firebaseUser) {
      Firestore db = Firestore.instance;
      
      db.collection("users")
      .document(firebaseUser.uid)
      .setData(user.toMap());

      Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.HOME_ROUTE, (_) => false);
    }).catchError((error) {
      setState(() {
        this._errorMessage = "Erro ao cadastrar o usuário! Verifique os campos e tente novamente.";
      });
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro")
      ),

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
                  child: Image.asset("images/usuario.png", width: 200, height: 150),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Nome",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)
                      )
                    ),
                    controller: _usernameController
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
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
                    controller: _emailController
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
                  controller: _passwordController,
                ),

                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      _validateFields();
                    }, 
                    child: Text(
                      "Cadastrar",
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
                  child: Text(
                    _errorMessage,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20
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
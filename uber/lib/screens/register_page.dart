import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber/model/user_model.dart';
import 'package:uber/route_generator.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _kindOfUser = false;
  String _errorMessage = "";

  _validateFields() {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    if (name.isNotEmpty) {
      if (email.isNotEmpty && email.contains('@'))  {
        if (password.isNotEmpty) {
          UserModel user = UserModel();

          user.username = name;
          user.userEmail = email;
          user.password = password;
          user.userKind = _kindOfUser ? "driver" : "passenger";

          _registerUser(user);
        } else {
          setState(() {
          _errorMessage = "Preencha a senha";
      });
        }
      } else {
          setState(() {
          _errorMessage = "Preencha o email";
      });
      }
    } else {
      setState(() {
        _errorMessage = "Preencha o nome";
      });
    }
  }

  _registerUser(UserModel user) {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    auth.createUserWithEmailAndPassword(
      email: user.userEmail, 
      password: user.password
    ).then((firebaseUser) {
      db.collection("users")
        .doc(firebaseUser.user.uid)
        .set(user.toMap());

      if (user.userKind == "passenger") {
        Navigator.pushNamedAndRemoveUntil(
          context, 
          RouteGenerator.PASSENGER_ROUTE,
          (_) => false
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context, 
          RouteGenerator.DRIVER_ROUTE,
          (_) => false
        );
      }
    }).catchError((error) {
      setState(() {
        _errorMessage = "Erro ao autenticar o usuário"; 
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
        backgroundColor: Colors.black,
      ),

      body: Container(
        padding: EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  autofocus: true,
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Nome",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2)
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2)
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: TextField(
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2)
                      ),
                    ),
                  )
                ),

                Padding(
                  padding: EdgeInsets.only(top: 2, bottom: 2),
                  child: TextField(
                    autofocus: true,
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: "Senha",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2)
                      ),
                    ),
                  )
                ),

                Row(
                  children: [
                    Text(
                      "Passageiro"
                    ),
                    Switch(
                      value: _kindOfUser, 
                      onChanged: (value) {
                        setState(() {
                          this._kindOfUser = value;
                        });
                      },
                      activeColor: Color(0xff1ebbd8),
                    ),
                    Text(
                      "Motorista"
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      _validateFields();
                    },
                    child: Text(
                      "Cadastrar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xff1ebbd8)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(15))
                    ),
                  ),
                ),

                Text(
                  _errorMessage,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red 
                  )
                )
              ]
            ),
          )
        ),
      ),
    );
  }
}
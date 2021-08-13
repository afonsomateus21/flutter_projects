import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber/model/user_model.dart';
import 'package:uber/route_generator.dart';
import 'package:uber/screens/register_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _errorMessage = "";
  bool _loading = false;


  _redirectByKindOfUser(String userId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentSnapshot snapshot = await db.collection("users")
      .doc(userId)
      .get();

    Map<String, dynamic> data = snapshot.data();
    String kindOfUser = data["kindOfUser"];

    setState(() {
      _loading = false;
    });

    switch(kindOfUser) {
      case "passenger":
        Navigator.pushReplacementNamed(context, RouteGenerator.PASSENGER_ROUTE);
        break;
      
      case "driver":
        Navigator.pushReplacementNamed(context, RouteGenerator.DRIVER_ROUTE);
        break;
    }
  }

  _login(UserModel user) {
    setState(() {
      _loading = true;
    });
        
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
      email: user.userEmail, 
      password: user.password
    ).then((firebaseUsuer) {
      // Navigator.pushReplacementNamed(context, RouteGenerator.PASSENGER_ROUTE);
      _redirectByKindOfUser(firebaseUsuer.user.uid);
    }).catchError((error) {
      _errorMessage = "Erro ao autenticar o usuário"; 
    });
  }

  _validateFields() {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isNotEmpty && email.contains('@'))  {
      if (password.isNotEmpty) {
        UserModel user = UserModel();

        user.userEmail = email;
        user.password = password;

        _login(user);
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
  } 

  _verifyLoggedUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    var loggedUser = auth.currentUser; 

    if (loggedUser != null) {
      String userId = loggedUser.uid;
      _redirectByKindOfUser(userId);
    }
  }

  @override
  void initState() {
    super.initState();
    _verifyLoggedUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/fundo.png"),
            fit: BoxFit.cover
          )
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Image(
                    image: AssetImage("images/logo.png"),
                    width: 150,
                    height: 150,
                  ),
                ),

                TextField(
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
                ),

                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: TextField(
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
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

                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      _validateFields();
                    },
                    child: Text(
                      "Entrar",
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

                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (_) => Register()
                        )
                      );
                    },
                    child: Text(
                      "Não tem conta? Cadastre-se",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  )
                ),

                _loading 
                ? Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Center(
                      widthFactor: 40,
                      child: CircularProgressIndicator(backgroundColor: Colors.white,)
                    ),
                  )
                : Container(),

                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(
                      color: Colors.red
                    ),
                  )
                )
              ],
            ),
          )
        )
      ),
    );
  }
}
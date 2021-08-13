import 'package:dbcrypt/dbcrypt.dart';
import 'package:flutter/material.dart';
import 'package:save_user/route_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginFields extends StatefulWidget {
  @override 
  _LoginFieldsState createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  Future<SharedPreferences> _preferences = SharedPreferences.getInstance();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  _login() async {
    final preferences = await SharedPreferences.getInstance();
    String userEmail = preferences.getString("userEmail");
    String userPassword = preferences.getString("userPassword");

    // print(userEmail);
    // print(userPassword);

    bool isCorrect = DBCrypt().checkpw(_passwordController.text, userPassword);

    if (userEmail == _emailController.text && isCorrect) {
      preferences.setBool("logged", true);
      Navigator.pushReplacementNamed(
        context, 
        RouteGenerator.HOME_PAGE
      );
    }
  }

  _getLoggedStatus() async {
    final preferences = await SharedPreferences.getInstance();

    // print(preferences.getBool("logged"));

    if (preferences.getBool("logged")) {
      Navigator.pushReplacementNamed(
        context, 
        RouteGenerator.HOME_PAGE
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getLoggedStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Bem Vindo",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),

          TextField(
            cursorColor: Color(0xff1dc690),
            style: TextStyle(color: Colors.white),
            autofocus: true,
            controller: _emailController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff1dc690))
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff1dc690))
              ),
              hintStyle: TextStyle(color: Colors.black),
              hintText: "Digite seu email",
            ),
            keyboardType: TextInputType.emailAddress,
          ),

          Padding(
            padding: EdgeInsets.only(top: 5),
            child: TextField(
              cursorColor: Color(0xff1dc690),
              style: TextStyle(
                color: Colors.white,
              ),
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff1dc690))
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff1dc690))
                ),
                hintStyle: TextStyle(color: Colors.black),
                hintText: "Digite sua senha",
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 5),
            child: ElevatedButton(
                onPressed: () {
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
          ),

          Padding(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context, 
                    RouteGenerator.REGISTER_PAGE
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
              )
            ),
          )
        ]
      ),
    );
  }
}
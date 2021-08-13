import 'package:flutter/material.dart';
import 'package:save_user/route_generator.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterFields extends StatefulWidget {
  @override 
  _RegisterFieldsState createState() => _RegisterFieldsState();
}

class _RegisterFieldsState extends State<RegisterFields> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Future<SharedPreferences> _preferences = SharedPreferences.getInstance();

  Future<void> _registerUser() async {
    final preferences = await SharedPreferences.getInstance();

    String password = _passwordController.text;
    var hashedPassword = DBCrypt().hashpw(password, DBCrypt().gensalt());

    print(hashedPassword);
    
    preferences.setString("userEmail", _emailController.text);
    preferences.setString("userPassword", hashedPassword);
    preferences.setBool("logged", true);

    Navigator.pushReplacementNamed(
      context, 
      RouteGenerator.HOME_PAGE
    );
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
                "Cadastre-se",
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
                  _registerUser();
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
          ),

          Padding(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context, 
                    RouteGenerator.LOGIN_PAGE
                  );
                },
                child: Text(
                  "Voltar para o login",
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
import 'package:flutter/material.dart';
import 'package:primeiro_app_responsivo/pages/home/widgets/app_bar/web_app_bar_responsive_content.dart';

class WebAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      toolbarHeight: 72,
      title: Row(
        children: [
          Text("Flutter"),
          
          SizedBox(
            width: 32,
          ),

          WebAppBarResponsiveContent(),

          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {

          }),
          
          SizedBox(
            width: 24,
          ),
          
          SizedBox(
            height: 38,
            child: OutlinedButton(
              onPressed: () {

              }, 
              child: Text(
                "Fazer login",
                style: TextStyle(
                  color: Colors.white
                )
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.white)
              ),
            )
          ),

          SizedBox(
            width: 8
          ),

          SizedBox(
            height: 38,
            child: ElevatedButton(
              onPressed: () {}, 
              child: Text(
                "Cadastre-se",
                style: TextStyle(
                  color: Colors.black
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white)
              ),
            ),
          ),
        ]
      ),
    );
  }
}
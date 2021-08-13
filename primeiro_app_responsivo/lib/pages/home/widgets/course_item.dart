import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CourseItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.network(
          "https://i.picsum.photos/id/0/5616/3744.jpg?hmac=3GAAioiQziMGEtLbfrdbcoenXoWAW-zlyEAMkfEdBzQ",
          fit: BoxFit.fitWidth,
        ),

        SizedBox(height: 4),

        Flexible(
          child: AutoSizeText(
            "Criação de Apps Android e IOS com Flutter - Crie 16 Apps",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.white
            ),
          ),
        ),

        AutoSizeText(
          "Afonso Mateus",
          style: TextStyle(
            color: Colors.grey
          ),
        ),

        AutoSizeText(
          "R\$ 22,90",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Colors.white
          ),
        ),
      ],
    );
  }
}
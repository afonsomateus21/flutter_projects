import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SugestionItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(4, 5, 0, 5),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(
              "https://avatars.githubusercontent.com/u/18506682?s=400&u=6727f1a1a8097f804480c17ba9e258fb9bfbebc6&v=4"
            ),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "afonsomateus21",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
                Text(
                  "Afonso Mateus",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey
                  )
                )
              ]
            )
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {},
              child: Text(
                "Ligar",
                style: TextStyle(
                  color: Color(0xFF0396F6),
                  fontWeight: FontWeight.bold,
                  fontSize: 12
                )
              )
            )
          )
        ]
      ),
    );
  }
}
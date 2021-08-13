import 'package:flutter/material.dart';

class StoryCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 66,
          width: 66,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.blue
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft
            )
          ),
          alignment: Alignment.center,
          child: Container(
            height: 62,
            width: 62,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white
            ),
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 29,
              backgroundImage: NetworkImage("https://avatars.githubusercontent.com/u/18506682?s=400&u=6727f1a1a8097f804480c17ba9e258fb9bfbebc6&v=4")
            ),
          ),
        ),
        Text(
          "afonsomos21",
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w500
          ),
        )
      ],
    );
  }
}
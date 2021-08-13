import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_value.dart';

class ResponsiveMenuActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ResponsiveVisibility(
          visible: false,
          visibleWhen: [
            Condition.smallerThan(name: TABLET)
          ],
          child: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              
            },
          ),
        ),
        SizedBox(
          width: 4
        ),
        IconButton(
          icon: Icon(
            Icons.home,
            color: Colors.black,
          ),
          onPressed: () {
            
          },
        ),
        SizedBox(
          width: 4
        ),
        IconButton(
          icon: Icon(Icons.send_rounded, color: Colors.black,),
          onPressed: () {
            
          },
        ),
        SizedBox(
          width: 4
        ),
        IconButton(
          icon: Icon(Icons.favorite_border, color: Colors.black,),
          onPressed: () {
            
          },
        ),
        SizedBox(
          width: 16
        ),
        CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(
            "https://avatars.githubusercontent.com/u/18506682?s=400&u=6727f1a1a8097f804480c17ba9e258fb9bfbebc6&v=4"
          )
        )
      ]
    );
  }
}
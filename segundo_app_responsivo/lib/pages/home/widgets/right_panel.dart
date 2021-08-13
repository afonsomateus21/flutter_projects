import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:segundo_app_responsivo/pages/home/widgets/sugestion_item.dart';

class RightPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveVisibility(
      visible: false,
      visibleWhen: [
        Condition.largerThan(name: TABLET),
      ],
      child: Container(
        margin: EdgeInsets.fromLTRB(35, 56, 20, 0),
        width: 300,
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 29,
                  backgroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/18506682?s=400&u=6727f1a1a8097f804480c17ba9e258fb9bfbebc6&v=4"
                  ),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  width: 16
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "afonsomos21",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        )
                      ),
                      Text(
                        "Afonso Mateus",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey
                        ),
                      )
                    ]
                  )
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Sair',
                      style: TextStyle(
                        color: Color(0xFF0396F6),
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                      )
                    )
                  )
                )
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sugestões para você",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[500]
                  )
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Ver tudo",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      )
                    )
                  )
                )
              ]
            ),
            SizedBox(height: 8,),
            SugestionItem(),
            SugestionItem(),
            SugestionItem(),
          ],
        )
      ),
    );
  }
}
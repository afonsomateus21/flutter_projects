import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PostWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final desktop = ResponsiveWrapper.of(context).isDesktop;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: desktop ? 16 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 14, 14, 14),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage("https://avatars.githubusercontent.com/u/18506682?s=400&u=6727f1a1a8097f804480c17ba9e258fb9bfbebc6&v=4"),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  width: 16, 
                ),

                Expanded(
                  child: Text(
                    "afonsomos21",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                    )
                  ),
                ),

                GestureDetector(
                  child: Icon(
                    Icons.more_horiz_sharp,
                    color: Colors.black
                  )
                )
              ],
            )
          ),

          Image.network("https://avatars.githubusercontent.com/u/18506682?s=400&u=6727f1a1a8097f804480c17ba9e258fb9bfbebc6&v=4"),

          Padding(
            padding: EdgeInsets.all(4),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.favorite_border_rounded, color: Colors.black,), 
                  onPressed: () {}
                ),
                SizedBox(width: 4),
                IconButton(
                  icon: Icon(Icons.message_outlined, color: Colors.black,), 
                  onPressed: () {}
                ),
                SizedBox(width: 4),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.black,), 
                  onPressed: () {}
                ),
                SizedBox(width: 4),
                Expanded(child: Container()),
                IconButton(
                  icon: Icon(Icons.bookmark_border, color: Colors.black,), 
                  onPressed: () {}
                ),
              ],
            ),
          ),
          
          Padding(
            padding: EdgeInsets.only(left: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Curtido por leomessi e outras 500 pessoas'
                ),
                SizedBox(height: 8),
                Text(
                  'HÁ 1 HORA',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black
                  )
                )
              ],
            ),
          ),
          if (desktop) ... [
            Divider(color: Colors.white, height: 1,),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 20, 0, 24),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isCollapsed: true,
                        hintText: "Adicione um comentário...",
                        hintStyle: TextStyle(fontSize: 13, color: Colors.black)
                      ),
                    ),
                  )
                ),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(TextStyle(color: Colors.blue))
                  ),
                  child: Text("Publicar")
                )
              ],
            )
          ]
        ],
      ),
    );
  }
}
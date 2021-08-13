import 'package:flutter/material.dart';

class WebAppBarResponsiveContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.grey[600])
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 4,
                      ),

                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search),
                        color: Colors.grey[500],
                      ),

                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Digite o que deseja pesquisar...",
                            isCollapsed: true
                          )
                        )
                      )
                    ]
                  ),
                )
              ),

              if (constraints.maxWidth >= 400) ...[
                SizedBox(
                  width: 32
                ),
                
                TextButton(
                  onPressed: () {}, 
                  child: Text(
                    "Aprender",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  )
                ),
              ],
                
              if (constraints.maxWidth >= 500) 
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: TextButton(
                    onPressed: () {}, 
                    child: Text(
                      "Flutter",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )
                  ),
                ),
            ]
          );
        }
      ),
    );
  }
}
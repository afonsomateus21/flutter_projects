import 'package:flutter/material.dart';
import 'package:primeiro_app_responsivo/breakpoints.dart';
import 'package:primeiro_app_responsivo/pages/home/widgets/custom_search_field.dart';

class TopSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        if(maxWidth >= tabletBreakpoint) {
          return AspectRatio(
            aspectRatio: 3.2,
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 3.4,
                  child: Image.network(
                    "https://images.pexels.com/photos/892757/pexels-photo-892757.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  left: 50,
                  top: 50,
                  child: Card(
                    color: Colors.black,
                    elevation: 8,
                    child: Container(
                      width: 450,
                      padding: EdgeInsets.all(22),
                      child: Column(
                        children: [
                          Text(
                            "Aprenda Flutter com esse curso",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            )
                          ),

                          SizedBox(
                            height: 8
                          ),

                          Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white
                            ),
                          ),
                          
                          SizedBox(
                            height: 16
                          ),

                          CustomSearchField()
                        ]
                      )
                    )
                  )
                )
              ]
            )
          );
        }

        if (maxWidth >= mobileBreakpoint) {
          return SizedBox(
            height: 320,
            child: Stack(
              children: [
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Image.network(
                    "https://images.pexels.com/photos/892757/pexels-photo-892757.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  left: 20,
                  top: 20,
                  child: Card(
                    color: Colors.black,
                    elevation: 8,
                    child: Container(
                      width: 350,
                      padding: EdgeInsets.all(22),
                      child: Column(
                        children: [
                          Text(
                            "Aprenda Flutter com esse curso",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            )
                          ),

                          SizedBox(
                            height: 8
                          ),

                          Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white
                            ),
                          ),
                          
                          SizedBox(
                            height: 16
                          ),

                          CustomSearchField()
                        ]
                      )
                    )
                  ) 
                )
              ],
            ),
          );
        }

        return Column(
          children: [
            AspectRatio(
              aspectRatio: 3.4,
              child: Image.network(
                "https://images.pexels.com/photos/892757/pexels-photo-892757.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Aprenda Flutter com esse curso",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    )
                  ),

                  SizedBox(
                    height: 8
                  ),

                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white
                    ),
                  ),
                  
                  SizedBox(
                    height: 16
                  ),

                  CustomSearchField()
                ]
              ),
            )
          ],
        );
      },
    );
  }
}
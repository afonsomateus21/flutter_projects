import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override 
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: /*Container(
        // width: MediaQuery.of(context).size.width / 2,
        // height: MediaQuery.of(context).size.height / 2,
        child: MediaQuery.removeViewInsets(
          context: context, 
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(
                color: Colors.black
              )
            ),
          )
        ),
      )*/

        /*Container(
          child: Column(
            children: [
              Flexible(
                fit: FlexFit.loose, // não ignora o tamanho do container especificado
                // fit: FlexFit.tight ignora o tamanho do container especificado
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                )
              ),

              Flexible(
                fit: FlexFit.loose,
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                )
              )
            ]
          ),
        )*/

        SafeArea(
          child: Container(
          padding: EdgeInsets.all(10),
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              runSpacing: 10,
              spacing: 10,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                ),

                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                ),

                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                ),

                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                ),

                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                )
              ]
            )
          )
        )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:youtube/CustomSearchDelegate.dart';
import 'package:youtube/screens/Initial.dart';
import 'package:youtube/screens/Library.dart';
import 'package:youtube/screens/Popular.dart';
import 'package:youtube/screens/Subscriptions.dart';

class Home extends StatefulWidget {
  @override 
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  String _searchResult = "";

  @override 
  Widget build(BuildContext buildContext) {
    List<Widget> screens = [
      Initial(_searchResult),
      Popular(),
      Subscriptions(),
      Library()
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey,
          opacity: 1
        ),
        backgroundColor: Colors.white,
        title: Image.asset(
          "images/youtube.png",
          width: 98,
          height: 22,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam), 
            onPressed: () {}
          ),

           IconButton(
            icon: Icon(Icons.search), 
            onPressed: () async {
              String result = await showSearch(
                context: context, 
                delegate: CustomSearchDelegate()
              );

              setState(() {
                _searchResult = result;
              });
            }
          ),

           IconButton(
            icon: Icon(Icons.account_circle), 
            onPressed: () => {}
          )
        ],
      ),

      body: Container(
        padding: EdgeInsets.all(16),
        child: screens[_currentIndex],
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            // backgroundColor: Colors.orange,
            label: "Início",
            icon: Icon(Icons.home)
          ),
          
          BottomNavigationBarItem(
            // backgroundColor: Colors.red,
            label: "Em alta",
            icon: Icon(Icons.whatshot)
          ),

          BottomNavigationBarItem(
            // backgroundColor: Colors.green,
            label: "Inscrições",
            icon: Icon(Icons.subscriptions)
          ),

          BottomNavigationBarItem(
            // backgroundColor: Colors.blue,
            label: "Biblioteca",
            icon: Icon(Icons.folder)
          ),
        ]
      ),
    );
  }
}
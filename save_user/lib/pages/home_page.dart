import 'package:flutter/material.dart';
import 'package:save_user/breakpoints.dart';
import 'package:save_user/widgets/app_bar/home_mobile_app_bar.dart';
import 'package:save_user/widgets/app_bar/home_mobile_drawer.dart';
import 'package:save_user/widgets/app_bar/home_web_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override 
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<SharedPreferences> _preferences = SharedPreferences.getInstance();
  String _email = '';
  
  _getData() async {
    final preferences = await SharedPreferences.getInstance();

    setState(() {
      this._email = preferences.getString("userEmail");
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: constraints.maxWidth > mobileBreakpoint 
            ? PreferredSize(
              child: HomeWebAppBar(),
              preferredSize: Size(double.infinity, 72)
            )
            : PreferredSize(
                child: HomeMobileAppBar(), 
                preferredSize: Size(double.infinity, 56)
            ),

          drawer: constraints.maxWidth < mobileBreakpoint 
            ? HomeMobileDrawer()
            : null,

          body: Container(
            padding: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Text(
                    "Bem vindo $_email",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              )
            )
          ),
        );
      },
    );
  }
}
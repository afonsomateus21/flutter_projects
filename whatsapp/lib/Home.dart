import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/Login.dart';
import 'package:whatsapp/RouteGenerator.dart';
import 'package:whatsapp/screens/Chat.dart';
import 'package:whatsapp/screens/Contacts.dart';

class Home extends StatefulWidget {
  @override 
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> menuOptions = ["Configurações", "Sair"];
  String _email = "";

  @override
  void initState() {
    super.initState();

    _verifyLoggedUser();
    _getUserEmail();
    _tabController = TabController(
      length: 2,
      vsync: this
    );
  }

  Future _verifyLoggedUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    
    FirebaseUser loggedUser = await auth.currentUser();
    if (loggedUser == null) {
      Navigator.pushReplacementNamed(context, RouteGenerator.LOGIN_ROUTE);
    }
  }

  Future _getUserEmail() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser user = await auth.currentUser();

    setState(() {
      _email = user.email;
    });
  }

  _choiceMenuItem(String chosenItem) {
    switch(chosenItem) {
      case "Configurações":
        Navigator.pushNamed(context, RouteGenerator.SETTINGS_ROUTE);
        break;
      case "Sair":
        _logout();
        break;
    }
  }

  _logout() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    Navigator.pushReplacementNamed(context, RouteGenerator.LOGIN_ROUTE);
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Whatsapp"),
        bottom: TabBar(
          indicatorWeight: 4,
          labelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: "Conversas",),
            Tab(text: "Contatos",)
          ]
        ),
        actions: [
          PopupMenuButton(
            onSelected: _choiceMenuItem,
            icon: Icon(Icons.more_vert_rounded),
            itemBuilder: (context) {
              return menuOptions.map((String option) =>
                PopupMenuItem(
                  value: option,
                  child: Text(option), 
                )
              ).toList();
            }
          )
        ],
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          Chat(),
          Contacts() 
        ]
      )
    );
  }
}
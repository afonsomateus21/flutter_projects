import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/RouteGenerator.dart';
import 'package:whatsapp/model/User.dart';
import 'package:whatsapp/model/UserChat.dart';

class Contacts extends StatefulWidget {
  @override 
  _Contacts createState() => _Contacts();
}

class _Contacts extends State<Contacts> {
  String _loggedUserId;
  String _loggedUserEmail;

  Future<List<User>> _getContacts() async {
    Firestore db = Firestore.instance;

    QuerySnapshot querySnapshot = await db.collection("users").getDocuments();

    List<User> usersList = [];

    for (DocumentSnapshot item in querySnapshot.documents) {
      var data = item.data;

      if (data["email"] == _loggedUserEmail) continue;

      User user = User();
      user.userId = item.documentID;
      user.email = data["email"];
      user.name = data["name"];
      user.imageUrl = data["imageUrl"];

      usersList.add(user);
    }

    return usersList;
  }

  _getUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser loggedUser = await auth.currentUser();

    _loggedUserId = loggedUser.uid;
    _loggedUserEmail = loggedUser.email;
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override 
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: _getContacts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (_, index) {
              List<User> itensList = snapshot.data;
              User user = itensList[index];

              return ListTile(
                onTap: () {
                  Navigator.pushNamed(
                    context, 
                    RouteGenerator.MESSAGES_ROUTE,
                    arguments: user
                  );
                },
                contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                leading: CircleAvatar(
                  maxRadius: 30,
                  backgroundColor: Colors.grey,
                  backgroundImage: user.imageUrl != null 
                    ? NetworkImage(user.imageUrl)
                    : null
                ),
                title: Text(
                  user.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
              );
            },
          );
        } 

        else if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                Text("Erro ao carregar dados.")
              ],
            )
          );
        }

        else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Carregando contatos"),
                )
              ],
            )
          );
        }
      }
    );
  }
}
import 'package:flutter/material.dart';
import 'package:whatsapp/model/UserChat.dart';

class Chat extends StatefulWidget {
  @override 
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<UserChat> userChatList = [
    UserChat("Ana Clara", "Olá, tudo bem?", "https://firebasestorage.googleapis.com/v0/b/whatsapp-f03cd.appspot.com/o/profile%2Fperfil1.jpg?alt=media&token=cf5187c6-2fb4-4e20-8b2b-518030528c38"),
    UserChat("Ana Clara", "Olá, tudo bem?", "https://firebasestorage.googleapis.com/v0/b/whatsapp-f03cd.appspot.com/o/profile%2Fperfil1.jpg?alt=media&token=cf5187c6-2fb4-4e20-8b2b-518030528c38"),
    UserChat("Ana Clara", "Olá, tudo bem?", "https://firebasestorage.googleapis.com/v0/b/whatsapp-f03cd.appspot.com/o/profile%2Fperfil1.jpg?alt=media&token=cf5187c6-2fb4-4e20-8b2b-518030528c38"),
    UserChat("Ana Clara", "Olá, tudo bem?", "https://firebasestorage.googleapis.com/v0/b/whatsapp-f03cd.appspot.com/o/profile%2Fperfil1.jpg?alt=media&token=cf5187c6-2fb4-4e20-8b2b-518030528c38"),
    UserChat("Ana Clara", "Olá, tudo bem?", "https://firebasestorage.googleapis.com/v0/b/whatsapp-f03cd.appspot.com/o/profile%2Fperfil1.jpg?alt=media&token=cf5187c6-2fb4-4e20-8b2b-518030528c38"),
  ];

  @override 
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userChatList.length,
      itemBuilder: (context, index) {
        UserChat userChat = userChatList[index];

        return ListTile(
          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          leading: CircleAvatar(
            maxRadius: 30,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(userChat.photoPath),
          ),
          title: Text(
            userChat.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            )
          ),
          subtitle: Text(
            userChat.message,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14)
          ),
        );
      }
    );
  }
}
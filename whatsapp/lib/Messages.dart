import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/model/Message.dart';
import 'package:whatsapp/model/User.dart';

class Messages extends StatefulWidget {
  final User _contact;

  Messages(this._contact);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  TextEditingController _messageController = TextEditingController();
  String _loggedUserId;
  String _receiverUserId;
  Firestore _db = Firestore.instance;

  _getUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser loggedUser = await auth.currentUser();

    _loggedUserId = loggedUser.uid;
    _receiverUserId = widget._contact.userId;
  }

  _sendMessage() async {
    String userMessage = _messageController.text;

    if (userMessage.isNotEmpty) {
      Message message = Message();
      
      message.userId = _loggedUserId;
      message.message = userMessage;
      message.imageUrl = "";
      message.kindOfMessage = "text";

      _saveMessage(_loggedUserId, _receiverUserId, message);
    }
  }

  _saveMessage(String senderId, String receiverId, Message message) async {
    await _db.collection("messages")
      .document(senderId)
      .collection(receiverId)
      .add(message.toMap());

    _messageController.clear();
  }

  _sendPhoto() async {

  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    var _messageBox = Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: TextField(
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                      hintText: "Digite uma mensagem",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)
                      ),
                      prefixIcon: IconButton(
                        icon: Icon(Icons.photo_camera), 
                        onPressed: _sendPhoto
                      )
                    ),
                    controller: _messageController
                  ),
            )
          ),

          FloatingActionButton(
            backgroundColor: Color(0xff075E54),
            child: Icon(
              Icons.send,
              color: Colors.white, 
            ),
            mini: true,
            onPressed: _sendMessage
          )
        ],
      ),
    );

    var _stream = StreamBuilder(
      stream: _db.collection("messages")
        .document(_loggedUserId)
        .collection(_receiverUserId)
        .snapshots(),
      builder: (context, snapshot) {
        List<Widget> children;
        
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
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
            break;
          
          case ConnectionState.active:
          
          case ConnectionState.done:
            QuerySnapshot querySnapshot = snapshot.data;

            if (snapshot.hasError) {
              return Expanded(
                child: Text("Erro ao carregar dados")
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: querySnapshot.documents.length,
                  itemBuilder: (context, index) {
                    List<DocumentSnapshot> messages = querySnapshot.documents.toList();
                    DocumentSnapshot item = messages[index];

                    double containerWidth = MediaQuery.of(context).size.width * 0.8;

                    Alignment alignment = Alignment.centerRight;
                    Color color = Color(0xffd2ffa5);

                    print(messages);

                    if (_loggedUserId != item["userId"]) {
                      alignment = Alignment.centerLeft;
                      color = Colors.white;
                    }

                    return Align(
                      alignment: alignment,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Container(
                          width: containerWidth,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                          child: Text(
                            item["message"],
                            style: TextStyle(fontSize: 18)
                          ),
                        ),
                      ),
                    ); 
                  }
                ),
              );
            }
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        );

        /*if (snapshot.hasData) {
          QuerySnapshot querySnapshot = snapshot.data;

          return Expanded(
            child: ListView.builder(
              itemCount: querySnapshot.documents.length,
              itemBuilder: (context, index) {
                List<DocumentSnapshot> messages = querySnapshot.documents;
                DocumentSnapshot item = messages[index];

                double containerWidth = MediaQuery.of(context).size.width * 0.8;

                Alignment alignment = Alignment.centerRight;
                Color color = Color(0xffd2ffa5);

                if (_loggedUserId != item["userId"]) {
                  alignment = Alignment.centerLeft;
                  color = Colors.white;
                }

                return Align(
                  alignment: alignment,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      width: containerWidth,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                      child: Text(
                        item["message"],
                        style: TextStyle(fontSize: 18)
                      ),
                    ),
                  ),
                ); 
              }
            ),
          );
        }

        else if (snapshot.hasError) {
          return Expanded(
            child: Column(
              children: [
                Text("Erro ao carregar dados.")
              ]
            )
          );
        }*/

        /*return Center(
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
        );*/
        
        
      }
    );
      

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              maxRadius: 20,
              backgroundColor: Colors.grey,
              backgroundImage: widget._contact.imageUrl != null 
              ?  NetworkImage(
                  widget._contact.imageUrl
                )
              : null
            ),

            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                widget._contact.name
              ),
            )
          ],
        )
      ),

      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg.png"),
            fit: BoxFit.cover
          )
        ),
        child: SafeArea(
          child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
              children: [
                _stream,
                _messageBox,
              ]
            )
          )
        ),
      ),
    );
  }
}
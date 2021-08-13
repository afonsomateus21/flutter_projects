import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';  
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController _usernameController = TextEditingController();
  File _image;
  String _loggedUserId;
  bool _uploadingImage = false;
  String _urlImage;
  final picker = ImagePicker();

  Future _getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _uploadingImage = true;
        _uploadImage();
      } else {
        print("No image selected");
      }
    });
  }

  Future _getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    
    setState(() {
      if (pickedFile != null) {
        
        _image = File(pickedFile.path);
        _uploadingImage = true;
        _uploadImage();
      } else {
        print("No image selected");
      }
    });
  }

  Future _uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference root = storage.ref();
    StorageReference file = root
      .child("profile")
      .child(_loggedUserId + ".jpg");

    StorageUploadTask task = file.putFile(_image);

    task.events.listen((StorageTaskEvent event) {
      if (event.type == StorageTaskEventType.progress) {
        setState(() {
          _uploadingImage = true;
        });
      } 
      
      else if (event.type == StorageTaskEventType.success) {
        setState(() {
          _uploadingImage = false;
        });
      }

      task.onComplete.then((StorageTaskSnapshot storageTaskSnapshot) {
        _getImageUrl(storageTaskSnapshot);
      });
    });
  }

  _getUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser loggedUser = await auth.currentUser();

    _loggedUserId = loggedUser.uid;

    Firestore db = Firestore.instance;
    DocumentSnapshot snapshot = await db.collection("users")
      .document(_loggedUserId)
      .get();

    Map<String, dynamic> data = snapshot.data;
    _usernameController.text = data["name"];

    if (data["imageUrl"] != null) {
      setState(() {
        this._urlImage = data["imageUrl"];
      });
    }
  }

  Future _getImageUrl(StorageTaskSnapshot storageTaskSnapshot) async {
    String url = await storageTaskSnapshot.ref.getDownloadURL();

    _updateImageUrlFirestore(url);

    setState(() {
      _urlImage = url;
    });
  }

  _updateImageUrlFirestore(String url) async {
    Firestore db = Firestore.instance;
    Map<String, dynamic> updatedData = {
      "imageUrl": url
    };

    db.collection("users")
    .document(_loggedUserId)
    .updateData(updatedData);
  }

  _updateNameFirestore() async {
    Firestore db = Firestore.instance;
    Map<String, dynamic> updatedData = {
      "name": _usernameController.text
    };

    db.collection("users")
    .document(_loggedUserId)
    .updateData(updatedData);
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações")
      ),

      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: _uploadingImage 
                  ? CircularProgressIndicator()
                  : Container(),
                ),
                
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                  backgroundImage: _urlImage != null
                    ? NetworkImage(_urlImage)
                    : null
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        _getImageFromCamera();
                      }, 
                      child: Text(
                        "Câmera",
                        style: TextStyle(
                          color: Colors.black
                        ),
                      )
                    ),

                    TextButton(
                      onPressed: () {
                        _getImageFromGallery();
                      }, 
                      child: Text(
                        "Galeria",  
                        style: TextStyle(
                          color: Colors.black
                        ),
                      )
                      
                    ),
                  ]
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Nome",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)
                      )
                    ),
                    controller: _usernameController
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      _updateNameFirestore();
                    }, 
                    child: Text(
                      "Salvar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(32, 16, 32, 16)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)))
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
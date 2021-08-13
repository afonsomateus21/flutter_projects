import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File _imageFile;
  final picker = ImagePicker();

  Future<void> _chooseImage(ImageSource source) async {

    final pickedImage = await picker.getImage(source: source);
    if (pickedImage != null) {
      File cropped = await ImageCropper.cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxHeight: 100,
        maxWidth: 100,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.deepOrange,
          toolbarTitle: "RPS Cropper",
          statusBarColor: Colors.deepOrange.shade900,
          backgroundColor: Colors.white,
        ),
      );

      this.setState(() {
        _imageFile = cropped;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Foto"),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage:
                  _imageFile != null ? FileImage(_imageFile) : null,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  _chooseImage(ImageSource.camera);
                },
                icon: Icon(Icons.add_a_photo),
                label: Text("Câmera")),
            ElevatedButton.icon(
                onPressed: () {
                  _chooseImage(ImageSource.gallery);
                },
                icon: Icon(Icons.add_a_photo),
                label: Text("Galeria")),
          ],
        ),
      ),
    );
  }
}

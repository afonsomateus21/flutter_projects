import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';


class Home extends StatefulWidget {
  @override 
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache(prefix: "audios/");
  _playAudio() async {
    /*int result = await audioPlayer.play("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3");

    if (result == 1) {
      print("sucesso");
    } else {
      print("erro");
    }*/

    audioPlayer = await audioCache.play("musica.mp3");
  }

  @override 
  Widget build(BuildContext context) {
    _playAudio();
    return Scaffold(

    );
  }
}
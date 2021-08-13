import 'package:flutter/material.dart';
import 'package:youtube/Api.dart';
import 'package:youtube/model/Video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class Initial extends StatefulWidget {
  String _searchResult;

  Initial(this._searchResult);

  @override 
  _Initial createState() => _Initial();
}

class _Initial extends State<Initial> {
  _listVideos(String search) {
    Api api = Api();
    
    return api.search(search);
  }

  @override 
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      future: _listVideos(widget._searchResult),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            itemCount: snapshot.data.length,
            separatorBuilder: (context, index) => Divider(
              height: 2,
              color: Colors.grey
            ),
            itemBuilder: (context, index) {
              List<Video> videos = snapshot.data;
              Video video = videos[index];

              return GestureDetector(
                onTap: () {
                  FlutterYoutube.playYoutubeVideoById(
                    apiKey: YOUTUBE_API_KEY, 
                    videoId: video.id,
                    autoPlay: true,
                    fullScreen: true
                  );
                } ,
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(video.image)
                        )
                      )
                    ),

                    ListTile(
                      title: Text(video.title),
                      subtitle: Text(video.channel),
                    )
                  ]
                ),
              );
            }
          );
        }

        else if (snapshot.hasError) {
          return Center(
            child: Text("Nenhum dado a ser exibido!")
          );
        }

        else {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      } 
    );
  }
}
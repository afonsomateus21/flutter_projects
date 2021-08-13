import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:youtube/model/Video.dart';

const YOUTUBE_API_KEY = "AIzaSyDeQoOcaZWvU5uhZMNGG89gEXpPf6pign0";
const CHANNEL_ID = "UCVHFbqXqoYvEWM1Ddxl0QDg";
const BASE_URL = "https://www.googleapis.com/youtube/v3";

class Api {
  Future<List<Video>> search(String search) async {
    http.Response response = await http.get(
      BASE_URL + "/search"
        "?part=snippet"
        "&type=video"
        "&maxResults=20"
        "&order=date"
        "&key=$YOUTUBE_API_KEY"
        // "&channelId=$CHANNEL_ID"
        "&q=$search", 
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<Video> videos = data["items"].map<Video>(
        (video) => Video.fromJson(video)
      ).toList();

      return videos;
    }
  }
}

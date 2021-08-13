import 'package:consumo_servico_avancado/Post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override 
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _urlBase = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> _recuperarPostagens() async {
    http.Response response = await http.get(_urlBase + "/posts");
    var dadosJson = json.decode(response.body);

    List<Post> posts = [];
    for (var post in dadosJson) {
      Post p = Post(post["userId"], post["id"], post["title"], post["body"]);
      posts.add(p);
    }
    
    return posts;
  }
  
  _post() async {
    http.Response response = await http.post(
      _urlBase + "/posts",
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },

      body: json.encode(
        {
          "userId": 120,
          "id": null,
          "title": 'Título',
          "body": 'Corpo da postagem'
        }
      ) 
    );

    print("status: ${response.statusCode}");
    print("body: ${response.body}");
  }

  _put() async {
    http.Response response = await http.put(
      _urlBase + "/posts/2",
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },

      body: json.encode(
        {
          "userId": 120,
          "id": null,
          "title": 'Título alterado',
          "body": 'Corpo da postagem alterada'
        }
      ) 
    );

    print("status: ${response.statusCode}");
    print("body: ${response.body}");
  }

  _patch() async {
    http.Response response = await http.patch(
      _urlBase + "/posts/2",
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },

      body: json.encode(
        {
          "userId": 120,
          "id": null,
          "title": null,
          "body": 'Corpo da postagem alterada'
        }
      ) 
    );

    print("status: ${response.statusCode}");
    print("body: ${response.body}");

  }

  _delete() async {
    http.Response response = await http.delete(_urlBase + "/posts/1");

    print("status: ${response.statusCode}");
    print("body: ${response.body}");
  }
  
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço avançado"),
      ),

      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                RaisedButton(
                  onPressed: _post,
                  child: Text("Salvar"),
                ),

                RaisedButton(
                  onPressed: _put,
                  child: Text("Atualizar"),
                ),

                RaisedButton(
                  onPressed: _delete,
                  child: Text("Deletar"),
                )
              ],
            ),

            Expanded(
              child: FutureBuilder<List<Post>>(
                future: _recuperarPostagens(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        List<Post> posts = snapshot.data;
                        Post post = posts[index];

                        return ListTile(
                          title: Text(post.title),
                          subtitle: Text(post.body),
                        );
                      }
                    );
                  }

                  else if (snapshot.hasError) {
                    return Container(
                      child: Center(
                        child: Text("Dados não encontrados")
                      ),
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
              ),
            )
          ]
        ),
      )
    );
  }
}
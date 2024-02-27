import 'package:flutter/material.dart';

import 'movie.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  List<Movie> movies = [];


  void callApi() async {
    var response = await http.get(
        Uri.parse("http://127.0.0.1:8080/api/v1/movies"));
    var json = convert.jsonDecode(response.body);
    //movies = List<Movie>.from(json.map((filmJson) => Movie.jsonToMovie(filmJson)));
    //print(movies);
    setState(() {
      movies =
      List<Movie>.from(json.map((movieJson) => Movie.jsonToMovie(movieJson)));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo Movie Page"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                callApi();
              },
              child: Text("Appeler Api"),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        color: Colors.black12,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                              "Le film id : ${movies[index]
                                  .id} - ${movies[index].title}"),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
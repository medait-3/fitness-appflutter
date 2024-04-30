import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'dart:convert';

import 'exercie_hub.dart';
import 'exercise_start_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String apiURL =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json";

  ExerciseHub? excerciseHub;

  @override
  void initState() {
    getExcercises();

    super.initState();
  }

  void getExcercises() async {
    var response = await http.get(Uri.parse(apiURL));
    var body = response.body;

    var decodedJson = jsonDecode(body);

    excerciseHub = ExerciseHub.fromJson(decodedJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fitness App"),
        centerTitle: true,
      ),
      body: Container(
        child: excerciseHub != null
            ? ListView(
                children: excerciseHub!.exercises!.map((e) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExerciseStartScreen(
                                    exercises: e,
                                  )));
                    },
                    child: Hero(
                      tag: e.id!,
                      child: Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                imageUrl: e.thumbnail!,
                                placeholder: (context, url) => Image(
                                  image: AssetImage("assets/placeholder.jpg"),
                                  fit: BoxFit.cover,
                                  height: 250,
                                  width: MediaQuery.of(context).size.width,
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.cover,
                                height: 250,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  colors: [
                                    Colors.blueGrey,
                                    Color(0x00000000),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.center,
                                )),
                              ),
                            ),
                            Container(
                              height: 250,
                              padding: EdgeInsets.only(
                                left: 10,
                                bottom: 20,
                              ),
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                e.title!,
                                style: TextStyle(
                                  fontSize: 29,
                                  color: Color.fromARGB(255, 184, 181, 181),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )
          : Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                itemCount: 5, // Set a placeholder number of items
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset("assets/placeholder.jpg",  fit: BoxFit.cover,
                                  height: 250,
                                  width: MediaQuery.of(context).size.width,),
                                
                                ),
                              
                            
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  colors: [
                                    Colors.blueGrey,
                                    Color(0x00000000),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.center,
                                )),
                              ),
                            ),
                            Container(
                              height: 250,
                              padding: EdgeInsets.only(
                                left: 10,
                                bottom: 20,
                              ),
                              
                            ),
                          ],
                        ),
                      ),
                  );
                },
              ),
            ),
      ),

      
    );
  }
}

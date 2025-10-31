import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as myhttp;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String id = "";
  String email = "";
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP GET"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("ID : $id"),
            SizedBox(height: 10),
            Text("Email : $email"),
            SizedBox(height: 10),
            Text("Name : $name"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var myresponse = await myhttp
                    .get(Uri.parse("https://reqres.in/api/users/1"),
                  headers: {
                    'x-api-key': 'reqres-free-v1'
                  },
                );

                if (myresponse.statusCode == 200) {
                  print("BERHASIL GET DATA");

                  Map<String, dynamic> data =
                  json.decode(myresponse.body) as Map<String, dynamic>;

                  print(data["data"]);
                  print(data["data"]["id"]);
                  print(data["data"]["email"]);
                  print(
                      "${data["data"]["first_name"]} ${data["data"]["last_name"]}");

                  setState(() {
                    id = data["data"]["id"].toString();
                    email = data["data"]["email"].toString();
                    name =
                    "${data["data"]["first_name"]} ${data["data"]["last_name"]}";
                  });
                } else {
                  print("ERROR ${myresponse.statusCode}");
                }
              },
              child: Text("GET DATA"),
            ),
          ],
        ),
      ),
    );
  }
}
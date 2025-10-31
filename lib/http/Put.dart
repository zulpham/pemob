import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameC = TextEditingController();
  TextEditingController jobC = TextEditingController();

  String hasilResponse = "Belum ada data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HTTP PUT / PATCH"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameC,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Name",
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: jobC,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Job",
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async {
              String nameInput = nameC.text;
              String jobInput = jobC.text;

              try {
                var myresponse = await http.put(
                  Uri.parse("https://reqres.in/api/users/1"),
                  headers: {
                    "Content-Type": "application/json",
                    "x-api-key": "reqres-free-v1"
                  },
                  body: json.encode({
                    "name": nameInput,
                    "job": jobInput,
                  }),
                );
                if (myresponse.statusCode == 200) {
                  var responseBody = json.decode(myresponse.body);
                  setState(() {
                    hasilResponse =
                    "Data berhasil diupdate!\nName: ${responseBody['name']}\nJob: ${responseBody['job']}";
                  });
                } else {
                  setState(() {
                    hasilResponse =
                    "Gagal update data. Error: ${myresponse.statusCode}\nBody: ${myresponse.body}";
                  });
                }
              } catch (e) {
                print("Error: $e");
                setState(() {
                  hasilResponse = "Terjadi kesalahan: $e";
                });
              }
            },
            child: const Text("SUBMIT"),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              hasilResponse,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
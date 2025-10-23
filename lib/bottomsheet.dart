import 'package:flutter/material.dart';

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

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bottom Sheet"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          print("Click Photo");
                          Navigator.pop(context);
                        },
                        leading: Icon(Icons.camera_alt),
                        title: Text("Click Photo"),
                      ),
                      ListTile(
                        onTap: () {
                          print("Click Video");
                          Navigator.pop(context);
                        },
                        leading: Icon(Icons.videocam),
                        title: Text("Click Video"),
                      ),
                      ListTile(
                        onTap: () {
                          print("Click Share");
                          Navigator.pop(context);
                        },
                        leading: Icon(Icons.share),
                        title: Text("Click Share"),
                      ),
                      SizedBox(height: 10),
                      Text("SHOW BOTTOM SHEET"),
                    ],
                  ),
                );
              },
            );
          },
          child: Text("Click Me"),
        ),
      ),
    );
  }
}

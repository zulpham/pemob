import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("SnackBar Example")),
        body: SnackBarExample(),
      ),
    );
  }
}

class SnackBarExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Hello from SnackBar")),
              );
            },
            child: Text("Show Normal SnackBar"),
          ),
          ElevatedButton(
            onPressed: () {
              Get.snackbar("Hello", "This is GetX SnackBar",
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: Text("Show GetX SnackBar"),
          ),
        ],
      ),
    );
  }
}

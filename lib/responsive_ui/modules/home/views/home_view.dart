import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height;
    double paddingTop = MediaQuery.of(context).padding.top;
    double paddingBottom = MediaQuery.of(context).padding.bottom;

    AppBar myAppBar() {
      return AppBar(
        title: Text("HOME"),
      );
    }

    double heightBody = heightDevice - myAppBar().preferredSize.height - paddingTop;

    return Scaffold(
      appBar: myAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Responsive layout with Flexible
            SizedBox(
              height: heightBody * 0.3,
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: widthDevice * 0.5,
                      color: Colors.red,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: widthDevice * 0.5,
                      color: Colors.amber,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: widthDevice * 0.5,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),

            // Responsive layout with Expanded and ListTile
            SizedBox(
              height: heightBody * 0.2,
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    color: Colors.green,
                  ),
                  Expanded(
                    child: ListTile(
                      tileColor: Colors.amber,
                      leading: Icon(Icons.abc_sharp),
                      title: Text("JUDUL"),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    color: Colors.red,
                  ),
                ],
              ),
            ),

            // Responsive layout with Wrap
            Wrap(
              direction: Axis.vertical,
              children: List.generate(4, (index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  width: widthDevice * 0.15,
                  height: 35,
                  color: Colors.amber,
                );
              }),
            ),

            // Responsive layout with FittedBox
            Container(
              width: widthDevice * 0.5,
              height: 100,
              color: Colors.amber,
              child: Center(
                child: FittedBox(
                  child: Text(
                    "HALOOOooooooo",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

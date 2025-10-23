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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isHidden = true;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
}
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Text Field"),
    ),
    body: Column(
      children: [
        SizedBox(height: 20),
        TextField(
          controller: emailC,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: "Email",
            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          controller: passC,
          obscureText: isObsecure,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            labelText: "Password",
            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  if (isObsecure == true) {
                    isObsecure = false;
                  } else {
                    isObsecure = true;
                  }
                });
              },
              icon: Icon(Icons.vpn_key),
            ),
          ),
        ),
        SizedBox(height: 20),
        TextButton(
          onPressed: () {
            print("LOGIN DENGAN : EMAIL (${emailC.text}) & PASS (${passC.text})");
          },
          child: Text("Submit"),
        ),
      ],
    ),
  );
}

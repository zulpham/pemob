import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

import './login.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Title of first page",
          body: "Here you can write the description of the page, to explain something...",
          image: Center(
            // child: Image.network("https://picsum.photos/id/237/200/200", height: 175.0),
            child: Container(
              width: 350,
              height: 350,
              child: Lottie.asset(
                "lotties/laptop.json",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        PageViewModel(
          title: "Title of second page",
          body: "Here you can write the description of the page, to explain something...",
          image: Center(
            // child: Image.network("https://picsum.photos/id/238/200/200", height: 175.0),
            child: Container(
              width: 250,
              height: 250,
              child: Lottie.asset(
                "lotties/login.json",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
      done: const Text("Login", style: TextStyle(fontWeight: FontWeight.w600)),
      showNextButton: true,
      next: const Text("Next >>"),
      onDone: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      },
    );
  }
}

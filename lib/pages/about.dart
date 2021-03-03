import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('About'),
          backgroundColor: Color(0xfff015dad),
          elevation: 7, // <-- ELEVATION ZEROED
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/aboutbackground.png"),
                fit: BoxFit.cover),
          ),
        ));
  }
}

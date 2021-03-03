import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:photoalbum/pages/home.dart';
import 'package:photoalbum/pages/about.dart';
import 'package:photoalbum/pages/newalbum.dart';
import 'package:photoalbum/models/albums.dart';
import 'package:photoalbum/settings/theme.dart';
//import 'package:photoalbum/pages/listalbum.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:photoalbum/pages/listimage.dart';
import 'package:photoalbum/pages/carusolimage.dart';

import 'package:flutter/cupertino.dart';

void main() {
 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new Home(),
        '/addalbums': (BuildContext context) =>
            new AlbumsDetail(Albums('', '', ''), "Add albums"),
        // '/albumslist': (BuildContext context) => new ListAlbum(),
        '/imageslist': (BuildContext context) => new ImagesList(),
        '/carusolimage': (BuildContext context) => new CarusolImages(),
        '/about': (BuildContext context) => new AboutPage(),
        //  '/settings': (BuildContext context) => new SettingsPage(),
      },
      title: 'Photo album',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          //primaryColor: Colors.blue,
          //accentColor: Colors.blueAccent,
          //scaffoldBackgroundColor: Color(0xff014886),
          scaffoldBackgroundColor: Colors.black,
          appBarTheme:
              AppBarTheme(textTheme: TextTheme(title: AppBarTextstyle)),
          textTheme: TextTheme(
            title: TitleTextStyle,
            body1: Body1TextStyle,
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xff015dad),
            textTheme: ButtonTextTheme.accent,
          )),
      home: Home(),
    );
  }
}

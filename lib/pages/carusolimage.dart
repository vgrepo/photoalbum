import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:photoalbum/database/database.dart';
import 'package:photoalbum/models/albumimages.dart';
import 'package:photoalbum/models/albums.dart';
import 'package:sqflite/sqlite_api.dart';
// import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:photoalbum/settings/global.dart' as global;
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarusolImages extends StatefulWidget {
  @override
  _ImagesPageStatenew createState() => _ImagesPageStatenew();
}

class _ImagesPageStatenew extends State<CarusolImages> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Albums> albumsList;
  List<AlbumImages> albumCarusolImages;
  static List<String> imgCarusolList = List<String>();
  static List childCarusol = List();

  AlbumImages albumImages =
      new AlbumImages(0, " ", " ", " ", " ", " ", 0, " ", 0, 0);
  List<Asset> images = List<Asset>();
  List<Asset> imagesTumb = List<Asset>();
  int count = 0;
  String _error = 'No Error Dectected';

  @override
  Widget build(BuildContext context) {
    if (albumCarusolImages == null) {
      albumCarusolImages = List<AlbumImages>();
      print('albumCarusolImages je null');
      updateAlbumImagesView();
      updateCarusolList();
    }

    setState(() {
      updateAlbumImagesView();
      updateCarusolList();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Photo album - images carusol'),
      ),
      body: imgCarusolList.length > 0 ? coverScreenExample(context) : null,
      /*   body: ListView(
          children: <Widget>[
            //Expanded(child: count == 0 ? insertButton() : getAlbumsListView()),
            //Expanded(child: coverScreenExample(context)),
            coverScreenExample(context),
            /*  Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
            ),*/
          ],
        )*/
    );
  }

  void updateAlbumImagesView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<AlbumImages>> albumCarusolImagesFuture =
          databaseHelper.getAlbumImagesList(global.albumID);
      albumCarusolImagesFuture.then((albumCarusolImages) {
        if (!mounted) return;
        setState(() {
          this.albumCarusolImages = albumCarusolImages;
          this.count = albumCarusolImages.length;
        });
      });
    });
    if (albumCarusolImages.length > 0) {
      updateCarusolList();
    }
  }

  void updateCarusolList() {
    print("ja sam u updateCarusolList 1");
    if (imgCarusolList != null) {
      print("ja sam u updateCarusolList 2");
      imgCarusolList.clear();
    }
    print("ja sam u updateCarusolList 3");
    print(albumCarusolImages.length);
    for (var i = 0; i < albumCarusolImages.length; i++) {
      print("jsa smau updateCarusolList 4");
      imgCarusolList.add(albumCarusolImages[i].imgPath);
    }
  }

  //Pages covers entire carousel
  CarouselSlider coverScreenExample(BuildContext mediaContext) {
    return CarouselSlider(
      viewportFraction: 1.05,
       //aspectRatio: MediaQuery.of(mediaContext).size.aspectRatio,
      aspectRatio: 0.75,
      autoPlay: false,
      //enlargeCenterPage: true,
      items: imgCarusolList.map(
        (url) {
          return Center(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              child: Image.file(
                File(url),
                fit: BoxFit.fill,
                width: 1000.0,
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}

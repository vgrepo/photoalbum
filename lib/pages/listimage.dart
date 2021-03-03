import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:photoalbum/database/database.dart';
import 'package:photoalbum/models/albumimages.dart';
import 'package:photoalbum/models/albums.dart';
import 'package:sqflite/sqlite_api.dart';
//import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:photoalbum/settings/global.dart' as global;
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImagesList extends StatefulWidget {
  @override
  _ImagesPageStatenew createState() => _ImagesPageStatenew();
}

class _ImagesPageStatenew extends State<ImagesList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Albums> albumsList;
  List<AlbumImages> albumImagesList;

  AlbumImages albumImages =
      new AlbumImages(0, " ", " ", " ", " ", " ", 0, " ", 0, 0);
  List<Asset> images = List<Asset>();
  List<Asset> imagesTumb = List<Asset>();
  int count = 0;
  String _error = 'No Error Dectected';
  bool loaded = false;
  int _selectedIndex = 1;
  int _quality = 100;
  int _size = 300;

  @override
  Widget build(BuildContext context) {
    if (albumImagesList == null) {
      albumImagesList = List<AlbumImages>();
      print('albumImagesList je null');
      updateAlbumImagesView();
    }

    setState(() {
      imageCache.clear();
      laodPrefColumn();
      updateAlbumImagesView();
      updateTumbList();
    });

    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              // leading: Icon(Icons.menu),
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add_box),
                  onPressed: () {
                    loadAssets();
                  },
                ),
              ],
              expandedHeight: 200.0,
              backgroundColor: Colors.orangeAccent,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(title: Text("Images list")),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Column(children: <Widget>[
                  count > 0 ? buildGridView() : insertButton()
                ]),
              ]),
            )
          ],
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _selectedIndex,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
            _quality = 100 - (_selectedIndex * 10);
            _size = 300 - (_selectedIndex * 50);
            savePrefColumn(_selectedIndex);
            savePrefOuality(_quality);
            savePrefSize(_size);
          }),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.filter_1),
              title: Text('Collumn'),
              activeColor: Colors.orangeAccent,
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.filter_2),
                title: Text('Collumn'),
                activeColor: Colors.orangeAccent),
            BottomNavyBarItem(
                icon: Icon(Icons.filter_3),
                title: Text('Collumn'),
                activeColor: Colors.orangeAccent),
            BottomNavyBarItem(
                icon: Icon(Icons.filter_4),
                title: Text('Collumn'),
                activeColor: Colors.orangeAccent),
          ],
        ));
  }

  void updateAlbumImagesView() {
    if (this.count == 0) {
      print("ja sam u updateAlbumImagesView");
      final Future<Database> dbFuture = databaseHelper.initializeDatabase();
      dbFuture.then((database) {
        Future<List<AlbumImages>> albumImagesListFuture =
            databaseHelper.getAlbumImagesList(global.albumID);
        albumImagesListFuture.then((albumImagesList) {
          if (!mounted) return;
          setState(() {
            print("ja sam u updateAlbumImagesView 2");
            this.albumImagesList = albumImagesList;
            this.count = albumImagesList.length;
          });
        });
      });
    }
    if (this.count == 0) {
      return;
    }
    updateTumbList();
  }

  void updateTumbList() {
    /*  if (imagesTumb.length != 0) {
      return;
    }*/
    Asset _selected;
    print("ja sam u updateTumbList");
    imagesTumb.clear();
    for (var i = 0; i < albumImagesList.length; i++) {
      _selected = Asset(
          albumImagesList[i].imgIdentifier,
          albumImagesList[i].imgNzv,
          albumImagesList[i].imgWidth,
          albumImagesList[i].imgHeight);
      imagesTumb.add(_selected);
      _selected = null;
    }
  }

  Widget buildGridView() {
    print("jas am u buildGridView ");
    return GridView.count(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: _selectedIndex + 1,
      children: List.generate(count, (index) {
        Asset asset = imagesTumb[index];
        return new GestureDetector(
          child: Card(
            color: Colors.orangeAccent,
            child: AssetThumb(
              asset: asset,
              width: _size,
              height: _size,
              quality: _quality,
            ),
            elevation: 7.0,
          ),
          onTap: () {
            onTapImage();
          },
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    Asset _selected;
    //images.clear();
    for (var i = 0; i < albumImagesList.length; i++) {
      _selected = Asset(
          albumImagesList[i].imgIdentifier,
          albumImagesList[i].imgNzv,
          albumImagesList[i].imgWidth,
          albumImagesList[i].imgHeight);
      images.add(_selected);
      _selected = null;
    }

    try {
      resultList = await MultiImagePicker.pickImages(
          maxImages: 300,
          enableCamera: false,
          selectedAssets: images,
          //cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
          materialOptions: MaterialOptions(
            actionBarColor: "#aaaaaa",
            actionBarTitle: "Photos",
            allViewTitle: "All Photos",
            useDetailsView: true,
            selectCircleStrokeColor: "#000000",
            statusBarColor: '#abcdef',
            startInAllView: true,
            selectionLimitReachedText: "You can't select any more.",
          ));
    } on PlatformException catch (e) {
      error = e.message;
    }
    if (!mounted) return;

    setState(() {
      images.clear();
      images = resultList;
      _error = error;
      if (images.length != 0) {
        _save();
      }
    });
  }

  void _save() async {
    int _result;
    databaseHelper.deleteAlbumImagesAll(global.albumID);
    for (var i = 0; i < images.length; i++) {
      albumImages.albumsId = global.albumID;
      albumImages.imgNzv = images[i].name;
      //albumImages.imgPath = await images[i].filePath;
      albumImages.imgTtl = images[i].name;
      albumImages.imgDsc = images[i].name;
      albumImages.imgDne = 'Slika DNE';
      albumImages.imgNo = i + 1;
      albumImages.imgIdentifier = images[i].identifier;
      albumImages.imgWidth = images[i].originalWidth;
      albumImages.imgHeight = images[i].originalHeight;
      _result = await databaseHelper.insertAlbumImages(albumImages);
    }
    imagesTumb = images;
    setState(() {
      this.count = 0;
      updateAlbumImagesView();
      updateTumbList();
    });
    images.clear();
  }

  insertButton() {
    return SafeArea(
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            new Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: RaisedButton(
                    //color: Color(0xff015dad),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    textColor: Colors.white,
                    child: Text(
                      'Insert Images',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      loadAssets();
                    })),
          ])),
    );
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  void onTapImage() {
    Navigator.of(context).pushNamed('/carusolimage');
    print("tu sam");
  }

  laodPrefColumn() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _selectedIndex = _prefs.getInt("column") ?? 1;
    _quality = _prefs.getInt("quality") ?? 100;
    _size = _prefs.getInt("size") ?? 1000;
  }

  savePrefColumn(int column) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs = await SharedPreferences.getInstance();
    _prefs.remove('column');
    await _prefs.setInt('column', column);
  }

  savePrefSize(int size) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs = await SharedPreferences.getInstance();
    _prefs.remove('size');
    await _prefs.setInt('size', size);
  }

  savePrefOuality(int quality) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs = await SharedPreferences.getInstance();
    _prefs.remove('quality');
    await _prefs.setInt('quality', quality);
  }
}

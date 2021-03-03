import 'package:flutter/material.dart';
import 'package:photoalbum/database/database.dart';
import 'package:photoalbum/models/albums.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:photoalbum/settings/global.dart' as global;

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Albums> albumsList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (albumsList == null) {
      albumsList = List<Albums>();
      updateAlbumsView();
    }
    setState(() {
      if (count == 0) {
        updateAlbumsView();
      }
    });
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          leading: Icon(Icons.menu),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_box),
              onPressed: () {
                Navigator.of(context).pushNamed('/addalbums');
              },
            ),
          ],
          expandedHeight: 200.0,
          backgroundColor: Colors.orangeAccent,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Albums list"),
            background:
                Image.asset('images/home_ic_geography.png', fit: BoxFit.none),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Column(children: <Widget>[
              getAlbumsListView(),
            ]),
          ]),
        )
      ],
    ));
  }

  void updateAlbumsView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Albums>> albumsListFuture = databaseHelper.getAlbumsList();
      albumsListFuture.then((albumsList) {
        setState(() {
          this.albumsList = albumsList;
          this.count = albumsList.length;
        });
      });
    });
  }

  ListView getAlbumsListView() {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return SafeArea(
            child: SingleChildScrollView(
          child: Container(
              height: 100.0,
              margin: new EdgeInsets.all(5.0),
              alignment: Alignment.centerRight,
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                /*gradient: new LinearGradient(
                      colors: (position % 2 == 0)
                          ? [Colors.yellow[700], Colors.redAccent]
                          : [Colors.yellow[300], Colors.redAccent],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      tileMode: TileMode.clamp)*/
              ),
              child: ListTile(
                  leading: Icon(
                    Icons.image,
                    color: Colors.white,
                  ),
                  title: Text(
                    this.albumsList[position].ttl,
                    style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    this.albumsList[position].dsc,
                    style: new TextStyle(fontSize: 12.0, color: Colors.white70),
                  ),
                  trailing: GestureDetector(
                    child: Container(
                        padding: EdgeInsets.only(left: 12.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                left: new BorderSide(
                                    width: 1.0, color: Colors.white24))),
                        child: IconButton(
                          icon: new Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            databaseHelper.deleteAlbumImagesAll(1);
                          },
                        )),
                  ),
                  onTap: () {
                    global.albumID = this.albumsList[position].id;
                    Navigator.of(context).pushNamed('/imageslist');
                  })),
        ));
      },
    );
  }
}

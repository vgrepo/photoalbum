import 'package:flutter/material.dart';
import 'package:photoalbum/database/database.dart';
import 'package:photoalbum/models/albums.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:photoalbum/settings/global.dart' as global;

class ListAlbum extends StatefulWidget {
  @override
  _ListAlbumState createState() => _ListAlbumState();
}

class _ListAlbumState extends State<ListAlbum> {
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
      updateAlbumsView();
    });
    return Scaffold(
        appBar: AppBar(title: Text('Photo album 11'), actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_box),
            onPressed: () {
              Navigator.of(context).pushNamed('/addalbums');
            },
          ),
        ]),
        body: Column(
          children: <Widget>[
            Expanded(child: getAlbumsListView2()),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
            ),
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
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return SafeArea(
            child: SingleChildScrollView(
                child: GradientCard(
          shadowColor: Gradients.tameer.colors.last.withOpacity(0.70),
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          // color: Colors.red,
          elevation: 7.0,
          child: Container(
              height: 100.0,
              margin: new EdgeInsets.all(10.0),
              decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                  gradient: new LinearGradient(
                      colors: [Colors.yellow[700], Colors.redAccent],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      tileMode: TileMode.clamp)),
              child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Colors.white24))),
                    child: new Icon(
                      Icons.account_balance,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    this.albumsList[position].dsc,
                    /*style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),*/
                    style: Theme.of(context).textTheme.body1,
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
                            Icons.mode_edit,
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
        )));
      },
    );
  }

  ListView getAlbumsListView2() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return SafeArea(
            child: SingleChildScrollView(
                child: GradientCard(
          //shadowColor: Gradients.tameer.colors.last.withOpacity(0.70),
          // margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          // color: Colors.red,
          elevation: 7.0,
          child: Container(
              height: 200.0,
              margin: new EdgeInsets.all(10.0),
              decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                  gradient: new LinearGradient(
                      colors: [Colors.yellow[700], Colors.redAccent],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      tileMode: TileMode.clamp)),
              child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Colors.white24))),
                    child: new Icon(
                      Icons.account_balance,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    this.albumsList[position].dsc,
                    /*style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),*/
                    style: Theme.of(context).textTheme.body1,
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
                            Icons.mode_edit,
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
        )));
      },
    );
  }
}

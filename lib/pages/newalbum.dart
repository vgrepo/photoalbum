import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photoalbum/models/albums.dart';
import 'package:photoalbum/database/database.dart';

class AlbumsDetail extends StatefulWidget {
  final String appBarTitle;
  final Albums albums;

  AlbumsDetail(this.albums, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return AlbumsDetailState(this.albums, this.appBarTitle);
  }
}

class AlbumsDetailState extends State<AlbumsDetail> {
  DatabaseHelper helper = DatabaseHelper();
  String appBarTitle;
  Albums albums;
  bool _validateTitle = true;
  bool _validateLink = true;

  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  AlbumsDetailState(this.albums, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    // TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = albums.ttl;
    linkController.text = albums.dsc;

    return  Scaffold(
            // backgroundColor: Color(0xff014886),
            /*  appBar: AppBar(
            title: Text(appBarTitle),
            backgroundColor: Colors.orangeAccent,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  // Write some code to control things, when user press back button in AppBar
                  moveToLastScreen();
                }),
          ),
          body: _forma(),*/

            body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              // leading: Icon(Icons.menu),
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),

              expandedHeight: 150.0,
              backgroundColor: Colors.orangeAccent,
              pinned: true,
              flexibleSpace:
                  FlexibleSpaceBar(title: Text("Insert ne new album")),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Column(children: <Widget>[
                  _forma(),
                ]),
              ]),
            )
          ],
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Update the title of Note object
  void updateTitle() {
    albums.ttl = titleController.text;
  }

  // Update the description of Note object
  void updateAlbums() {
    albums.dsc = linkController.text;
  }

  // Save data to database
  void _save() async {
    moveToLastScreen();
    int result;

    if (albums.id != null) {
      // Case 1: Update operation
      result = await helper.updateAlbums(albums);
    } else {
      // Case 2: Insert Operation
      result = await helper.insertAlbums(albums);
    }

    if (result != 0) {
      // Success
      //_showAlertDialog('Status', 'Link Saved Successfully');
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem Saving Albums');
    }
  }

  void _delete() async {
    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (albums.id == null) {
      _showAlertDialog('Status', 'No Albums was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteAlbums(albums.id);
    if (result != 0) {
      // _showAlertDialog('Status', 'Albums Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Albums');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  _forma() {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
      child: ListView(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          // Second Element
          Padding(
            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: TextField(
              controller: titleController,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              onChanged: (value) {
                updateTitle();
              },
              decoration: InputDecoration(
                labelText: 'Album title',
                errorText: _validateTitle ? null : 'Value Can\'t Be Empty',
                labelStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                focusedBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),

          // Third Element
          Padding(
            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: TextField(
              controller: linkController,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              onChanged: (value) {
                debugPrint('Something changed in Description Text Field');
                updateAlbums();
              },
              decoration: InputDecoration(
                  labelText: 'Decription',
                  errorText: _validateLink ? null : 'Value Can\'t Be Empty',
                  labelStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 1.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),

          // Butoon save and delete
          Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    color: Colors.orangeAccent,
                    textColor: Colors.white,
                    child: Text(
                      'Save',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      setState(() {
                        titleController.text.isEmpty
                            ? _validateTitle = false
                            : _validateTitle = true;
                        linkController.text.isEmpty
                            ? _validateLink = false
                            : _validateLink = true;
                      });
                      if (_validateTitle == true && _validateLink == true) {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Confirmation"),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text(
                                          "Are you sure you want to save album?")
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: new Text('Yes'),
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                      _save();
                                    },
                                  ),
                                  new FlatButton(
                                    child: new Text('No'),
                                    onPressed: () {
                                      Navigator.pop(
                                          context); //Quit to previous screen
                                    },
                                  ),
                                ],
                              );
                            });
                      }
                    },
                  ),
                ),
                Container(
                  width: 5.0,
                ),
                Expanded(
                  child: RaisedButton(
                    color: Colors.orangeAccent,
                    textColor: Colors.white,
                    child: Text(
                      'Delete',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Confirmation"),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(
                                        "Are you sure you want to delete album?")
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text('Yes'),
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                    _delete();
                                  },
                                ),
                                new FlatButton(
                                  child: new Text('No'),
                                  onPressed: () {
                                    Navigator.pop(
                                        context); //Quit to previous screen
                                  },
                                ),
                              ],
                            );
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

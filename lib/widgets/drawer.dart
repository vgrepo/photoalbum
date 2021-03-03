import 'package:flutter/material.dart';
//import 'package:siteorganizer/pages/about.dart';

//import 'package:siteorganizer/pages/defaultlist.dart';

class MojDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      elevation: 20.0,
      child: new Material(
        color: Colors.lightBlue[900],
        child: Container(
          child: ListView(
            children: <Widget>[
              Container(
                height: 64,
                child: DrawerHeader(
                  child: new Text("Site Orgnizer",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  decoration: BoxDecoration(
                    color: Color(0xfff015dad),
                  ),
                ),
              ),
              Container(
                  child: new Column(
                children: <Widget>[
                  ListTile(
                    leading: new Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Add links',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      // Ako je na home stranici samo pozovi novu stranicu inače pregazi sve do home
                      Navigator.of(context).pushNamed('/addlinks');
                    },
                  ),
                  /*  ListTile(
                    leading: new Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Settings',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (ModalRoute.of(context).settings.name == "/home") {
                        // Ako je na home stranici samo pozovi novu stranicu inače pregazi sve do home
                        Navigator.of(context).pushNamed('/settings');
                        return;
                      }
                      //Navigator.of(context).pushReplacementNamed('/settings');
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/settings', ModalRoute.withName('/home'));
                      //Navigator.of(context).pushNamed('/settings');
                    },
                  ),*/
                  ListTile(
                    leading: new Icon(
                      Icons.bookmark_border,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Default links',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (ModalRoute.of(context).settings.name == "/home") {
                        // Ako je na home stranici samo pozovi novu stranicu inače pregazi sve do home
                        Navigator.of(context).pushNamed('/defaultlist');
                        return;
                      }
                      //Navigator.of(context).pushReplacementNamed('/settings');
                      /*   Navigator.of(context).pushNamedAndRemoveUntil(
                          '/settings', ModalRoute.withName('/home'));*/
                      Navigator.of(context).pushNamed('/defaultlist');
                    },
                  ),
                  ListTile(
                    leading: new Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                    title: Text(
                      'About',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed('/about');
                      /* Navigator.of(context).pushNamedAndRemoveUntil(
                          '/about', ModalRoute.withName('/home'));*/
                    },
                  ),
                  ListTile(
                      leading: new Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Close',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      }),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}

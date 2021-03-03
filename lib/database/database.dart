import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:photoalbum/models/albums.dart';
import 'package:photoalbum/models/albumimages.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  String albumsTable = 'albums';
  String albumImagesTable = 'albumimages';
  String colId = 'id';
  String colDne = 'dne';
  String colTitle = 'ttl';
  String colDsc = 'dsc';

  String colAlbumsId = 'albumsId';
  String colImgNzv = 'imgNzv';
  String colImgPath = 'imgPath';
  String colImgTtl = 'imgTtl';
  String colImgDsc = 'imgDsc';
  String colImgDne = 'imgDne';
  String colImgNo = 'imgNo';
  String colImgIdentifier = 'imgIdentifier';
  String colImgWidth = 'imgWidth';
  String colImgHeight = 'imgHeight';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'photoalbum.db';
    // Open/create the database at a given path
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE  $albumsTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colDne TEXT, $colTitle TEXT, $colDsc TEXT)');
    await db.execute(
        'CREATE TABLE  $albumImagesTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colAlbumsId INTEGER , $colImgNzv TEXT, $colImgPath TEXT, $colImgTtl TEXT, $colImgDsc TEXT, $colImgDne TEXT,$colImgNo INTEGER, $colImgIdentifier TEXT,$colImgWidth INTEGER,$colImgHeight INTEGER)');
  }

  // Fetch Operation: Get all albums objects from database
  Future<List<Map<String, dynamic>>> getAlbumsMapList() async {
    Database db = await this.database;

    //var result = await db.rawQuery('SELECT * FROM $albumsTable order by $colId ASC');
    var result = await db.query(albumsTable, orderBy: '$colId ASC');
    //print(result.toString());
    return result;
  }

  // Insert Operation: Insert a Links object to database
  Future<int> insertAlbums(Albums albums) async {
    // print(links.link);
    Database db = await this.database;
    var result = await db.insert(albumsTable, albums.toMap());
    return result;
  }

  // Update Operation: Update a Links object and save it to database
  Future<int> updateAlbums(Albums albums) async {
    var db = await this.database;
    var result = await db.update(albumsTable, albums.toMap(),
        where: '$colId = ?', whereArgs: [albums.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteAlbums(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $albumsTable WHERE $colId = $id');
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteAlbumsAll() async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $albumsTable');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCountAlbums() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $albumsTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Links List' [ List<Note> ]
  Future<List<Albums>> getAlbumsList() async {
    var albumsMapList = await getAlbumsMapList(); // Get 'Map List' from database
    int count =
        albumsMapList.length; // Count the number of map entries in db table
    List<Albums> albumsList = List<Albums>();
    // For loop to create a 'Links List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      albumsList.add(Albums.fromMapObject(albumsMapList[i]));
    }
    return albumsList;
  }

///////////////////////// Images ////////////////////////////////////////////////////////////////////

  // Fetch Operation: Get all albums objects from database
  Future<List<Map<String, dynamic>>> getAlbumImagesMapList(int albumId) async {
    Database db = await this.database;

    //var result = await db.rawQuery('SELECT * FROM $albumImages order by $colId ASC');
    var result = await db.query(albumImagesTable,
        where: 'albumsId=$albumId', orderBy: '$colId ASC');
    // print(result.toString());
    return result;
  }

  // Insert Images: Insert a images object to database
  Future<int> insertAlbumImages(AlbumImages albumImages) async {
    Database db = await this.database;
    var result = await db.insert(albumImagesTable, albumImages.toMap());
    return result;
  }

  // Update Operation: Update a Images object and save it to database
  Future<int> updateAlbumImages(AlbumImages albumImages) async {
    var db = await this.database;
    var result = await db.update(albumImagesTable, albumImages.toMap(),
        where: '$colId = ?', whereArgs: [albumImages.id]);
    return result;
  }

  // Delete Operation: Delete a Image object from database
  Future<int> deleteAlbumImages(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $albumImagesTable WHERE $colId = $id');
    return result;
  }

  // Delete Operation: Delete a Image object from database
  Future<int> deleteAlbumImagesAll(int albumId) async {
    var db = await this.database;
    int result = await db.rawDelete(
        'DELETE FROM $albumImagesTable WHERE $colAlbumsId = $albumId');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCountAlbumImages() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $albumImagesTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Links List' [ List<Note> ]
  Future<List<AlbumImages>> getAlbumImagesList(int albumId) async {
    var albumImagesMapList =
        await getAlbumImagesMapList(albumId); // Get 'Map List' from database
    int count = albumImagesMapList
        .length; // Count the number of map entries in db table
    List<AlbumImages> albumImagesList = List<AlbumImages>();
    // For loop to create a 'Links List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      albumImagesList.add(AlbumImages.fromMapObject(albumImagesMapList[i]));
    }
    //print(albumImagesList.toString());
    return albumImagesList;
  }

  Future close() async => _database.close();
}

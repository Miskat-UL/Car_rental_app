import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path_provider/path_provider.dart';

import '../models/blog_model.dart';
 
class DBHelper {
  static Database? _db;
  static const String ID = 'id';
  static const String title = 'title';
  static const String body = 'body';
  static const String photo = 'photoName';
  static const String TABLE = 'PhotosTable';
  static const String DB_NAME = 'blogs.db';
 
  Future<Database> get db async {
    if (null != _db) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }
 
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }
 
  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $TABLE ($ID INTEGER, $title TEXT, $body TEXT, $photo TEXT)");
  }
 
  Future<Blog> save(Blog blogs) async {
    var dbClient = await db;
    blogs.id = await dbClient.insert(TABLE, blogs.toMap());
    return blogs;
  }
 
  Future<List<Blog>> getPhotos() async {
    var dbClient = await db;
    List<Map<String,dynamic>> maps = await dbClient.query(TABLE, columns: [ID, title, body, photo]);
    List<Blog> blogs = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        blogs.add(Blog.fromMap(maps[i]));
      }
    }
    return blogs;
  }
 
  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
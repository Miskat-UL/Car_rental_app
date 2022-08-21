
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/blog_model.dart';

class BlogsDatabase {
  static final BlogsDatabase instance = BlogsDatabase._init();
  static Database?  _database;
  BlogsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase('blogs.db');
    return _database!;
  }

  Future<Database> _initDatabase(String dbName) async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY';
    final String titleType = 'TEXT NOT NULL';

    await db.execute(
      '''
      CREATE TABLE $tableName (
        ${BlogFields.id} $idType ,
        ${BlogFields.title} $titleType, body $titleType, image $titleType, location $titleType, category $titleType

        )''',
    );
  }

  Future<Blogs> create(Blogs blog) async {
    final db = await instance.database;
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');
    final id = await db.insert(tableName, blog.toJson());
    return blog.copy(id: id);
  }

  Future<List<Blogs>> getAll() async {
    final db = await instance.database;
    final blogs = await db.query(tableName);
    return blogs.map((blog) => Blogs.fromJson(blog)).toList();
    // final List<Map<String, dynamic>> maps = await db.query(tableName);
    // return List.generate(maps.length, (i) {
    //   return blogs(
    //     id: maps[i][blogFields.id],
    //     name: maps[i][blogFields.name],
    //     model: maps[i][blogFields.model],
    //     image: maps[i][blogFields.image],
    //     details: maps[i][blogFields.details],
    //   );
    // });
  }

  Future<Blogs> readBlogs(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableName,
      columns: BlogFields.values,
      where: '${BlogFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Blogs.fromJson(maps.first);
    } else {
      throw Exception('No blog with $id found');
    }
  }

  Future<int> blogUpdate(Blogs blog) async {
    final db = await instance.database;
    return await db.update(
      tableName,
      blog.toJson(),
      where: '${BlogFields.id} = ?',
      whereArgs: [blog.id],
    );
  }

  Future<int> blogDelete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableName,
      where: '${BlogFields.id} = ?',
      whereArgs: [id],
    );
  }

  // Future close() async => _database!.close();
  Future close() async {
    final db = await instance.database;
    _database = null;
    db.close();
  }
}





















// import 'dart:async';
// import 'dart:io' as io;
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// import 'package:path_provider/path_provider.dart';

// import '../models/blog_model.dart';
 
// class DBHelper {
//   static Database? _db;
//   static const String ID = 'id';
//   static const String title = 'title';
//   static const String body = 'body';
//   static const String photo = 'photoName';
//   static const String TABLE = 'PhotosTable';
//   static const String DB_NAME = 'blogs.db';
 
//   Future<Database> get db async {
//     if (null != _db) {
//       return _db!;
//     }
//     _db = await initDb();
//     return _db!;
//   }
 
//   initDb() async {
//     io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, DB_NAME);
//     var db = await openDatabase(path, version: 1, onCreate: _onCreate);
//     return db;
//   }
 
//   _onCreate(Database db, int version) async {
//     await db.execute("CREATE TABLE $TABLE ($ID INTEGER, $title TEXT, $body TEXT, $photo TEXT)");
//   }
 
//   Future<Blog> save(Blog blogs) async {
//     var dbClient = await db;
//     blogs.id = await dbClient.insert(TABLE, blogs.toMap());
//     return blogs;
//   }
 
//   Future<List<Blog>> getPhotos() async {
//     var dbClient = await db;
//     List<Map<String,dynamic>> maps = await dbClient.query(TABLE, columns: [ID, title, body, photo]);
//     List<Blog> blogs = [];
//     if (maps.isNotEmpty) {
//       for (int i = 0; i < maps.length; i++) {
//         blogs.add(Blog.fromMap(maps[i]));
//       }
//     }
//     return blogs;
//   }
 
//   Future close() async {
//     var dbClient = await db;
//     dbClient.close();
//   }
// }
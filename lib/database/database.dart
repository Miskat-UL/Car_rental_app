import 'package:car_rental_app/models/cars.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CarsDatabse {
  static final CarsDatabse instance = CarsDatabse._init();
  static Database?  _database;
  get async => _database;
  CarsDatabse._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase('cars.db');
    return _database!;
  }

  Future<Database> _initDatabase(String dbName) async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY';
    final String nameType = 'TEXT NOT NULL';

    await db.execute(
      '''
      CREATE TABLE $tableName (
        ${CarFields.id} $idType ,
        ${CarFields.name} $nameType, model $nameType, image $nameType, details $nameType

        )''',
    );
  }

  Future<Cars> create(Cars car) async {
    final db = await instance.database;
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');
    final id = await db.insert(tableName, car.toJson());
    return car.copy(id: id);
  }

  Future<List<Cars>> getAll() async {
    final db = await instance.database;
    final cars = await db.query(tableName);
    return cars.map((car) => Cars.fromJson(car)).toList();
    // final List<Map<String, dynamic>> maps = await db.query(tableName);
    // return List.generate(maps.length, (i) {
    //   return Cars(
    //     id: maps[i][CarFields.id],
    //     name: maps[i][CarFields.name],
    //     model: maps[i][CarFields.model],
    //     image: maps[i][CarFields.image],
    //     details: maps[i][CarFields.details],
    //   );
    // });
  }

  Future<Cars> readCars(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableName,
      columns: CarFields.values,
      where: '${CarFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Cars.fromJson(maps.first);
    } else {
      throw Exception('No car with $id found');
    }
  }

  Future<int> updateCar(Cars car) async {
    final db = await instance.database;
    return await db.update(
      tableName,
      car.toJson(),
      where: '${CarFields.id} = ?',
      whereArgs: [car.id],
    );
  }

  Future<int> deleteCar(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableName,
      where: '${CarFields.id} = ?',
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

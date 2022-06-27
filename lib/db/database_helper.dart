import 'dart:async';
import 'dart:io';
import 'package:eat_project/models/Grocery.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'groceries.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    print("db_onCreate");
    await db.execute('''
    CREATE TABLE groceries(
      id TEXT PRIMARY KEY,
      name TEXT
    )
    ''');
  }

  // 추가
  Future<int> add(Grocery grocery) async {
    Database db = await instance.database;

    print("INSERT OK");
    return await db.insert('groceries', grocery.toMap());
  }

  // READ
  Future<List<Grocery>> getGroceries() async {
    Database db = await instance.database;
    var groceries = await db.query('groceries', orderBy: 'name');
    List<Grocery> groceryList = groceries.isNotEmpty
        ? groceries.map((c) => Grocery.fromMap(c)).toList()
        : [];

    return groceryList;
  }

  // 삭제
  Future<int> remove() async {
    Database db = await instance.database;

    return await db.delete('groceries');
    //return await db.delete('groceries', where: 'id = ?', whereArgs: [id]);
  }
}

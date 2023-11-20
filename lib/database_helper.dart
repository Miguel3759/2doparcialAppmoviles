import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'data.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'my_database.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE my_table(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT)",
        );
      },
    );
  }

  Future<void> insertData(Data data) async {
    final db = await database;
    await db.insert('my_table', data.toMap());
  }

  Future<List<Data>> getData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('my_table');
    return List.generate(maps.length, (i) {
      return Data.fromMap(maps[i]);
    });
  }

  Future<void> deleteData(int id) async {
    final db = await database;
    await db.delete('my_table', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateData(Data data) async {
    final db = await database;
    await db.update('my_table', data.toMap(), where: 'id = ?', whereArgs: [data.id]);
  }
}
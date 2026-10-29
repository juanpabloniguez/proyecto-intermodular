import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  Database? _database;

  Future<Database> get database async {
    return _database ??= await _openDatabase();
  }

  Future<Database> _openDatabase() async {
    final databasesPath = await getDatabasesPath();
    return openDatabase(
      '$databasesPath/old_world_companion.db',
      version: 1,
    );
  }

  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._int();
  static Database? _database;

  DatabaseHelper._int();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database?> _initDatabase() async {
    // Get the path to the database file
    String path = await getDatabasesPath() + 'chitieu.db';

    // Open the database, creating it if it doesn't exist
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create the chitieu table
        await db.execute('''
          CREATE TABLE chitieu (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            noidung TEXT,
            sotien REAL,
            ghichu TEXT
          )
        ''');
      },
    );
  }
}

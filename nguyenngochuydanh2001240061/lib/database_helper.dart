import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'place_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('place_db_v2.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE places(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        rating REAL,
        phone TEXT,
        address TEXT,
        image TEXT
      )
    ''');

    await _insertSampleData(db);
  }

  Future<void> _insertSampleData(Database db) async {
    final samplePlaces = [
      Place(
        name: 'Hồ Hoàn Kiếm',
        rating: 4.8,
        phone: '02438253631',
        address: 'P. Hàng Trống, Quận Hoàn Kiếm, Hà Nội',
        image: '1.jpg',
      ),
      Place(
        name: 'Chợ Bến Thành',
        rating: 4.5,
        phone: '02838299274',
        address: 'Đường Lê Lợi, P. Bến Thành, Quận 1, TP.HCM',
        image: '2.jpg',
      ),
      Place(
        name: 'Cầu Rồng Đà Nẵng',
        rating: 4.9,
        phone: '02363822201',
        address: 'Đường Nguyễn Văn Linh, P. Phước Ninh, Hải Châu, Đà Nẵng',
        image: '10.jpg',
      ),
      Place(
        name: 'Vịnh Hạ Long',
        rating: 5.0,
        phone: '02033846564',
        address: 'TP. Hạ Long, Tỉnh Quảng Ninh',
        image: '11.jpg',
      ),
      Place(
        name: 'Phố cổ Hội An',
        rating: 4.7,
        phone: '02353861327',
        address: 'TP. Hội An, Tỉnh Quảng Nam',
        image: '12.jpg',
      ),
    ];

    for (final p in samplePlaces) {
      await db.insert('places', p.toMap());
    }
  }

  Future<int> insertPlace(Place place) async {
    final db = await instance.database;
    return await db.insert('places', place.toMap());
  }

  Future<List<Place>> getAllPlaces() async {
    final db = await instance.database;
    final result = await db.query('places', orderBy: 'id DESC');
    return result.map((map) => Place.fromMap(map)).toList();
  }

  Future<int> deletePlace(int id) async {
    final db = await instance.database;
    return await db.delete(
      'places',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }
}

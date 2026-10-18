import '../models/chitieu.dart';
import '../utils/database_helper.dart';

class ChiTieuController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Insert a new chitieu into the database
  Future<void> insertChiTieu(ChiTieu chiTieu) async {
    final db = await _dbHelper.database;
    await db.insert('chitieu', chiTieu.toMap());
  }

  // Update an existing chitieu in the database
  Future<void> updateChiTieu(ChiTieu chiTieu) async {
    final db = await _dbHelper.database;
    await db.update(
      'chitieu',
      chiTieu.toMap(),
      where: 'id = ?',
      whereArgs: [chiTieu.id],
    );
  }

  // Delete a chitieu from the database
  Future<void> deleteChiTieu(int id) async {
    final db = await _dbHelper.database;
    await db.delete('chitieu', where: 'id = ?', whereArgs: [id]);
  }

  // Fetch all chitieu from the database
  Future<List<ChiTieu>> fetchChiTieu() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('chitieu');
    return maps.map((obj) => ChiTieu.fromMap(obj)).toList();
  }
}

import 'package:baitap_tuan9/baitap2/models/user.dart';
import 'package:baitap_tuan9/baitap2/utils/database_helper.dart';

class UserController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<bool> registerUser(User user) async {
    final db = await _dbHelper.database;
    try {
      await db.insert('users', user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> loginUser(String email, String password) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    return maps.isNotEmpty;
  }
}

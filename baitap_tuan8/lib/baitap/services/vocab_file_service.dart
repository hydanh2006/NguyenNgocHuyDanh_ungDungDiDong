import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/vocab.dart';

class VocabFileService {
  Future<String> get _path async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get _file async {
    final path = await _path;
    return File('$path/vocab.txt');
  }

  // Ghi thêm từ mới vào file (dùng chế độ append để không ghi đè dữ liệu cũ)
  Future<void> addVocab(Vocab vocab) async {
    final file = await _file;
    await file.writeAsString(
      vocab.toFileString() + "\n",
      mode: FileMode.append,
    );
  }

  // Đọc danh sách từ vựng
  Future<List<Vocab>> loadVocabs() async {
    try {
      final file = await _file;
      if (!await file.exists()) return [];

      final content = await file.readAsString();
      return content
          .split("\n")
          .where((e) => e.trim().isNotEmpty)
          .map((e) => Vocab.fromString(e))
          .toList();
    } catch (e) {
      return [];
    }
  }
}

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/task_model.dart';

class TaskFileService {
  Future<String> get _path async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get _file async {
    final path = await _path;
    return File('$path/hw_tasks.txt');
  }

  // Lưu toàn bộ danh sách
  Future<void> saveTasks(List<TaskModel> tasks) async {
    final file = await _file;
    String data = tasks.map((e) => e.toFileString()).join("\n");
    await file.writeAsString(data);
  }

  // Tải toàn bộ danh sách
  Future<List<TaskModel>> loadTasks() async {
    try {
      final file = await _file;
      if (!await file.exists()) return [];

      final content = await file.readAsString();
      return content
          .split("\n")
          .where((e) => e.trim().isNotEmpty)
          .map((e) => TaskModel.fromString(e))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
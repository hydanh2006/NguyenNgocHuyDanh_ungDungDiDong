class TaskModel {
  String title;
  DateTime time;
  bool isCompleted;

  TaskModel({
    required this.title,
    required this.time,
    this.isCompleted = false,
  });

  // Chuyển thành chuỗi để lưu file
  String toFileString() {
    return "$title|${time.toIso8601String()}|$isCompleted";
  }

  // Chuyển từ chuỗi sang Object
  static TaskModel fromString(String line) {
    final parts = line.split("|");
    if (parts.length >= 3) {
      return TaskModel(
        title: parts[0],
        time: DateTime.parse(parts[1]),
        isCompleted: parts[2] == 'true',
      );
    }
    return TaskModel(title: "", time: DateTime.now());
  }
}

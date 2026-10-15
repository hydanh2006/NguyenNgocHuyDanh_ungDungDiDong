class Todo {
  String title;
  DateTime time;

  // Khởi tạo
  Todo({required this.title, required this.time});

  // Chuyển đối tượng thành chuỗi string để lưu vào file (ngăn cách bằng dấu |)
  String toFileString() {
    return "$title|${time.toIso8601String()}";
  }

  // Phân tích chuỗi string từ file trở lại thành đối tượng Todo
  static Todo fromString(String line) {
    final parts = line.split("|");
    return Todo(title: parts[0], time: DateTime.parse(parts[1]));
  }
}

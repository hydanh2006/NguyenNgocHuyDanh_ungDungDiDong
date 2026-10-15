import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/todo.dart';
import '../services/file_services.dart';

import 'package:baitap_tuan8/services/notification_service.dart';

class ScreenTodo extends StatefulWidget {
  const ScreenTodo({super.key});

  @override
  State<ScreenTodo> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<ScreenTodo> {
  final TextEditingController controller = TextEditingController();
  final FileService fileService = FileService();

  // Khởi tạo danh sách todo và thời gian chọn

  final NotificationService notificationService = NotificationService();
  List<Todo> todos = [];
  DateTime? selectedTime;

  @override
  void initState() {
    super.initState();
    loadData();
    notificationService.init();
  }

  // Tải dữ liệu từ file khi mở màn hình
  void loadData() async {
    todos = await fileService.loadTodos();
    setState(() {});
  }

  // Xử lý thêm công việc
  void addTodo() async {
    if (controller.text.isEmpty || selectedTime == null) return;

    String taskTitle = controller.text;
    DateTime taskTime = selectedTime!;

    // 1. Tạo và lưu đối tượng công việc xuống file
    final todo = Todo(title: taskTitle, time: taskTime);
    todos.add(todo);
    await fileService.saveTodos(todos);

    // Hiển thị thông báo (ngay tức thì) đã thêm lịch
    notificationService.showSimpleNotification(
      id: DateTime.now().millisecondsSinceEpoch.remainder(
        100000,
      ), // id ngẫu nhiên để không đè
      title: 'Đã lưu công việc!',
      body: 'Công việc "$taskTitle" đã được lên lịch thành công.',
    );

    //  Thiết lập lịch nhắc nhở theo thời gian đã chọn
    notificationService.scheduleNotificationAt(
      taskTime,
      'todo_reminder_channel',
      'Nhắc nhở công việc',
      'Thông báo khi đến thời gian thực hiện Todo',
      taskTitle,
    );

    // 4. Xóa form và cập nhật UI
    controller.clear();
    selectedTime = null;
    setState(() {});
  }

  // Gọi hộp thoại chọn Ngày + Giờ
  void pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time != null) {
        selectedTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
        setState(() {});
      }
    }
  }

  // Định dạng thời gian
  String formatTime(DateTime time) {
    return DateFormat("dd/MM/yyyy HH:mm").format(time);
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Colors.red.shade100,
      Colors.green.shade100,
      Colors.blue.shade100,
      Colors.yellow.shade100,
      Colors.purple.shade100,
    ];

    Color getTextColor(Color bg) {
      return bg.computeLuminance() > 0.5 ? Colors.black87 : Colors.white;
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Todo App"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Ô nhập tên công việc
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Tên công việc",
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Dòng chọn thời gian
            Row(
              children: [
                Expanded(
                  child: Text(
                    selectedTime == null
                        ? "Chưa chọn thời gian"
                        : formatTime(selectedTime!),
                  ),
                ),
                ElevatedButton(
                  onPressed: pickDateTime,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    side: const BorderSide(color: Colors.blue, width: 1.5),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "Chọn thời gian",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Nút Lưu
            ElevatedButton(
              onPressed: addTodo,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.blue, width: 1.5),
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text("Lưu"),
            ),
            const SizedBox(height: 20),

            // Khối hiển thị danh sách công việc
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final t = todos[index];
                  final Color bgColor = colors[index % colors.length];

                  return Card(
                    color: bgColor,
                    child: ListTile(
                      leading: Icon(Icons.task, color: getTextColor(bgColor)),
                      title: Text(
                        t.title,
                        style: TextStyle(
                          color: getTextColor(bgColor),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        formatTime(t.time),
                        style: TextStyle(
                          color: getTextColor(bgColor).withOpacity(0.7),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

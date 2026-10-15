import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task_model.dart';
import '../services/task_file_service.dart';

import 'package:baitap_tuan8/services/notification_service.dart';

import 'screen_add_task.dart';

class ScreenHwTodoList extends StatefulWidget {
  const ScreenHwTodoList({super.key});

  @override
  State<ScreenHwTodoList> createState() => _ScreenHwTodoListState();
}

class _ScreenHwTodoListState extends State<ScreenHwTodoList> {
  final TaskFileService fileService = TaskFileService();
  final NotificationService notificationService = NotificationService();

  List<TaskModel> tasks = [];
  int completedCount = 0; // Đếm số công việc đã xong

  @override
  void initState() {
    super.initState();
    notificationService.init();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await fileService.loadTasks();
    setState(() {
      tasks = data;
    });
  }

  // Chuyển sang màn hình Add, lấy dữ liệu trả về và lưu file
  void _navigateToAddScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ScreenAddTask()),
    );

    if (result != null && result is TaskModel) {
      setState(() {
        tasks.add(result);
      });
      await fileService.saveTasks(tasks);
    }
  }

  // Hàm xử lý đặt thông báo cho công việc
  void _scheduleTaskNotification(TaskModel task) {
    // Lưu ý: Cần thêm logic hàm scheduleNotificationAt vào notification_service.dart (đã HD ở bài 3)
    notificationService.scheduleNotificationAt(
      task.time,
      'hw_todo_channel',
      'Nhắc nhở Nhiệm vụ',
      'Đã đến giờ thực hiện: ${task.title}',
      task.title,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã thiết lập báo thức cho "${task.title}"')),
    );
  }

  // Hàm xử lý hoàn thành nhiệm vụ
  void _completeTask(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận'),
        content: Text(
          'Bạn có chắc chắn đã hoàn thành nhiệm vụ "${tasks[index].title}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Đóng Dialog
              setState(() {
                tasks[index].isCompleted = true; // Đánh dấu hoàn thành
                completedCount++;
                tasks.removeAt(index); // Xóa khỏi danh sách hiển thị
              });

              // Lưu lại file sau khi xóa
              fileService.saveTasks(tasks);

              // Hiển thị Notification báo tổng số công việc hoàn thành
              notificationService.showSimpleNotification(
                id: 888, // ID cố định để thông báo tự update (không nhảy thông báo mới)
                title: 'Nhiệm vụ hoàn thành!',
                body:
                    'Bạn đã hoàn thành tổng cộng $completedCount nhiệm vụ. Giữ vững phong độ nhé!',
              );
            },
            child: const Text('Có'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List - Bài tập về nhà'),
        backgroundColor: Colors.blue,
      ),
      body: tasks.isEmpty
          ? const Center(child: Text("Không có nhiệm vụ nào. Hãy thêm mới!"))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  color: Colors.blue.shade50,
                  child: ListTile(
                    // Icon hoàn thành (Check)
                    leading: IconButton(
                      icon: const Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.blue,
                      ),
                      onPressed: () => _completeTask(index),
                    ),
                    title: Text(
                      task.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy - HH:mm').format(task.time),
                    ),

                    // Icon cái chuông để Set Notification
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.notifications_active,
                        color: Colors.orange,
                      ),
                      onPressed: () => _scheduleTaskNotification(task),
                    ),
                  ),
                );
              },
            ),

      // Nút Floating bấm để Thêm mới (Giống hình mẫu)
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddScreen,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task_model.dart';

class ScreenAddTask extends StatefulWidget {
  const ScreenAddTask({super.key});

  @override
  State<ScreenAddTask> createState() => _ScreenAddTaskState();
}

class _ScreenAddTaskState extends State<ScreenAddTask> {
  final TextEditingController titleController = TextEditingController();
  DateTime? selectedTime;

  // Gọi hộp thoại chọn Ngày + Giờ
  void _pickDateTime() async {
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
        setState(() {
          selectedTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
        });
      }
    }
  }

  // Hàm Lưu
  void _saveTask() {
    if (titleController.text.isEmpty || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập tên công việc và thời gian!')),
      );
      return;
    }

    final newTask = TaskModel(title: titleController.text, time: selectedTime!);
    
    // Đóng màn hình và trả dữ liệu về màn hình chính
    Navigator.pop(context, newTask); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thêm nhiệm vụ mới')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Tên nhiệm vụ',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    selectedTime == null
                        ? "Chưa thiết lập thời gian"
                        : "Thời gian: ${DateFormat('dd/MM/yyyy HH:mm').format(selectedTime!)}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _pickDateTime,
                  icon: const Icon(Icons.access_time),
                  label: const Text('Chọn thời gian'),
                )
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _saveTask,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                child: const Text('Lưu nhiệm vụ', style: TextStyle(fontSize: 18)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
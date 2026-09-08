import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DoAnScreen(),
    );
  }
}

class DoAnScreen extends StatelessWidget {
  const DoAnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        leading: const Icon(Icons.home, color: Colors.black),
        title: const Text(
          'Thông tin đồ án',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoText('Mã đề tài: DT09', Colors.red),
            _buildInfoText('Tên đề tài: Ứng dụng quản lý chi tiêu', Colors.red),
            _buildInfoText('Số lượng sv: 3', Colors.red),
            _buildInfoText('Chuyên ngành: Công nghệ phần mềm', Colors.red),
            _buildInfoText('Giảng viên hướng dẫn: GV Đỗ Gia Bảo', Colors.red),
            _buildInfoText(
              'Yêu cầu đề tài: Xây dựng được một ứng dụng hoàn chỉnh với UI và các chức năng mượt mà, linh hoạt,....',
              Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoText(
    String text,
    Color color, {
    FontWeight weight = FontWeight.bold,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: weight, color: color),
      ),
    );
  }
}

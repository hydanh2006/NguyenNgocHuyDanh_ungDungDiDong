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
      home: TeamInfoScreen(),
    );
  }
}

class TeamInfoScreen extends StatelessWidget {
  const TeamInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        leading: const Icon(Icons.home, color: Colors.black),
        title: const Text(
          'Thông tin nhóm',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoText('Mã nhóm: 012', Colors.black),
                  _buildInfoText('Tên nhóm: nhóm 12', Colors.black),
                  _buildInfoText('Số lượng thành viên: 3', Colors.black),
                ],
              ),
            ),

            const SizedBox(width: 30),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoText(
                    'Thành viên 1:',
                    const Color.fromARGB(255, 17, 187, 74),
                  ),
                  _buildInfoText('Mã sinh viên: 2001240001', Colors.black),
                  _buildInfoText('Tên sinh viên: Danh', Colors.black),
                  _buildInfoText('Vai trò: thành viên', Colors.black),
                  const SizedBox(height: 15),
                  _buildInfoText(
                    'Thành viên 2:',
                    const Color.fromARGB(255, 17, 187, 74),
                  ),
                  _buildInfoText('Mã sinh viên: 2001240002', Colors.black),
                  _buildInfoText('Tên sinh viên: Tân', Colors.black),
                  _buildInfoText('Vai trò: nhóm trưởng', Colors.red),
                  const SizedBox(height: 15),
                  _buildInfoText(
                    'Thành viên 3:',
                    const Color.fromARGB(255, 17, 187, 74),
                  ),
                  _buildInfoText('Mã sinh viên: 2001240003', Colors.black),
                  _buildInfoText('Tên sinh viên: Thông', Colors.black),
                  _buildInfoText('Vai trò: thành viên', Colors.black),
                ],
              ),
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

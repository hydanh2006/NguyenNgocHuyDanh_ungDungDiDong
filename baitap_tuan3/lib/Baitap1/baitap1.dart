import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TeacherProfileScreen(),
    );
  }
}

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 34, 110, 224),
        leading: const Icon(Icons.home, color: Colors.black54),
        title: const Text(
          'Thông tin sinh viên',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/h1.jpg',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30),

            _buildInfoText(
              'Họ và tên: Nguyễn Văn A',
              const Color.fromARGB(255, 54, 24, 121)!,
            ),
            _buildInfoText('MSSV: 2001221234', Colors.red),
            _buildInfoText('Lớp: 13DHTH02', Colors.red),
            _buildInfoText('Khóa: 13 Đại học', Colors.red),
            _buildInfoText('Ngành: Công nghệ thông tin', Colors.red),
            _buildInfoText(
              'Trường: Đại học Công Thương\nThành phố Hồ Chí Minh',
              Colors.red,
              weight: FontWeight.normal,
            ),

            const Spacer(),

            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[50],
                  foregroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                  elevation: 0,
                ),
                child: const Text('Trở về', style: TextStyle(fontSize: 16)),
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

class TeacherProfileScreen extends StatelessWidget {
  const TeacherProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 170, 193, 42),
        leading: const Icon(Icons.home, color: Colors.black54),
        title: const Text(
          'Thông tin giảng viên',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/h2.jpg',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30),

            _buildInfoText(
              'Giảng viên Trần Thị A',
              const Color.fromARGB(255, 54, 24, 121)!,
            ),
            _buildInfoText('Khoa: Công nghệ thông tin', Colors.red),
            _buildInfoText('Học hàm: Thạc sỹ', Colors.red),
            _buildInfoText(
              'Chuyên ngành: CNPM',
              const Color.fromARGB(255, 54, 244, 127),
            ),
            _buildInfoText(
              'Giảng dạy: Nhập môn lập trình, Lập trình Windows, Lập trình we',
              Colors.red,
            ),

            const Spacer(),

            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[50],
                  foregroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                  elevation: 0,
                ),
                child: const Text('Trở về', style: TextStyle(fontSize: 16)),
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

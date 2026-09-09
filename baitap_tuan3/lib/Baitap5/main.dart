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
      home: NganhInfoScreen(),
    );
  }
}

class NganhInfoScreen extends StatelessWidget {
  const NganhInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        leading: const Icon(Icons.home, color: Colors.black),
        title: const Text(
          'Đại học Công Thương Thành phố Hồ Chí Minh',
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
                  _buildMajorCard(
                    title: 'Ngành Công nghệ Thông tin',
                    icon: Icons.computer,
                    iconColor: Colors.blue,
                    content:
                        '• Mã ngành: 7480201\n'
                        '• Tổ hợp xét tuyển: A00, A01, D01, D07\n\n'
                        'Đào tạo kỹ sư có kiến thức chuyên sâu về công nghệ phần mềm, '
                        'hệ thống thông tin, mạng máy tính và trí tuệ nhân tạo. '
                        'Sinh viên ra trường có thể đảm nhận các vị trí như lập trình viên '
                        '(Web, Mobile, Desktop), kỹ sư kiểm thử (Tester), hoặc quản trị '
                        'hệ thống mạng tại các doanh nghiệp.',
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            const SizedBox(width: 30),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMajorCard(
                    title: 'Ngành An toàn Thông tin',
                    icon: Icons.security,
                    iconColor: Colors.green,
                    content:
                        '• Mã ngành: 7480202\n'
                        '• Tổ hợp xét tuyển: A00, A01, D01, D07\n\n'
                        'Trang bị cho sinh viên kỹ năng bảo vệ dữ liệu, phòng chống '
                        'tấn công mạng, và đánh giá rủi ro an ninh hệ thống. '
                        'Định hướng nghề nghiệp đa dạng: chuyên viên bảo mật cơ sở hạ tầng, '
                        'chuyên gia phân tích mã độc, hacker mũ trắng (Penetration Tester) '
                        'tại các ngân hàng, tập đoàn công nghệ.',
                  ),
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

  Widget _buildMajorCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required String content,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 32, color: iconColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: iconColor,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24, thickness: 1),
            Text(
              content,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}

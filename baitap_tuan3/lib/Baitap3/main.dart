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
      home: SanPhamInfoScreen(),
    );
  }
}

class SanPhamInfoScreen extends StatelessWidget {
  const SanPhamInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        leading: const Icon(Icons.home, color: Colors.black),
        title: const Text(
          'Thông tin sản phẩm',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/ao1.jpg',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 15),
                Image.asset(
                  'assets/images/ao2.jpg',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/images/ao3.jpg',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoText('Mã SP LUX101', Colors.black),
                _buildInfoText('Tên SP: Áo Thun MixiGaming', Colors.black),
                _buildInfoText('Nhà SX: MixiShop', Colors.black),
                _buildInfoText('Giá bán: 280.000 VNĐ', Colors.red),
                _buildInfoText(
                  'Mô tả SP: Áo Thun Độ Mixi Mixi Gaming Áo Phông Form Rộng Nam Nữ Unisex Chất Cotton Cổ Tròn Tay Lỡ LUX101',
                  Colors.blueAccent,
                ),
              ],
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

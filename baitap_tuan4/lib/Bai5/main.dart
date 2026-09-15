import 'package:flutter/material.dart';

void main() {
  runApp(const UngDungKhamBenh());
}

class UngDungKhamBenh extends StatelessWidget {
  const UngDungKhamBenh({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFF3F4F6)),
      home: const ManHinhKhamBenh(),
    );
  }
}

class ManHinhKhamBenh extends StatelessWidget {
  const ManHinhKhamBenh({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 15.0),
          children: [
            _taoPhanDau(),
            const SizedBox(height: 30),
            _taoBangThongBao(),
            const SizedBox(height: 25),
            _taoThanhTimKiem(),
            const SizedBox(height: 25),
            _taoDanhSachChuyenKhoa(),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Doctor list',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            _taoDanhSachBacSi(),
          ],
        ),
      ),
    );
  }

  Widget _taoPhanDau() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello,',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 4),
            Text(
              'Danh',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFDCD2F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.person, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _taoBangThongBao() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF9A8D4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFFB19CD9),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'How do you feel?',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Fill out your medical card right now',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87.withOpacity(0.7),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B5CF6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _taoThanhTimKiem() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFDCD2F5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.black54),
          const SizedBox(width: 12),
          Text(
            'How can we help you?',
            style: TextStyle(
              color: Colors.black54.withOpacity(0.7),
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _taoDanhSachChuyenKhoa() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _taoNutChuyenKhoa(Icons.coronavirus_outlined, 'Dentist'),
          const SizedBox(width: 14),
          _taoNutChuyenKhoa(Icons.medical_services_outlined, 'Surgeon'),
          const SizedBox(width: 14),
          _taoNutChuyenKhoa(Icons.medication_liquid, 'Therapist'),
        ],
      ),
    );
  }

  Widget _taoNutChuyenKhoa(IconData icon, String tenKhoa) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFDCD2F5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black87, size: 22),
          const SizedBox(width: 10),
          Text(
            tenKhoa,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _taoDanhSachBacSi() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _taoTheBacSi(
            'Dr. Mitch Koko',
            'Psychologist 7 y.e.',
            '4.4',
            const Color(0xFFF43F5E),
          ),
          const SizedBox(width: 16),
          _taoTheBacSi(
            'Dr. Steve Jobs',
            'Surgeon 7 y.e.',
            '5.0',
            const Color(0xFF3B82F6),
          ),
        ],
      ),
    );
  }

  Widget _taoTheBacSi(String ten, String chucVu, String danhGia, Color mauNen) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFDCD2F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(color: mauNen, shape: BoxShape.circle),
            child: const Icon(Icons.person, size: 45, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(
                  danhGia,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            ten,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            chucVu,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black87.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

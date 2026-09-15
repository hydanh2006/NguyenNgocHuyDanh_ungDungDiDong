import 'package:flutter/material.dart';

void main() {
  runApp(const UngDungNgheNhac());
}

class UngDungNgheNhac extends StatelessWidget {
  const UngDungNgheNhac({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ManHinhNgheNhac(),
    );
  }
}

class ManHinhNgheNhac extends StatelessWidget {
  const ManHinhNgheNhac({super.key});

  final Color mauNen = const Color(0xFFE0E5EC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mauNen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _taoKhoiNoi(
                    padding: const EdgeInsets.all(12),
                    borderRadius: 12,
                    child: const Icon(Icons.arrow_back, color: Colors.black54),
                  ),
                  const Text(
                    'PLAYLIST',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.5,
                      color: Colors.black54,
                    ),
                  ),
                  _taoKhoiNoi(
                    padding: const EdgeInsets.all(12),
                    borderRadius: 12,
                    child: const Icon(Icons.menu, color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              _taoKhoiNoi(
                padding: const EdgeInsets.all(8),
                borderRadius: 20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: double.infinity,
                    height: 320,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFF9A8D4), Color(0xFFF43F5E)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Icon(
                      Icons.music_note_rounded,
                      size: 100,
                      color: Colors.white54,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kota The Friend',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Birdie',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.favorite, color: Colors.redAccent, size: 32),
                ],
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '0:00',
                    style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600),
                  ),
                  const Icon(Icons.shuffle, color: Colors.black54, size: 20),
                  const Icon(Icons.repeat, color: Colors.black54, size: 20),
                  Text(
                    '4:22',
                    style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Stack(
                children: [
                  Container(
                    height: 10,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(1, 1),
                          blurRadius: 2,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-1, -1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 10,
                    width: 220,
                    decoration: BoxDecoration(
                      color: Colors.green[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _taoKhoiNoi(
                    padding: const EdgeInsets.all(20),
                    borderRadius: 20,
                    child: const Icon(Icons.skip_previous, color: Colors.black54, size: 28),
                  ),
                  _taoKhoiNoi(
                    padding: const EdgeInsets.all(24),
                    borderRadius: 20,
                    child: const Icon(Icons.play_arrow, color: Colors.black87, size: 34),
                  ),
                  _taoKhoiNoi(
                    padding: const EdgeInsets.all(20),
                    borderRadius: 20,
                    child: const Icon(Icons.skip_next, color: Colors.black54, size: 28),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _taoKhoiNoi({
    required Widget child,
    required double borderRadius,
    required EdgeInsetsGeometry padding,
  }) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: mauNen,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400]!,
            offset: const Offset(5, 5),
            blurRadius: 10,
            spreadRadius: 1,
          ),
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-5, -5),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}
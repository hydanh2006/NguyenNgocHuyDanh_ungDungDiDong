import 'package:flutter/material.dart';

void main() {
  runApp(const UngDungViDienTu());
}

class UngDungViDienTu extends StatelessWidget {
  const UngDungViDienTu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFF2F4F7)),
      home: const GiaoDienViDienTu(),
    );
  }
}

class GiaoDienViDienTu extends StatelessWidget {
  const GiaoDienViDienTu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'My ',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        TextSpan(
                          text: 'Cards',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              _taoTheNganHang(),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _taoDauCham(true),
                  const SizedBox(width: 6),
                  _taoDauCham(false),
                  const SizedBox(width: 6),
                  _taoDauCham(false),
                ],
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _taoNutChucNang(
                    Icons.send_rounded,
                    Colors.green[600]!,
                    'Send',
                  ),
                  _taoNutChucNang(Icons.credit_card, Colors.blue[600]!, 'Pay'),
                  _taoNutChucNang(
                    Icons.receipt_long,
                    Colors.orange[600]!,
                    'Bills',
                  ),
                ],
              ),
              const SizedBox(height: 35),
              _taoMucTuyChon(
                Icons.bar_chart_rounded,
                Colors.deepPurple,
                'Statistics',
                'Payment and Income',
              ),
              const SizedBox(height: 16),
              _taoMucTuyChon(
                Icons.swap_horiz_rounded,
                Colors.teal,
                'Transactions',
                'Transaction History',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.pinkAccent,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(Icons.attach_money, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _taoDauCham(bool dangChon) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: dangChon ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: dangChon ? Colors.grey[800] : Colors.grey[400],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _taoTheNganHang() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8E54E9), Color(0xFF4776E6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8E54E9).withOpacity(0.35),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Balance',
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '\$5250.25',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '1234 5678',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                  letterSpacing: 2,
                ),
              ),
              Text(
                '10/24',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _taoNutChucNang(IconData bieuTuong, Color mauSac, String nhan) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(bieuTuong, size: 30, color: mauSac),
        ),
        const SizedBox(height: 12),
        Text(
          nhan,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _taoMucTuyChon(
    IconData bieuTuong,
    Color mauNen,
    String tieuDe,
    String phuDe,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: mauNen.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(bieuTuong, color: mauNen, size: 28),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tieuDe,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  phuDe,
                  style: TextStyle(fontSize: 13.5, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black45),
        ],
      ),
    );
  }
}

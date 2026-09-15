import 'package:flutter/material.dart';

void main() {
  runApp(const UngDungMayTinhApp());
}

class UngDungMayTinhApp extends StatelessWidget {
  const UngDungMayTinhApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF3F3F3),
      ),
      home: const GiaoDienMayTinh(),
    );
  }
}

class GiaoDienMayTinh extends StatelessWidget {
  const GiaoDienMayTinh({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F3F3),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text(
          'Standard',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.aspect_ratio, size: 20),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.history, size: 22),
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: _taoMenuTruot(context),
      body: Column(
        children: [
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.only(right: 16, bottom: 8, top: 20),
            height: 140,
            child: const Text(
              '0',
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['MC', 'MR', 'M+', 'M-', 'MS', 'Mv']
                  .map((chu) => Text(
                        chu,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: (chu == 'MC' || chu == 'MR')
                              ? Colors.grey[400]
                              : Colors.black87,
                        ),
                      ))
                  .toList(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                childAspectRatio: 1.2,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  '%', 'CE', 'C', '⌫',
                  '1/x', 'x²', '√x', '÷',
                  '7', '8', '9', '×',
                  '4', '5', '6', '-',
                  '1', '2', '3', '+',
                  '+/-', '0', '.', '=',
                ].map((nhan) => _taoPhimBam(nhan)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _taoPhimBam(String nhan) {
    Color mauNen = Colors.white;
    Color mauChu = Colors.black87;
    double kichThuocChu = 20;
    FontWeight doDam = FontWeight.w500;

    if (nhan == '=') {
      mauNen = Colors.blue[700]!;
      mauChu = Colors.white;
    } else if (['%', 'CE', 'C', '⌫', '1/x', 'x²', '√x', '÷', '×', '-', '+'].contains(nhan)) {
      mauNen = const Color(0xFFF9F9F9);
    }

    if (['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].contains(nhan)) {
      kichThuocChu = 22;
      doDam = FontWeight.w600;
    }

    return Container(
      decoration: BoxDecoration(
        color: mauNen,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(5),
          child: Center(
            child: Text(
              nhan,
              style: TextStyle(
                fontSize: kichThuocChu,
                fontWeight: doDam,
                color: mauChu,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _taoMenuTruot(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFF3F3F3),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16, bottom: 8, top: 10),
                    child: Text(
                      'Calculator',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  _taoMucMenu(Icons.calculate_outlined, 'Standard', dangChon: true),
                  _taoMucMenu(Icons.science_outlined, 'Scientific'),
                  _taoMucMenu(Icons.show_chart, 'Graphing'),
                  _taoMucMenu(Icons.data_object, 'Programmer'),
                  _taoMucMenu(Icons.calendar_today, 'Date calculation'),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(height: 24, thickness: 1),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16, bottom: 8),
                    child: Text(
                      'Converter',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  _taoMucMenu(Icons.currency_exchange, 'Currency'),
                  _taoMucMenu(Icons.view_in_ar, 'Volume'),
                  _taoMucMenu(Icons.straighten, 'Length'),
                  _taoMucMenu(Icons.scale, 'Weight and mass'),
                  _taoMucMenu(Icons.thermostat, 'Temperature'),
                  _taoMucMenu(Icons.local_fire_department_outlined, 'Energy'),
                  _taoMucMenu(Icons.grid_on, 'Area'),
                  _taoMucMenu(Icons.speed, 'Speed'),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1),
            _taoMucMenu(Icons.settings_outlined, 'Settings'),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _taoMucMenu(IconData icon, String tieuDe, {bool dangChon = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      decoration: BoxDecoration(
        color: dangChon ? Colors.black.withOpacity(0.06) : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black87, size: 20),
        title: Text(
          tieuDe,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        dense: true,
        visualDensity: const VisualDensity(vertical: -2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        onTap: () {},
      ),
    );
  }
}
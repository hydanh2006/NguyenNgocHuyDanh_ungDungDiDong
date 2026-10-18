import 'package:flutter/material.dart';

import '../controllers/chitieu_controller.dart';
import '../models/chitieu.dart';

class ChiTieuScreen extends StatefulWidget {
  @override
  _ChiTieuScreenState createState() => _ChiTieuScreenState();
}

class _ChiTieuScreenState extends State<ChiTieuScreen> {
  List<ChiTieu> _danhSachChiTieu = [];
  final ChiTieuController _chiTieuController = ChiTieuController();

  final noidungController = TextEditingController();
  final sotienController = TextEditingController();
  final ghichuController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchDanhSachChiTieu();
  }

  Future<void> _fetchDanhSachChiTieu() async {
    final danhSach = await _chiTieuController.fetchChiTieu();
    setState(() {
      _danhSachChiTieu = danhSach;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.titleMedium!;
    return Scaffold(
      appBar: AppBar(title: Text('Quản lý chi tiêu')),
      body: Padding(
        padding: EdgeInsets.only(
          top: 15.0,
          bottom: 15.0,
          left: 10.0,
          right: 10.0,
        ),
        child: Column(
          children: [
            TextField(
              controller: noidungController,
              decoration: InputDecoration(
                labelText: 'Nội dung chi tiêu',
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: sotienController,
              decoration: InputDecoration(
                labelText: 'Số tiền',
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: ghichuController,
              decoration: InputDecoration(
                labelText: 'Ghi chú',
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Add chitieu logic
                      double sotien =
                          double.tryParse(sotienController.text) ?? 0;
                      ChiTieu newChiTieu = ChiTieu(
                        // id: auto increment trong database
                        noidung: noidungController.text,
                        sotien: sotien,
                        ghichu: ghichuController.text,
                      );
                      _chiTieuController.insertChiTieu(newChiTieu).then((_) {
                        _fetchDanhSachChiTieu();
                        noidungController.clear();
                        sotienController.clear();
                        ghichuController.clear();
                      });
                    },
                    child: Text('Add'),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Delete chitieu logic: xóa mục cuối cùng giống trong file
                      if (_danhSachChiTieu.isNotEmpty) {
                        ChiTieu lastChiTieu = _danhSachChiTieu.last;
                        _chiTieuController.deleteChiTieu(lastChiTieu.id!).then((
                          _,
                        ) {
                          _fetchDanhSachChiTieu();
                        });
                      }
                    },
                    child: Text("Delete Last"),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _danhSachChiTieu.length,
                itemBuilder: (context, index) {
                  final chitieu = _danhSachChiTieu[index];
                  return Card(
                    elevation: 2.0,
                    child: ListTile(
                      title: Text(chitieu.noidung),
                      subtitle: Text(
                        'Số tiền: ${chitieu.sotien} \nGhi chú: ${chitieu.ghichu}',
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Đẩy dữ liệu lên TextFields khi nhấn nút edit giống trong tài liệu
                          noidungController.text = chitieu.noidung;
                          sotienController.text = chitieu.sotien.toString();
                          ghichuController.text = chitieu.ghichu;
                        },
                      ),
                      onTap: () {
                        noidungController.text = chitieu.noidung;
                        sotienController.text = chitieu.sotien.toString();
                        ghichuController.text = chitieu.ghichu;
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

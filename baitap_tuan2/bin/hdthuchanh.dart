import 'package:baitap_tuan2/SanPham.dart';
import 'package:baitap_tuan2/NhanVien.dart';
import 'package:baitap_tuan2/CanBo.dart';

import 'dart:io';

void main() async {
  // Bài 1
  // SanPham sp = SanPham();
  // sp.showInfo();
  // SanPham sp1 = SanPham.fullPara('SP001', 'Bánh gạo Nhật', 25000, 0);
  // sp1.showInfo();
  // List<SanPham> lstSanPham = [];
  // SanPham sp2 = SanPham.fullPara('SP002', 'Trà ô long', 75000, 0);
  // SanPham sp3 = SanPham.fullPara('SP003', 'Mứt xoài sấy', 45000, 0);
  // lstSanPham.add(sp1);
  // lstSanPham.add(sp2);
  // lstSanPham.add(sp3);
  // print("Danh sách sản phẩm là: ");
  // for (SanPham a in lstSanPham) {
  //   a.showInfo();
  // }

  // Bài 2
  // NhanVien nv = NhanVien.fullPara(
  //   "NV001",
  //   "Nguyễn Trần Tuấn",
  //   2.34,
  //   "Tổ chức",
  //   23,
  // );
  // CanBo cb = CanBo.fullPara(
  //   'NV002',
  //   'Trần Văn Bình',
  //   2.34,
  //   "Tổ chức",
  //   26,
  //   "Trưởng phòng",
  //   2.0,
  // );

  // NhanVien nv3 = NhanVien.fullPara("NV003", "Nguyễn Nam", 2.34, "Nhân sự", 27);
  // List<NhanVien> lstNhanVien = [];
  // lstNhanVien.add(nv);
  // lstNhanVien.add(cb);
  // lstNhanVien.add(nv3);
  // print("Danh sách nhân viên và cán bộ: ");
  // for (NhanVien x in lstNhanVien) {
  //   print(x);
  // }

  // List<NhanVien> lstLoaiA = lstNhanVien
  //     .where((a) => a.xepLoai() == "A")
  //     .toList();
  // print('Danh sách nhân viên và cán bộ xếp loại A:');
  // for (NhanVien x in lstLoaiA) {
  //   print(x);
  // }
  // double tongLuong = lstNhanVien.fold(0, (sum, nv) => sum + nv.tinhLuong());
  // print("Tổng lương của nhân viên và cán bộ:$tongLuong");
  // lstNhanVien.sort((x, y) => x.tinhLuong().compareTo(y.tinhLuong()));
  // print("Danh sách sau khi sắp xếp tăng dần theo lương là:");
  // for (NhanVien x in lstNhanVien) {
  //   print(x);
  // }

  // Bài 3
  Future<List<SanPham>> readFile(String fileName) async {
    List<SanPham> arrs = [];
    try {
      List<String> lines = await File(fileName).readAsLines();
      for (String line in lines) {
        if (line.trim().isEmpty) continue;
        List<String> parts = line.split('#');
        if (parts.length == 4) {
          String masp = parts[0].trim();
          String tensp = parts[1].trim();
          double giaban = double.parse(parts[2].trim());
          double giamgia = double.parse(parts[3].trim());
          if (masp.isNotEmpty && tensp.isNotEmpty) {
            arrs.add(SanPham.fullPara(masp, tensp, giaban, giamgia));
          }
        }
      }
    } catch (e) {
      print("Lỗi đọc file: $e");
    }
    return arrs;
  }

  List<SanPham> ds = await readFile('lib/sanpham.txt');
  print("Đọc dữ liệu từ file: ");
  for (SanPham x in ds) {
    x.showInfo();
  }
}

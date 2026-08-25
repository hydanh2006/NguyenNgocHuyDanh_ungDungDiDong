import 'dart:io';

import 'package:baitap_tuan2/Phong.dart';

void main(List<String> args) async {
  Future<List<Phong>> readFile(String fileName) async {
    List<Phong> lstPhong = [];
    try {
      List<String> lines = await File(fileName).readAsLines();
      for (String line in lines) {
        if (line.trim().isEmpty) continue;
        List<String> parts = line.split('#');
        if (parts.length >= 5) {
          String maP = parts[0].trim();
          int soNguoi = int.parse(parts[1].trim());
          double soDien = double.parse(parts[2].trim());
          double soNuoc = double.parse(parts[3].trim());
          if (maP.startsWith("A") && parts.length == 5) {
            int soNguoiThan = int.parse(parts[4].trim());
            lstPhong.add(
              PhongA.fullPara(maP, soNguoi, soDien, soNuoc, soNguoiThan),
            );
          } else if (maP.startsWith('B') && parts.length == 6) {
            double giatUi = double.parse(parts[4].trim());
            int soMay = int.parse(parts[5].trim());
            lstPhong.add(
              PhongB.fullPara(maP, soNguoi, soDien, soNuoc, giatUi, soMay),
            );
          }
        }
      }
    } catch (e) {
      print("Lỗi đọc file: $e");
    }
    return lstPhong;
  }

  List<Phong> ds = await readFile('lib/phongthue.txt');
  print('Danh sách phòng thuê: ');
  for (Phong p in ds) {
    p.showInfo();
  }
  //In ra danh sách các phòng có số người thuê lớn hơn 2.
  print('\nDanh sách các phòng có số người thuê lớn hơn 2.: ');
  for (Phong p in ds) {
    if (p.soNguoi > 2) p.showInfo();
  }

  //Tính tổng tiền phòng thu được từ các phòng.
  double tong = 0.0;
  for (Phong p in ds) {
    tong += p.tinhTien();
  }
  print("Tổng tiền thu được từ tất cả các phòng: $tong");

  //Sắp xếp danh sách phòng thuê theo thứ tự giảm dần của số điện tiêu thụ.
  ds.sort((a, b) => b.soDien.compareTo(a.soDien));
  print('\nDanh sách phòng thuê theo thứ tự giảm dần của số điện tiêu thụ:');
  for (Phong p in ds) {
    p.showInfo();
  }

  //In ra màn hình danh sách các phòng loại A.
  print('\nDanh sách các phòng loại A:');
  for (Phong p in ds) {
    if (p.maP.startsWith('A')) p.showInfo();
  }
}

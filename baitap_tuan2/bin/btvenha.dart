import 'package:baitap_tuan2/HoaDon.dart';

import 'dart:io';

void main() {
  QuanLyHoaDon ql = QuanLyHoaDon();

  while (true) {
    print("\n" + "=" * 40);
    print("   QUẢN LÝ HÓA ĐƠN CÔNG TY ABC");
    print("=" * 40);
    print("1. Nhập danh sách hóa đơn");
    print("2. Xuất danh sách hóa đơn");
    print("3. Tính tổng thành tiền & trợ giá");
    print("4. Thông tin khách hàng mua nhiều nhất");
    print("5. Tổng chiết khấu của khách hàng Công ty");
    print("6. Sắp xếp danh sách (SL tăng dần, Tiền giảm dần)");
    print("7. Tìm kiếm hóa đơn theo Mã khách hàng");
    print("0. Thoát chương trình");
    print("=" * 40);

    stdout.write("Chọn chức năng: ");
    String chon = stdin.readLineSync() ?? "";

    switch (chon) {
      case '1':
        ql.nhapDanhSach();
        break;
      case '2':
        ql.xuatDanhSach();
        break;
      case '3':
        ql.tinhTongThanhTien();
        ql.tinhTongTroGia();
        break;
      case '4':
        ql.khachHangMuaNhieuNhat();
        break;
      case '5':
        ql.tongChietKhauCongTy();
        break;
      case '6':
        ql.sapXepDanhSach();
        ql.xuatDanhSach();
        break;
      case '7':
        stdout.write("Nhập mã KH cần tìm: ");
        String ma = stdin.readLineSync() ?? "";
        ql.timHoaDonTheoMa(ma);
        break;
      case '0':
        print("Đã thoát chương trình.");
        return;
      default:
        print("Lựa chọn không hợp lệ!");
    }
  }
}

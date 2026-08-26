import 'dart:io';
import 'dart:math';

abstract class HoaDon {
  String _maKH = "KH0000";
  String _tenKH = "Chưa có tên";
  int _soLuong = 1;
  double _giaBan = 1.0;
  HoaDon();
  HoaDon.fullPara(String ma, String ten, int sl, double gia) {
    maKH = ma;
    tenKH = ten;
    soLuong = sl;
    giaBan = gia;
  }
  String get maKH => _maKH;
  set maKH(String value) {
    if (RegExp(r'^KH\d{4}$').hasMatch(value)) {
      _maKH = value;
    } else {
      throw FormatException("Lỗi: Mã KH sai định dạng (VD chuẩn: KH0002).");
    }
  }
  String get tenKH => _tenKH;
  set tenKH(String value) {
    if (value.trim().isEmpty) throw FormatException("Lỗi: Tên KH không được rỗng.");
    _tenKH = value;
  }
  int get soLuong => _soLuong;
  set soLuong(int value) {
    if (value <= 0) throw FormatException("Lỗi: Số lượng phải > 0.");
    _soLuong = value;
  }
  double get giaBan => _giaBan;
  set giaBan(double value) {
    if (value <= 0) throw FormatException("Lỗi: Giá bán phải > 0.");
    _giaBan = value;
  }
  double tinhChietKhau();
  double tinhTroGia();
  double tinhThanhTien() {
    double vat = 0.1 * (soLuong * giaBan);
    return (soLuong * giaBan) - tinhChietKhau() + vat;
  }
  void nhap() {
    while (true) {
      try {
        stdout.write("Nhập mã khách hàng (KHxxxx): ");
        maKH = stdin.readLineSync() ?? "";
        stdout.write("Nhập tên khách hàng: ");
        tenKH = stdin.readLineSync() ?? "";
        stdout.write("Nhập số lượng: ");
        soLuong = int.parse(stdin.readLineSync() ?? "0");
        stdout.write("Nhập giá bán: ");
        giaBan = double.parse(stdin.readLineSync() ?? "0");
        break;
      } catch (e) {
        print(e.toString());
        print("Vui lòng nhập lại thông tin cho chính xác!\n");
      }
    }
  }
  void xuat() {
    print("Mã KH: $maKH | Tên: $tenKH | Số lượng: $soLuong | Giá bán: $giaBan");
    print("-> Chiết khấu: ${tinhChietKhau()} | Trợ giá: ${tinhTroGia()}");
    print("-> THÀNH TIỀN: ${tinhThanhTien()}");
  }
}

class CaNhan extends HoaDon {
  double khoangCach = 0;

  CaNhan() : super();
  CaNhan.fullPara(String ma, String ten, int sl, double gia, this.khoangCach)
      : super.fullPara(ma, ten, sl, gia);

  @override
  void nhap() {
    super.nhap();
    stdout.write("Nhập khoảng cách giao hàng (km): ");
    khoangCach = double.parse(stdin.readLineSync() ?? "0");
  }

  @override
  double tinhChietKhau() {
    double ck = 0;
    if (soLuong >= 3) {
      ck = 0.05 * giaBan * soLuong;
    }
    if (khoangCach < 10) {
      ck += 50000 * soLuong;
    }
    return ck;
  }

  @override
  double tinhTroGia() {
    double tg = 0.02 * giaBan * soLuong;
    if (soLuong > 2) tg += 100000;
    return tg;
  }

  @override
  void xuat() {
    print("--- [CÁ NHÂN] ---");
    super.xuat();
    print("Khoảng cách: $khoangCach km\n");
  }
}

class DaiLy extends HoaDon {
  int thoiGianHopTac = 0;

  DaiLy() : super();
  DaiLy.fullPara(String ma, String ten, int sl, double gia, this.thoiGianHopTac)
      : super.fullPara(ma, ten, sl, gia);

  @override
  void nhap() {
    super.nhap();
    stdout.write("Nhập thời gian hợp tác (năm): ");
    thoiGianHopTac = int.parse(stdin.readLineSync() ?? "0");
  }

  @override
  double tinhChietKhau() {
    double phanTram = 30;
    if (thoiGianHopTac > 5) {
      phanTram += (thoiGianHopTac - 5);
    }
    if (phanTram > 35) phanTram = 35;
    return (phanTram / 100) * (soLuong * giaBan);
  }

  @override
  double tinhTroGia() => 0;

  @override
  void xuat() {
    print("--- [ĐẠI LÝ] ---");
    super.xuat();
    print("Thời gian hợp tác: $thoiGianHopTac năm\n");
  }
}

class CongTy extends HoaDon {

  int soNhanVien = 0;

  CongTy() : super();
  CongTy.fullPara(String ma, String ten, int sl, double gia, this.soNhanVien)
      : super.fullPara(ma, ten, sl, gia);

  @override
  void nhap() {
    super.nhap();
    stdout.write("Nhập số lượng nhân viên: ");
    soNhanVien = int.parse(stdin.readLineSync() ?? "0");
  }

  @override
  double tinhChietKhau() {
    if (soNhanVien > 5000) return 0.07 * soLuong * giaBan;
    if (soNhanVien > 1000) return 0.05 * soLuong * giaBan;
    return 0;
  }

  @override
  double tinhTroGia() => 120000.0 * soLuong;

  @override
  void xuat() {
    print("--- [CÔNG TY] ---");
    super.xuat();
    print("Số nhân viên: $soNhanVien\n");
  }
}

class QuanLyHoaDon {
  List<HoaDon> ds = [];

  void nhapDanhSach() {
    while (true) {
      print("\n=== CHỌN LOẠI KHÁCH HÀNG ĐỂ NHẬP ===");
      print("1. Khách hàng Cá nhân");
      print("2. Đại lý cấp 1");
      print("3. Khách hàng Công ty");
      print("0. Dừng nhập");
      stdout.write("Chọn: ");
      String chon = stdin.readLineSync() ?? "";

      if (chon == '0') break;

      HoaDon? hd;
      switch (chon) {
        case '1': hd = CaNhan(); break;
        case '2': hd = DaiLy(); break;
        case '3': hd = CongTy(); break;
        default:
          print("Lựa chọn không hợp lệ!");
          continue;
      }

      hd.nhap();
      ds.add(hd);
      print("=> Đã thêm hóa đơn thành công!");
    }
  }

  void xuatDanhSach() {
    if (ds.isEmpty) {
      print("\nDanh sách hóa đơn trống!");
      return;
    }
    print("\n========== DANH SÁCH HÓA ĐƠN ==========");
    for (var hd in ds) {
      hd.xuat();
    }
  }

  void tinhTongThanhTien() {
    double tong = ds.fold(0, (sum, hd) => sum + hd.tinhThanhTien());
    print("\n=> TỔNG THÀNH TIỀN TẤT CẢ HÓA ĐƠN: $tong");
  }

  void tinhTongTroGia() {
    double tong = ds.fold(0, (sum, hd) => sum + hd.tinhTroGia());
    print("=> TỔNG TIỀN CÔNG TY ĐÃ TRỢ GIÁ: $tong");
  }

  void khachHangMuaNhieuNhat() {
    if (ds.isEmpty) return;
    int maxSL = ds.map((hd) => hd.soLuong).reduce(max);
    
    print("\n=> CÁC KHÁCH HÀNG MUA NHIỀU NHẤT ($maxSL sản phẩm):");
    ds.where((hd) => hd.soLuong == maxSL).forEach((hd) => hd.xuat());
  }

  void tongChietKhauCongTy() {
    double tong = ds.whereType<CongTy>().fold(0, (sum, hd) => sum + hd.tinhChietKhau());
    print("\n=> TỔNG CHIẾT KHẤU ĐỐI VỚI KHÁCH HÀNG CÔNG TY: $tong");
  }

  void sapXepDanhSach() {
    ds.sort((a, b) {
      int cmp = a.soLuong.compareTo(b.soLuong);
      if (cmp == 0) {
        return b.tinhThanhTien().compareTo(a.tinhThanhTien());
      }
      return cmp;
    });
    print("\n=> Đã sắp xếp danh sách thành công!");
  }

  void timHoaDonTheoMa(String ma) {
    print("\n--- KẾT QUẢ TÌM KIẾM MÃ KH: $ma ---");
    bool found = false;
    for (var hd in ds) {
      if (hd.maKH == ma) {
        hd.xuat();
        found = true;
      }
    }
    if (!found) {
      print("Khách hàng lạ");
    }
  }
}


import 'dart:io';

// import 'package:baitap_tuan2/Phong.dart';
import 'package:baitap_tuan2/MonHoc.dart';

// void main(List<String> args) async {
//   Future<List<Phong>> readFile(String fileName) async {
//     List<Phong> lstPhong = [];
//     try {
//       List<String> lines = await File(fileName).readAsLines();
//       for (String line in lines) {
//         if (line.trim().isEmpty) continue;
//         List<String> parts = line.split('#');
//         if (parts.length >= 5) {
//           String maP = parts[0].trim();
//           int soNguoi = int.parse(parts[1].trim());
//           double soDien = double.parse(parts[2].trim());
//           double soNuoc = double.parse(parts[3].trim());
//           if (maP.startsWith("A") && parts.length == 5) {
//             int soNguoiThan = int.parse(parts[4].trim());
//             lstPhong.add(
//               PhongA.fullPara(maP, soNguoi, soDien, soNuoc, soNguoiThan),
//             );
//           } else if (maP.startsWith('B') && parts.length == 6) {
//             double giatUi = double.parse(parts[4].trim());
//             int soMay = int.parse(parts[5].trim());
//             lstPhong.add(
//               PhongB.fullPara(maP, soNguoi, soDien, soNuoc, giatUi, soMay),
//             );
//           }
//         }
//       }
//     } catch (e) {
//       print("Lỗi đọc file: $e");
//     }
//     return lstPhong;
//   }

//   List<Phong> ds = await readFile('lib/phongthue.txt');
//   print('Danh sách phòng thuê: ');
//   for (Phong p in ds) {
//     p.showInfo();
//   }
//   //In ra danh sách các phòng có số người thuê lớn hơn 2.
//   print('\nDanh sách các phòng có số người thuê lớn hơn 2.: ');
//   for (Phong p in ds) {
//     if (p.soNguoi > 2) p.showInfo();
//   }

//   //Tính tổng tiền phòng thu được từ các phòng.
//   double tong = 0.0;
//   for (Phong p in ds) {
//     tong += p.tinhTien();
//   }
//   print("Tổng tiền thu được từ tất cả các phòng: $tong");

//   //Sắp xếp danh sách phòng thuê theo thứ tự giảm dần của số điện tiêu thụ.
//   ds.sort((a, b) => b.soDien.compareTo(a.soDien));
//   print('\nDanh sách phòng thuê theo thứ tự giảm dần của số điện tiêu thụ:');
//   for (Phong p in ds) {
//     p.showInfo();
//   }

//   //In ra màn hình danh sách các phòng loại A.
//   print('\nDanh sách các phòng loại A:');
//   for (Phong p in ds) {
//     if (p.maP.startsWith('A')) p.showInfo();
//   }
// }

// ▪ Nhập vào một danh sách các môn học từ bàn phím
// ▪ Xuất danh sách các môn học vừa nhập ra màn hình
void xuatDanhSach(List<Monhoc> ds) {
  if (ds.isEmpty) {
    print("Danh sách môn học trống!");
    return;
  }
  print("--- DANH SÁCH MÔN HỌC ---");
  for (Monhoc mh in ds) {
    mh.showInfo();
  }
}

void nhapTuBanPhim(List<Monhoc> ds) {
  print("--- BẮT ĐẦU NHẬP DANH SÁCH MÔN HỌC ---");

  while (true) {
    print("\nNhập thông tin môn học mới:");

    stdout.write("Mã môn học: ");
    String ma = stdin.readLineSync() ?? "";

    stdout.write("Tên môn học: ");
    String ten = stdin.readLineSync() ?? "";

    stdout.write("Số tín chỉ: ");
    int tc = int.parse(stdin.readLineSync() ?? "0");
    print("Chọn loại môn học (1: Lý thuyết, 2: Thực hành, 3: Đồ án): ");
    String loai = stdin.readLineSync() ?? "";

    switch (loai) {
      case '1':
        stdout.write("Điểm tiểu luận: ");
        double tl = double.parse(stdin.readLineSync() ?? "0");
        stdout.write("Điểm cuối kỳ: ");
        double ck = double.parse(stdin.readLineSync() ?? "0");
        ds.add(LyThuyet.fullPara(ma, ten, tc, tl, ck));
        break;

      case '2':
        stdout.write("Điểm kiểm tra 1: ");
        double kt1 = double.parse(stdin.readLineSync() ?? "0");
        stdout.write("Điểm kiểm tra 2: ");
        double kt2 = double.parse(stdin.readLineSync() ?? "0");
        stdout.write("Điểm kiểm tra 3: ");
        double kt3 = double.parse(stdin.readLineSync() ?? "0");

        ds.add(ThucHanh.fullPara(ma, ten, tc, kt1, kt2, kt3));
        break;

      case '3':
        stdout.write("Điểm GVHD: ");
        double hd = double.parse(stdin.readLineSync() ?? "0");
        stdout.write("Điểm GVPB: ");
        double pb = double.parse(stdin.readLineSync() ?? "0");

        ds.add(DoAn.fullPara(ma, ten, tc, hd, pb));
        break;

      default:
        print("Lựa chọn không hợp lệ! Đã hủy thêm môn học này.");
    }
    stdout.write("Bạn có muốn nhập thêm môn học khác không? (Y/N): ");
    String tiepTuc = stdin.readLineSync() ?? "N";

    if (tiepTuc.toUpperCase() != 'Y') {
      break;
    }
  }
}

//Hãy cho biết danh sách môn học có được sắp xếp tăng dần theo tên môn học hay không?
bool kiemTraSapXepTen(List<Monhoc> ds) {
  if (ds.length <= 1) return true;
  for (int i = 0; i < ds.length - 1; i++) {
    if (ds[i].tenMon.compareTo(ds[i + 1].tenMon) > 0) {
      return false;
    }
  }
  return true;
}

//Sắp xếp danh sách môn học tăng dần theo số tín chỉ.
void sapXepTheoTinChi(List<Monhoc> ds) {
  ds.sort((a, b) => a.soTinChi.compareTo(b.soTinChi));
  print("Đã sắp xếp danh sách tăng dần theo số tín chỉ.");
}

//Cho biết các môn học có số tín chỉ cao nhất.
void inMonHocTinChiCaoNhat(List<Monhoc> ds) {
  if (ds.isEmpty) return;
  int maxTC = ds[0].soTinChi;
  for (Monhoc mh in ds) {
    if (mh.soTinChi > maxTC) maxTC = mh.soTinChi;
  }
  print("--- CÁC MÔN CÓ TÍN CHỈ CAO NHẤT ($maxTC tín chỉ) ---");
  ds.where((mh) => mh.soTinChi == maxTC).forEach((mh) => print(mh));
}

//Nhập vào tên môn học bất kỳ, cho biết môn học đó có trong danh sách hay không?
//Nếu không có, hãy thêm giá trị đó vào cuối danh sách. Nếu có hãy cho biết các thông tin về môn học đó.
void timHoacThemMonHoc(List<Monhoc> ds) {
  print("\n--- TÌM KIẾM HOẶC THÊM MỚI MÔN HỌC ---");
  stdout.write("Nhập tên môn học cần tìm: ");
  String tenTimKiem = stdin.readLineSync() ?? "";
  var ketQua = ds
      .where((mh) => mh.tenMon.toLowerCase() == tenTimKiem.toLowerCase())
      .toList();
  if (ketQua.isNotEmpty) {
    print("=> TÌM THẤY! Thông tin chi tiết của môn '$tenTimKiem':");
    for (var mh in ketQua) {
      print(mh);
    }
  } else {
    print(
      "=> KHÔNG TÌM THẤY! Vui lòng nhập thông tin để thêm môn '$tenTimKiem' vào danh sách.",
    );
    stdout.write("Mã môn học: ");
    String ma = stdin.readLineSync() ?? "";
    stdout.write("Số tín chỉ: ");
    int tc = int.parse(stdin.readLineSync() ?? "0");
    print("Chọn loại môn học (1: Lý thuyết, 2: Thực hành, 3: Đồ án): ");
    String loai = stdin.readLineSync() ?? "";
    switch (loai) {
      case '1':
        stdout.write("Điểm tiểu luận: ");
        double tl = double.parse(stdin.readLineSync() ?? "0");
        stdout.write("Điểm cuối kỳ: ");
        double ck = double.parse(stdin.readLineSync() ?? "0");

        ds.add(LyThuyet.fullPara(ma, tenTimKiem, tc, tl, ck));
        print("=> Đã thêm môn Lý thuyết '$tenTimKiem' thành công!");
        break;
      case '2':
        stdout.write("Điểm kiểm tra 1: ");
        double kt1 = double.parse(stdin.readLineSync() ?? "0");
        stdout.write("Điểm kiểm tra 2: ");
        double kt2 = double.parse(stdin.readLineSync() ?? "0");
        stdout.write("Điểm kiểm tra 3: ");
        double kt3 = double.parse(stdin.readLineSync() ?? "0");
        ds.add(ThucHanh.fullPara(ma, tenTimKiem, tc, kt1, kt2, kt3));
        print("=> Đã thêm môn Thực hành '$tenTimKiem' thành công!");
        break;
      case '3':
        stdout.write("Điểm GVHD: ");
        double hd = double.parse(stdin.readLineSync() ?? "0");
        stdout.write("Điểm GVPB: ");
        double pb = double.parse(stdin.readLineSync() ?? "0");
        ds.add(DoAn.fullPara(ma, tenTimKiem, tc, hd, pb));
        print("=> Đã thêm môn Đồ án '$tenTimKiem' thành công!");
        break;
      default:
        print("=> Lựa chọn không hợp lệ! Đã hủy việc thêm môn học này.");
    }
  }
}
//Tính số tín chỉ trung bình của các môn học có trong danh sách.
void tinhTCTrungBinh(List<Monhoc> ds) {
  if (ds.isEmpty) return;
  int tongTC = ds.fold(0, (sum, mh) => sum + mh.soTinChi);
  double tbTC = tongTC / ds.length;
  
  print("Số tín chỉ trung bình của các môn học: ${tbTC.toStringAsFixed(2)}");
}
void main(List<String> args) async {
  List<Monhoc> ds = [];
  Future<List<Monhoc>> docFileMonHoc(String fileName) async {
    List<Monhoc> ds = [];
    try {
      List<String> lines = await File(fileName).readAsLines();
      for (String line in lines) {
        if (line.trim().isEmpty) continue;
        List<String> parts = line.split('#');

        String loai = parts[0].trim();
        String ma = parts[1].trim();
        String ten = parts[2].trim();
        int tc = int.parse(parts[3].trim());

        if (loai == 'LT' && parts.length == 6) {
          double tl = double.parse(parts[4].trim());
          double ck = double.parse(parts[5].trim());
          ds.add(LyThuyet.fullPara(ma, ten, tc, tl, ck));
        } else if (loai == 'TH' && parts.length == 7) {
          double kt1 = double.parse(parts[4].trim());
          double kt2 = double.parse(parts[5].trim());
          double kt3 = double.parse(parts[6].trim());
          ds.add(ThucHanh.fullPara(ma, ten, tc, kt1, kt2, kt3));
        } else if (loai == 'DA' && parts.length == 6) {
          double hd = double.parse(parts[4].trim());
          double pb = double.parse(parts[5].trim());
          ds.add(DoAn.fullPara(ma, ten, tc, hd, pb));
        }
      }
    } catch (e) {
      print("Lỗi đọc file: $e");
    }
    return ds;
  }

  ds = await docFileMonHoc('lib/monhoc.txt');

  xuatDanhSach(ds);

  // if (kiemTraSapXepTen(ds))
  //   print('Danh sách môn học được sắp xếp tăng dần theo tên môn học');
  // else
  //   print('Danh sách môn học không được sắp xếp tăng dần theo tên môn học');

  // sapXepTheoTinChi(ds);
  // xuatDanhSach(ds);
  // inMonHocTinChiCaoNhat(ds);
  // timHoacThemMonHoc(ds);
  tinhTCTrungBinh(ds);
}

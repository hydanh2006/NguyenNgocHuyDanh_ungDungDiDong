import 'dart:io';
import 'dart:math';

// Bài tập tự làm
double baitap1() {
  stdout.write("Nhập số que kem muốn mua:");
  int kem = int.parse(stdin.readLineSync()!);
  stdout.write("Nhập số tiền mỗi que kem:");
  double giatien = double.parse(stdin.readLineSync()!);
  double tong = giatien * kem;
  double giamgia = 0.0;
  if (kem > 10)
    giamgia = 0.1;
  else if (kem >= 5)
    giamgia = 0.05;
  else
    giamgia = 0.0;

  return tong - (tong * giamgia);
}

void baitap2() {
  int a = 0;
  do {
    stdout.write('Nhập số nguyên dương (>10): ');
    String? input = stdin.readLineSync();

    if (input != null && input.isNotEmpty) a = int.parse(input);

    if (a <= 10) {
      print('Số nguyên nhập vào không hợp lệ!');
    }
  } while (a <= 10);

  int soChuSo = a.toString().length;
  int tong = 0;
  bool soLe = false;

  int temp = a;
  while (temp > 0) {
    int chuSo = temp % 10;
    tong += chuSo;
    if (chuSo % 2 != 0) soLe = true;
    temp = (temp ~/ 10);
  }

  //Kết quả
  print('a.Số nguyên nhập vào: $a, có $soChuSo chữ số.');
  print('b.Tổng các chữ số: $tong');
  if (soLe)
    print('Số nhập vào có chữ số lẻ.');
  else
    print('Số nhập vào không có chữ số lẻ.');
}

bool SoNguyenTo(int n) {
  if (n < 2) return false;
  for (int i = 2; i <= sqrt(n); i++) {
    if (n % i == 0) return false;
  }
  return true;
}

void baitap3() {
  List<int> danhSach = [];

  stdout.write('Nhập số lượng phần tử trong danh sách: ');
  int n = int.parse(stdin.readLineSync()!);

  for (int i = 0; i < n; i++) {
    stdout.write('Nhập phần tử thứ ${i + 1}: ');
    int phanTu = int.parse(stdin.readLineSync()!);
    danhSach.add(phanTu);
  }

  //Kết quả
  print('a.Danh sách: $danhSach');

  int tong = 0;
  for (int a in danhSach) tong += a;
  print('b.Tổng các phần tử: $tong');

  List<int> listSoNguyenTo = [];
  for (int a in danhSach) {
    if (SoNguyenTo(a)) {
      listSoNguyenTo.add(a);
    }
  }
  if (listSoNguyenTo.isEmpty) {
    print('Không có số nguyên tố trong danh sách.');
  } else {
    print('c.Danh sách các số nguyên tố: $listSoNguyenTo');
  }

  stdout.write('Nhập vào một giá trị bất kỳ: ');
  int x = int.parse(stdin.readLineSync()!);

  if (danhSach.contains(x)) {
    List<int> viTri = [];
    for (int i = 0; i < danhSach.length; i++) {
      if (danhSach[i] == x) viTri.add(i);
    }
    print('Giá trị $x xuất hiện tại vị trí: $viTri');
  } else {
    danhSach.insert(0, x);
    print('Không tìm thấy giá trị $x trong danh sách.');
    print('Danh sách sau khi chèn $x vào đầu: $danhSach');
  }
}

// Bài tập về nhà
void baitapVeNha1() {
  Random random = Random();
  List<int> danhSach = [];
  int soLuongPhanTu = 10;
  for (int i = 0; i < soLuongPhanTu; i++) {
    danhSach.add(random.nextInt(95) + 5);
  }

  // Kết quả
  print('a.Các phần tử trong danh sách: $danhSach');

  List<int> soLe = danhSach.where((x) => x % 2 != 0).toList();
  if (soLe.isEmpty) {
    print('b.Danh sách không có số lẻ!');
  } else {
    double tbc = soLe.reduce((a, b) => a + b) / soLe.length;
    print('b.Trung bình cộng các số lẻ: $tbc');
  }

  bool doiXung = true;
  for (int i = 0; i < danhSach.length ~/ 2; i++) {
    if (danhSach[i] != danhSach[danhSach.length - 1 - i]) {
      doiXung = false;
      break;
    }
  }
  if (doiXung)
    print('c.Danh sách CÓ đối xứng');
  else
    print('c.Danh sách KHÔNG đối xứng');

  bool tangDan = true;
  for (int i = 0; i < danhSach.length - 1; i++) {
    if (danhSach[i] < danhSach[i + 1]) {
      tangDan = false;
      break;
    }
  }
  if (tangDan)
    print('d.Danh sách CÓ tăng dần');
  else
    print('d.Danh sách KHÔNG tăng đần');

  int max = danhSach[0];
  for (int i in danhSach) {
    if (i > max) max = i;
  }
  print('e.Phần tử lớn nhất trong danh sách là: $max');

  List<int> soChan = danhSach.where((x) => x % 2 == 0).toList();
  if (soChan.isEmpty)
    print('f.Danh sách không có số chẵn!');
  else {
    int maxChan = soChan[0];
    for (int i in soChan) {
      if (i > maxChan) maxChan = i;
    }
    print('f.Số chẵn lớn nhất trong danh sách: $maxChan');
  }

  stdout.write('g.Nhập vào một giá trị: ');
  int a = int.parse(stdin.readLineSync()!);

  if (!danhSach.contains(a)) {
    print('g.Không tìm thấy $a trong danh sách');
  } else {
    danhSach.removeWhere((x) => x == a);
    print('g.Đã tìm thấy $a trong danh sachs!');
    print('g.Danh sách sau khi xóa $a: $danhSach');
  }
}

void baitapVeNha2() {
  stdout.write('a.Nhập vào một chuỗi: ');
  String chuoi = stdin.readLineSync() ?? '';

  // Kết quả
  print('a.Chuỗi vừa nhập: $chuoi');
  if (chuoi.isEmpty) print('a.Lỗi Chuỗi rỗng');

  int soNguyenAm = 0;
  String nguyenAm = 'aeouiAEOUI';

  for (int i = 0; i < chuoi.length; i++) {
    if (nguyenAm.contains(chuoi[i])) soNguyenAm++;
  }
  print('b.Chuỗi có $soNguyenAm ký tự là nguyên âm');

  String chuoiTrim = chuoi.trim();
  List<String> soTu = chuoiTrim.isEmpty ? [] : chuoiTrim.split(RegExp(r'\s+')); // RegExp(r'\s+') có thể cắt chuỗi dù cho người dùng nhập nhiều dấu cách liên tiếp.
  print('c.Chuỗi có ${soTu.length} từ');

  String daoNguoc = chuoi.split(' ').reversed.join('');
  if (chuoi == daoNguoc)
    print('d.Chuỗi đối xứng!');
  else
    print('d.Chuỗi không đối xứng!');

  String chuoiDaoNguoc = soTu.reversed.join(' ');
  print('e.Đảo ngược chuỗi:$chuoi -> $chuoiDaoNguoc');
}

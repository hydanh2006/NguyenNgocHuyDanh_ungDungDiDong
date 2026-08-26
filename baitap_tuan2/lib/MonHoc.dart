import 'dart:io';

abstract class Monhoc {
  String maMon = '';
  String tenMon = '';
  int soTinChi = 0;
  Monhoc() {
    maMon = 'MMNT';
    tenMon = 'Nhập môn lập trình';
    soTinChi = 3;
  }
  Monhoc.fullPara(String ma, String ten, int tinchi) {
    maMon = ma;
    tenMon = ten;
    soTinChi = tinchi;
  }

  double DTB();
  void showInfo() {
    print('Mã môn: $maMon \t Tên môn: $tenMon \t Tín chỉ: $soTinChi \t');
  }
}

class LyThuyet extends Monhoc {
  double diemLT = 0.0;
  double diemCK = 0.0;

  LyThuyet() : super() {
    diemLT = 8.2;
    diemCK = 8.0;
  }

  LyThuyet.fullPara(String ma, String ten, int tinchi, double lt, double ck)
    : super.fullPara(ma, ten, tinchi) {
    diemLT = lt;
    diemCK = ck;
  }

  //DTB = Điểm tiểu luận*0.3 + Điểm cuối kỳ*0.7
  @override
  double DTB() {
    // TODO: implement DTB
    return (diemLT * 0.3) + (diemCK * 0.7);
  }

  @override
  void showInfo() {
    // TODO: implement showInfo
    super.showInfo();
    print(
      '\n Điểm lý thuyết: $diemLT \t Điểm cuối kỳ: $diemCK \t Điểm trung bình: ${DTB()}',
    );
  }
}

class ThucHanh extends Monhoc {
  double ktraLan1 = 0.0;
  double ktraLan2 = 0.0;
  double ktraLan3 = 0.0;

  ThucHanh() : super() {
    ktraLan1 = 9.0;
    ktraLan2 = 8.9;
    ktraLan3 = 9.1;
  }

  ThucHanh.fullPara(
    String ma,
    String ten,
    int tinchi,
    double l1,
    double l2,
    double l3,
  ) : super.fullPara(ma, ten, tinchi) {
    ktraLan1 = l1;
    ktraLan2 = l2;
    ktraLan3 = l3;
  }

  //DTB tính bằng trung bình cộng các bài kiểm tra
  @override
  double DTB() {
    // TODO: implement DTB
    return (ktraLan1 + ktraLan2 + ktraLan3) / 3;
  }

  @override
  void showInfo() {
    // TODO: implement showInfo
    super.showInfo();
    print(
      '\n Kiểm tra lần 1: $ktraLan1 \t Kiểm tra lần 2: $ktraLan2 \t Kiểm tra lần 3: $ktraLan3 \t Điểm trung bình: ${DTB()}',
    );
  }
}

class DoAn extends Monhoc {
  double GVHD = 0.0;
  double GVPB = 0.0;

  DoAn() : super() {
    GVHD = 8.2;
    GVPB = 8.8;
  }

  DoAn.fullPara(String ma, String ten, int tinchi, double hd, double pb)
    : super.fullPara(ma, ten, tinchi) {
    GVHD = hd;
    GVPB = pb;
  }

  //DTB = (điểm GVHD + điểm GVPB)/ 2
  @override
  double DTB() {
    // TODO: implement DTB
    return (GVHD + GVPB) / 2;
  }

  @override
  void showInfo() {
    // TODO: implement showInfo
    super.showInfo();
    print('Điểm GVHD: $GVHD \t ĐIểm GVPB: $GVPB \t Điểm trung bình: ${DTB()}');
  }
}
  
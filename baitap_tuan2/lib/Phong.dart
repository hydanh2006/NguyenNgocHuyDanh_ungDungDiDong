abstract class Phong {
  String maP = '';
  int soNguoi = 0;
  double soDien = 0.0;
  double soNuoc = 0.0;

  Phong() {
    maP = 'P001';
    soNguoi = 4;
    soDien = 20.5;
    soNuoc = 15;
  }
  Phong.fullPara(String mp, int nguoi, double dien, double nuoc) {
    maP = mp;
    soNguoi = nguoi;
    soDien = dien;
    soNuoc = nuoc;
  }

  double tinhTien();

  void showInfo() {
    print(
      "Mã phòng: $maP \t Số người: $soNguoi \t Điện: $soDien \t Nước: $soNuoc",
    );
  }
}

class PhongA extends Phong {
  int soNguoiThan = 0;
  PhongA() : super() {
    soNguoiThan = 5;
  }
  PhongA.fullPara(String mp, int nguoi, double dien, double nuoc, int nguoithan)
    : super.fullPara(mp, nguoi, dien, nuoc) {
    soNguoiThan = nguoithan;
  }

  @override
  double tinhTien() {
    //1400 + 2*Số điện + 8*Số nước + 50*SoNguoithan
    return 1400 + (2 * soDien) + (8 * soNuoc) + (50 * soNguoiThan);
  }

  @override
  void showInfo() {
    super.showInfo();
    print('\tNgười thân đến thăm: $soNguoiThan \t Tiền phòng: ${tinhTien()}');
  }
}

class PhongB extends Phong {
  int soMay = 0;
  double giatUi = 0;

  PhongB() : super() {
    soMay = 4;
    giatUi = 10.8;
  }
  PhongB.fullPara(
    String mp,
    int nguoi,
    double dien,
    double nuoc,
    double giat,
    int may,
  ) : super.fullPara(mp, nguoi, dien, nuoc) {
    soMay = may;
    giat = giat;
  }

  @override
  double tinhTien() {
    //2000 + 2*Số điện + 8*Số nước + Giatui*5 + Somay*100
    return 2000 + (2 * soDien) + (8 * soNuoc) + (giatUi * 5) + (soMay * 100);
  }

  @override
  void showInfo() {
    super.showInfo();
    print('\tGiặt ủi: $giatUi \t Số máy: $soMay \t Tiền phòng: ${tinhTien()}');
  }
}

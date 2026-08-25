import 'package:baitap_tuan2/NhanVien.dart';

class CanBo extends NhanVien {
  String _chucVu = '';
  double _hsChucVu = 0;

  CanBo() : super() {
    _chucVu = "Unknown";
  }

  CanBo.fullPara(
    String manv,
    String tennv,
    double hsl,
    String pb,
    double songaylv,
    String chucvu,
    double hscv,
  ) : super.fullPara(manv, tennv, hsl, pb, songaylv) {
    _chucVu = chucvu;
    _hsChucVu = hscv;
  }

  @override
  String toString() {
    return super.toString() + "\t$_chucVu\t$_hsChucVu";
  }

  @override
  double tinhLuong() {
    return super.tinhLuong() + _hsChucVu * 1100;
  }
}

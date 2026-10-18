//create class ChiTieu with properties id, noidung, sotien, ghichu
class ChiTieu {
  int? id;
  String noidung;
  double sotien;
  String ghichu;

  ChiTieu({
    this.id,
    required this.noidung,
    required this.sotien,
    required this.ghichu,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'noidung': noidung, 'sotien': sotien, 'ghichu': ghichu};
  }

  factory ChiTieu.fromMap(Map<String, dynamic> map) {
    return ChiTieu(
      id: map['id'],
      noidung: map['noidung'],
      sotien: map['sotien'],
      ghichu: map['ghichu'],
    );
  }
}

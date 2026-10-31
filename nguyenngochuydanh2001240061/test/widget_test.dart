import 'package:flutter_test/flutter_test.dart';
import 'package:nguyenngochuydanh2001240061/place_model.dart';

void main() {
  test('Place model test toMap and fromMap with image', () {
    final place = Place(
      id: 1,
      name: 'Hồ Hoàn Kiếm',
      rating: 4.8,
      phone: '02438253631',
      address: 'P. Hàng Trống, Hà Nội',
      image: '1.jpg',
    );

    final map = place.toMap();
    expect(map['id'], 1);
    expect(map['name'], 'Hồ Hoàn Kiếm');
    expect(map['rating'], 4.8);
    expect(map['phone'], '02438253631');
    expect(map['address'], 'P. Hàng Trống, Hà Nội');
    expect(map['image'], '1.jpg');

    final placeFromMap = Place.fromMap(map);
    expect(placeFromMap.id, 1);
    expect(placeFromMap.name, 'Hồ Hoàn Kiếm');
    expect(placeFromMap.rating, 4.8);
    expect(placeFromMap.phone, '02438253631');
    expect(placeFromMap.address, 'P. Hàng Trống, Hà Nội');
    expect(placeFromMap.image, '1.jpg');
  });
}

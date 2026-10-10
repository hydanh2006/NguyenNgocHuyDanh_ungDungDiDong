import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class RouteFinderScreen extends StatefulWidget {
  const RouteFinderScreen({super.key});

  @override
  _RouteFinderScreenState createState() => _RouteFinderScreenState();
}

class _RouteFinderScreenState extends State<RouteFinderScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();

  LatLng? _startLatLng;
  LatLng? _endLatLng;

  // Biến lưu khoảng cách và thời gian
  String _distance = "";
  String _duration = "";

  final String _apiKey = "AIzaSyAL1LVcC6XafKKNRp_sGskc0bXuW0s_hhw";

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(10.7769, 106.7009),
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation(isStart: true);
  }

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  // 1. Lấy vị trí hiện tại (Cho cả Xuất phát và Đích)
  Future<void> _fetchCurrentLocation({required bool isStart}) async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    Position position = await Geolocator.getCurrentPosition();
    LatLng currentLatLng = LatLng(position.latitude, position.longitude);

    if (mounted) {
      setState(() {
        if (isStart) {
          _startLatLng = currentLatLng;
          _startController.text = "${position.latitude}, ${position.longitude}";
          _addMarker(currentLatLng, "Xuất phát", BitmapDescriptor.hueRed);
          _moveCamera(currentLatLng);
        } else {
          _endLatLng = currentLatLng;
          _endController.text = "${position.latitude}, ${position.longitude}";
          _addMarker(currentLatLng, "Đích đến", BitmapDescriptor.hueRed);
        }
      });
    }
  }


  void _addMarker(LatLng position, String markerId, double hue) {
    setState(() {
      _markers.removeWhere((m) => m.markerId.value == markerId);
      _markers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: position,
          infoWindow: InfoWindow(title: markerId),
          icon: BitmapDescriptor.defaultMarkerWithHue(hue),
        ),
      );
    });
  }

  Future<void> _moveCamera(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(position));
  }

  void _onMapTapped(LatLng position) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chọn thao tác'),
        content: Text(
          'Tọa độ:\n${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _startLatLng = position;
                _startController.text =
                    "${position.latitude}, ${position.longitude}";
                _addMarker(position, "Xuất phát", BitmapDescriptor.hueRed);
              });
              Navigator.pop(context);
            },
            child: const Text('Làm điểm Xuất phát'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _endLatLng = position;
                _endController.text =
                    "${position.latitude}, ${position.longitude}";
                _addMarker(position, "Đích đến", BitmapDescriptor.hueRed);
              });
              Navigator.pop(context);
            },
            child: const Text('Làm điểm Đích'),
          ),
        ],
      ),
    );
  }

  Future<void> _findRoute() async {
    if (_startController.text.isEmpty || _endController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập cả hai điểm!')),
      );
      return;
    }

    try {
      List<String> start = _startController.text.split(',');
      List<String> end = _endController.text.split(',');
      _startLatLng = LatLng(
        double.parse(start[0].trim()),
        double.parse(start[1].trim()),
      );
      _endLatLng = LatLng(
        double.parse(end[0].trim()),
        double.parse(end[1].trim()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Định dạng tọa độ không hợp lệ!')),
      );
      return;
    }

    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${_startLatLng!.latitude},${_startLatLng!.longitude}&destination=${_endLatLng!.latitude},${_endLatLng!.longitude}&key=$_apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['routes'] != null && data['routes'].isNotEmpty) {
        // 3. Trích xuất khoảng cách và thời gian
        var leg = data['routes'][0]['legs'][0];

        String polylinePoints =
            data['routes'][0]['overview_polyline']['points'];
        List<LatLng> points = _decodePolyline(polylinePoints);

        setState(() {
          _distance = leg['distance']['text'];
          _duration = leg['duration']['text'];

          _markers.removeWhere(
            (m) =>
                m.markerId.value == "Xuất phát" ||
                m.markerId.value == "Đích đến",
          );
          _addMarker(_startLatLng!, "Xuất phát", BitmapDescriptor.hueRed);
          _addMarker(_endLatLng!, "Đích đến", BitmapDescriptor.hueRed);

          _polylines.clear();
          _polylines.add(
            Polyline(
              polylineId: const PolylineId('route'),
              points: points,
              color: Colors.blue,
              width: 5,
            ),
          );
          _moveCamera(_startLatLng!);
        });
      } else {
        if (mounted)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Không tìm thấy tuyến đường nào!')),
          );
      }
    }
  }

  Future<void> _searchNearbyPlaces(String type) async {
    if (_startLatLng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng xác định vị trí xuất phát trước!'),
        ),
      );
      return;
    }

    String url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${_startLatLng!.latitude},${_startLatLng!.longitude}&radius=3000&type=$type&key=$_apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['status'] == 'OK') {
        List<dynamic> results = data['results'];
        setState(() {
          _markers.removeWhere(
            (m) =>
                m.markerId.value != "Xuất phát" &&
                m.markerId.value != "Đích đến",
          );

          for (var place in results) {
            var loc = place['geometry']['location'];
            LatLng pos = LatLng(loc['lat'], loc['lng']);
            _markers.add(
              Marker(
                markerId: MarkerId(place['place_id']),
                position: pos,
                infoWindow: InfoWindow(
                  title: place['name'],
                  snippet: place['vicinity'],
                ),
                // Các địa điểm tìm kiếm sẽ có màu Xanh Lá để phân biệt
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen,
                ),
              ),
            );
          }
        });
      } else {
        if (mounted)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Không tìm thấy: ${data['status']}')),
          );
      }
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;
    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;
      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Route & Places Finder')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _startController,
                  decoration: InputDecoration(
                    labelText: 'Điểm xuất phát (lat, lng)',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.my_location, color: Colors.blue),
                      onPressed: () => _fetchCurrentLocation(isStart: true),
                    ),
                  ),
                ),
                TextField(
                  controller: _endController,
                  decoration: InputDecoration(
                    labelText: 'Điểm đích (lat, lng)',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.my_location, color: Colors.red),
                      onPressed: () => _fetchCurrentLocation(isStart: false),
                    ),
                  ),
                ),

                if (_distance.isNotEmpty && _duration.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Khoảng cách: $_distance  |  Thời gian: $_duration',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  ),

                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _findRoute,
                  child: const Text('Tìm đường đi'),
                ),

                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ActionChip(
                        label: const Text('Khách sạn'),
                        onPressed: () => _searchNearbyPlaces('lodging'),
                      ),
                      const SizedBox(width: 5),
                      ActionChip(
                        label: const Text('Quán ăn'),
                        onPressed: () => _searchNearbyPlaces('restaurant'),
                      ),
                      const SizedBox(width: 5),
                      ActionChip(
                        label: const Text('Bệnh viện'),
                        onPressed: () => _searchNearbyPlaces('hospital'),
                      ),
                      const SizedBox(width: 5),
                      ActionChip(
                        label: const Text('Trường học'),
                        onPressed: () => _searchNearbyPlaces('school'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: _initialPosition,
              markers: _markers,
              polylines: _polylines,
              onTap: _onMapTapped, 
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationEnabled: true,
            ),
          ),
        ],
      ),
    );
  }
}

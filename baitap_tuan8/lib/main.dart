import 'package:flutter/material.dart';
import 'package:baitap_tuan8/services/notification_service.dart';
import 'package:baitap_tuan8/views/scren_noti_ex.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notificationService = NotificationService();
  await notificationService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // nền trắng toàn app
      ),
      home: ScreenNotiEx(),
    );
  }
}

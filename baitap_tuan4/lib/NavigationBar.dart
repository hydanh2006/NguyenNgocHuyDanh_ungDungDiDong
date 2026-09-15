import 'package:flutter/material.dart';
import 'package:testbt_tuan4/my_bottom_navigation_bar.dart';

void main() {
  runApp(const BottomNavigationBar_VD());
}

class BottomNavigationBar_VD extends StatelessWidget {
  const BottomNavigationBar_VD({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Demo NavigationBar',
      debugShowCheckedModeBanner: false,
      home: MyButtonNavigationBar(),
    );
  }
}

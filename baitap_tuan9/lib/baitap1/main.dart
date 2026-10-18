import 'package:flutter/material.dart';
import 'package:baitap_tuan9/baitap1/views/chitieu_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản lý Chi Tiêu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 135, 200, 230),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: ChiTieuScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:baitap_tuan8/baitap/views/screen_todo.dart';
import 'package:baitap_tuan8/baitap/views/screen_vocab_main.dart';
import 'package:baitap_tuan8/baitap/views/screen_hw_todolist.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // Khớp với thiết kế nền trắng
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ScreenHwTodoList(),
    );
  }
}

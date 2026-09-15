import 'package:flutter/material.dart';

class MyButtonNavigationBar extends StatefulWidget {
  const MyButtonNavigationBar({super.key});

  @override
  State<MyButtonNavigationBar> createState() => _MyButtonNavigationBarState();
}

class _MyButtonNavigationBarState extends State<MyButtonNavigationBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const List<Widget> _widgetOptions = <Widget>[
    Text('HOME PAGE', style: optionStyle),
    Text('COURSE PAGE', style: optionStyle),
    Text('CONTACT PAGE', style: optionStyle),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BottomNavigationBar Demo"),
        backgroundColor: Colors.cyan,
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.cyan,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Course',
            backgroundColor: Colors.cyan,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Contact',
            backgroundColor: Colors.cyan,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

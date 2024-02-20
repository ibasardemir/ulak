import 'package:flutter/material.dart';
import 'package:ulak/pages/connect/app_connect_page.dart';
import 'package:ulak/pages/messages/messages_main_page.dart';
import 'package:ulak/pages/settings_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    ConnectionPage(),
    MessagesMainPage(),
    TabPage3(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 26, 
        elevation: 5.0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bluetooth),
            label: 'Connect',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFFF8C00),
        unselectedItemColor: Color(0xFF7a7a7a),
        onTap: _onItemTapped,
      ),
    );
  }
}


class TabPage3 extends StatelessWidget {
  const TabPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsPage()
    );
  }
}


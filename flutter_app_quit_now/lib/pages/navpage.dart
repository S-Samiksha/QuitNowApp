import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app_quit_now/pages/Wishlist.dart';
import 'package:flutter_app_quit_now/pages/admit_relapse.dart';
import 'package:flutter_app_quit_now/pages/home_page.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    WishlistPage(),
    AdmitRelapsePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: _selectedIndex == 0
              ? const Text('Home')
              : _selectedIndex == 1
                  ? const Text('Wishlist')
                  : const Text('Admit Relapse')),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar:
          BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.add_task_rounded), label: 'Wishlist'),
        BottomNavigationBarItem(
            icon: Icon(Icons.emergency), label: 'Admit Relapse'),
      ], currentIndex: _selectedIndex, onTap: _onItemTapped),
    );
  }
}

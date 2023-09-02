import 'package:coinpulse2/2_Presentation/pages/analytics/analytics.dart';
import 'package:coinpulse2/2_Presentation/pages/dialogpage/dialog_page.dart';
import 'package:coinpulse2/2_Presentation/pages/homepage/homepage.dart';
import 'package:coinpulse2/2_Presentation/pages/tab_bar/tab_bar_screen.dart';
import 'package:coinpulse2/main.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const HomePage(),
    const DialogueWrapper(),
    const AnalyticsWrapper()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xfff8f6f0),
        //backgroundColor: ColorsUsed.primaryColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics), label: 'Analytics')
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: _screens.elementAt(_selectedIndex),
    );
  }
}

import 'package:flutter/material.dart';
import 'job_listings_screen.dart';
import 'post_job_screen.dart';
import 'about_screen.dart';

/// 🌿 This widget holds the bottom navigation bar and controls page navigation.
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  // The index of the currently selected tab
  int _selectedIndex = 0;

  // List of screens shown when each tab is selected
  final List<Widget> _screens = [
    const JobListingsScreen(), // index 0
    const PostJobScreen(),     // index 1
    const AboutScreen(),       // index 2
  ];

  // Update the selected index when a tab is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The current page body changes when you tap a tab
      body: _screens[_selectedIndex],

      //  Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // handle tap
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        showUnselectedLabels: true, // show label for all icons
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Post Job',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'About',
          ),
        ],
      ),
    );
  }
}

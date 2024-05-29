import 'package:flutter/material.dart';

class CustomFloatingNavBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final Function(int) onItemSelected;
  final int selectedIndex;

  CustomFloatingNavBar({
    required this.items,
    required this.onItemSelected,
    this.selectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // حواف مدورة من الأعلى فقط
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(

          items: items,
          currentIndex: selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: onItemSelected,
        ),
      ),
    );
  }
}

class MyHomePage2 extends StatefulWidget {
  @override
  _MyHomePage2State createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
  int _selectedIndex = 0;

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Navigation Bar'),
      ),
      body: Center(
        child: Text('Selected index: $_selectedIndex'),
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            color: Colors.transparent,
            height: 80,
          ),
          CustomFloatingNavBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            onItemSelected: _onItemSelected,
            selectedIndex: _selectedIndex,
          ),
        ],
      ),
    );
  }
}

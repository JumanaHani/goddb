import 'package:flutter/material.dart';

import '../../../tasks/views/pages/task_calender.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

int _currentIndex = 0;

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildIcon(IconData iconData, int index) {
    if (_currentIndex == index) {
      return ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF9C2CF3),
              Color(0xFF3A49F9),
            ],
          ).createShader(bounds);
        },
        child: Icon(
          iconData,
          size: 30,
          color: Colors.white, // Gets masked by gradient
        ),
      );
    } else {
      return Icon(
        iconData, size: 30,
        color: Color(0xffD8DEF3), // Unselected color
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        _onItemTapped(index);
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/HomePage');
            break;
          case 1:
            Navigator.pushNamed(context, '/tasks');
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.home, 0),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.task, 1),
          label: 'Tasks',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.notifications_none, 2),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.search, 3),
          label: 'Search',
        ),
      ],
    );
  }
}

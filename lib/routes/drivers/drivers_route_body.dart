import 'package:flutter/material.dart';

import '../calendar/calendar_route.dart';

class DriversRouteBody extends StatefulWidget {
  const DriversRouteBody({Key? key}) : super(key: key);

  @override
  State<DriversRouteBody> createState() => _DriversRouteBodyState();
}

class _DriversRouteBodyState extends State<DriversRouteBody> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Calendar',
      style: TextStyle(fontSize: 24),
    ),
    Text(
      'Drivers',
      style: TextStyle(fontSize: 24),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Drivers',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: _selectedIndex == 1 ? Colors.blue : null,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        _goToCalendar(context);
      }
    });
  }

  void _goToCalendar(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CalendarRoute()),
    );
  }
}

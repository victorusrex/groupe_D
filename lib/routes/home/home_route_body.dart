import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeRouteBody extends StatefulWidget {
  const HomeRouteBody({Key? key}) : super(key: key);

  @override
  State<HomeRouteBody> createState() => _HomeRouteBodyState();
}

class _HomeRouteBodyState extends State<HomeRouteBody> {
  int _selectedIndex = 0;

  late Future<List<Driver>> _futureDrivers;

  @override
  void initState() {
    super.initState();
    _futureDrivers = fetchDrivers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _selectedIndex == 0 ? CalendarWidget() : DriversWidget(futureDrivers: _futureDrivers),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
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
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<List<Driver>> fetchDrivers() async {
    final response = await http.get(Uri.parse(
        'https://api.openf1.org/v1/drivers?session_key=9158'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.take(20).map((e) => Driver.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load drivers');
    }
  }
}

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Calendar',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 20),
        Text(
          'Texte 2',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 20),
        YourButton(text: 'Quitter 1'),
      ],
    );
  }
}

class DriversWidget extends StatelessWidget {
  final Future<List<Driver>> futureDrivers;

  const DriversWidget({required this.futureDrivers});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Driver>>(
      future: futureDrivers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final drivers = snapshot.data!;
          return ListView.builder(
            itemCount: drivers.length,
            itemBuilder: (context, index) {
              final driver = drivers[index];
              return ListTile(
                title: Text('${driver.firstName} ${driver.lastName}'),
              );
            },
          );
        }
      },
    );
  }
}

class YourButton extends StatelessWidget {
  final String text;
  const YourButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(text),
    );
  }
}

class Driver {
  final String firstName;
  final String lastName;

  Driver({
    required this.firstName,
    required this.lastName,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }
}

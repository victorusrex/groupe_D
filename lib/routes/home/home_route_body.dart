import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../drivers/drivers_route_body.dart';

class HomeRouteBody extends StatefulWidget {
  const HomeRouteBody({Key? key}) : super(key: key);

  @override
  State<HomeRouteBody> createState() => _HomeRouteBodyState();
}

class _HomeRouteBodyState extends State<HomeRouteBody> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _selectedIndex == 0 ? CalendarWidget() : DriversRouteBody(),
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
}

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late Future<List<Session>> _futureSessions;
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _circuitController = TextEditingController();
  List<Session> _sessions = [];

  @override
  void initState() {
    super.initState();
    _futureSessions = fetchSessions();
  }

  Future<List<Session>> fetchSessions() async {
    final response = await http.get(Uri.parse(
        'https://api.openf1.org/v1/meetings?year=2023'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Session.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load sessions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Session>>(
      future: _futureSessions,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          _sessions = snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _sessions.length,
                  itemBuilder: (context, index) {
                    final session = _sessions[index];
                    return ListTile(
                      title: Text('${session.countryName} - ${session.sessionName}'),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _showInsertForm(context);
                },
                child: Text('Insérer'),
              ),
            ],
          );
        }
      },
    );
  }

  void _showInsertForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Insérer un nouveau circuit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _countryController,
                decoration: InputDecoration(labelText: 'Pays'),
              ),
              TextField(
                controller: _circuitController,
                decoration: InputDecoration(labelText: 'Nom du circuit'),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _insertSession(_countryController.text, _circuitController.text);
              },
              child: Text('Insérer'),
            ),
          ],
        );
      },
    );
  }

  void _insertSession(String countryName, String circuitName) {
    setState(() {
      _sessions.add(Session(countryName: countryName, sessionName: circuitName));
    });
  }
}

class Session {
  final String countryName;
  final String? sessionName;

  Session({
    required this.countryName,
    this.sessionName,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      countryName: json['country_name'],
      sessionName: json['circuit_short_name'],
    );
  }
}

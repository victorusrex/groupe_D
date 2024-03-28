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
  final TextEditingController _raceTypeController = TextEditingController(); // Ajout du contrôleur pour le type de course
  List<Session> _sessions = [];

  @override
  void initState() {
    super.initState();
    _futureSessions = fetchSessions();
  }

  Future<List<Session>> fetchSessions() async {
    final response = await http.get(Uri.parse(
        'https://api.openf1.org/v1/sessions?session_type=Race&session_type=Race&year=2023'));

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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CalendarDetailPage(session: session),
                          ),
                        );
                      },
                      title: Text('${session.countryName} - ${session.sessionName ?? ''}'),
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
              TextField(
                controller: _raceTypeController,
                decoration: InputDecoration(labelText: 'Type de course'), // Ajout du champ pour le type de course
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _insertSession(_countryController.text, _circuitController.text, _raceTypeController.text); // Ajout du paramètre pour le type de course
              },
              child: Text('Insérer'),
            ),
          ],
        );
      },
    );
  }

  void _insertSession(String countryName, String circuitName, String raceType) { // Ajout du paramètre pour le type de course
    setState(() {
      _sessions.add(Session(countryName: countryName, sessionName: circuitName, raceType: raceType)); // Correction : Utilisation de raceType
    });
  }
}

class Session {
  final String countryName;
  final String? sessionName;
  final String raceType;

  Session({
    required this.countryName,
    this.sessionName,
    required this.raceType,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      countryName: json['country_name'],
      sessionName: json['circuit_short_name'],
      raceType: json['session_name'] ?? 'Type inconnu',
    );
  }
}

class CalendarDetailPage extends StatelessWidget {
  final Session session;

  const CalendarDetailPage({Key? key, required this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(session.sessionName ?? ''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nom du circuit : ${session.sessionName}'),
            Text('Pays : ${session.countryName}'),
            Text('Type de la course : ${session.raceType}'),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeRouteBody(),
  ));
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DriversRouteBody extends StatefulWidget {
  const DriversRouteBody({Key? key}) : super(key: key);

  @override
  State<DriversRouteBody> createState() => _DriversRouteBodyState();
}

class _DriversRouteBodyState extends State<DriversRouteBody> {
  late Future<List<Driver>> _futureDrivers;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _driverNumberController = TextEditingController();
  final TextEditingController _teamNameController = TextEditingController();

  List<Driver> drivers = [];

  @override
  void initState() {
    super.initState();
    _futureDrivers = fetchDrivers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Driver>>(
      future: _futureDrivers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          drivers = snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: drivers.length,
                  itemBuilder: (context, index) {
                    final driver = drivers[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DriverDetailPage(driver: driver, showDriverNumber: true),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(driver.imageURL ?? ''),
                      ),
                      title: Center(child: Text(
                        '${driver.firstName} ${driver.lastName}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _showInsertForm(context);
                },
                child: Text('Insérer pilote'),
              ),
            ],
          );
        }
      },
    );
  }

  Future<List<Driver>> fetchDrivers() async {
    final response = await http.get(Uri.parse(
        'https://api.openf1.org/v1/drivers?session_key=9158'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Driver.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load drivers');
    }
  }

  void _showInsertForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Insérer un nouveau pilote'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'Prénom'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Nom'),
              ),
              TextField(
                controller: _driverNumberController,
                decoration: InputDecoration(labelText: 'Numéro de pilote'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _teamNameController,
                decoration: InputDecoration(labelText: 'Écurie'),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _insertDriver(
                  _firstNameController.text,
                  _lastNameController.text,
                  int.parse(_driverNumberController.text),
                  _teamNameController.text,
                );
              },
              child: Text('Insérer'),
            ),
          ],
        );
      },
    );
  }

  void _insertDriver(String firstName, String lastName, int driverNumber, String teamName) {
    setState(() {
      final newDriver = Driver(
        firstName: firstName,
        lastName: lastName,
        driverNumber: driverNumber,
        teamName: teamName,
        imageURL: '', // Vous pouvez définir une URL d'image par défaut si nécessaire
      );
      drivers.add(newDriver); // Ajoutez le nouveau pilote à la liste existante
    });
  }
}

class Driver {
  final String firstName;
  final String lastName;
  final String? imageURL;
  final int driverNumber;
  final String teamName;

  Driver({
    required this.firstName,
    required this.lastName,
    required this.driverNumber,
    required this.teamName,
    this.imageURL,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      firstName: json['first_name'],
      lastName: json['last_name'],
      driverNumber: json['driver_number'],
      teamName: json['team_name'],
      imageURL: json['headshot_url'],
    );
  }
}

class DriverDetailPage extends StatelessWidget {
  final Driver driver;
  final bool showDriverNumber;

  const DriverDetailPage({Key? key, required this.driver, required this.showDriverNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red, // Couleur de la barre d'applications en rouge
        title: Text('${driver.firstName} ${driver.lastName}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(driver.imageURL ?? ''),
              radius: 50,
            ),
            SizedBox(height: 20),
            Text('Nom : ${driver.lastName}', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Prénom : ${driver.firstName}', style: TextStyle(fontWeight: FontWeight.bold)),
            if (showDriverNumber)
              Text('Numéro du pilote : ${driver.driverNumber}', style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Nom de l'écurie : ${driver.teamName}", style: TextStyle(fontWeight: FontWeight.bold)) // Ajout du nom de l'écurie
          ],
        ),
      ),
    );
  }
}

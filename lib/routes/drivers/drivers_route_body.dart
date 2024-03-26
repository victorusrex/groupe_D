import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DriversRouteBody extends StatefulWidget {
  const DriversRouteBody({Key? key}) : super(key: key);

  @override
  State<DriversRouteBody> createState() => _DriversRouteBodyState();
}

class _DriversRouteBodyState extends State<DriversRouteBody> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Driver>>(
      future: fetchDrivers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
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

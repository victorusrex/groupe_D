import 'package:flutter/material.dart';

import '../home/home_route.dart';


class AccueilRoute extends StatelessWidget {
  const AccueilRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("assets/images/logo.png"),
          ),
          SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              onPressed: () => _goToCalendar(context),
              child: Text('F1 Presentation'),
            ),
          ),
        ],
      ),
    );
  }

  void _goToCalendar(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeRoute()),
    );
  }
}
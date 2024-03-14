import 'package:flutter/material.dart';

import 'home_route_body.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "F1 Présentation",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: const HomeRouteBody(),
    );
  }
}

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
          style: TextStyle(color: Colors.white), // Définir la couleur du texte en blanc
        ),
        backgroundColor: Colors.red, // Définir la couleur de l'AppBar en rouge
      ),
      body: const HomeRouteBody(),
    );
  }
}

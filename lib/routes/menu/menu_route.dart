import 'package:flutter/material.dart';

import '../home/home_route.dart';

class MenuRoute extends StatelessWidget {
  const MenuRoute({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _goToHome(context),
              child: Text('Clique '),
            ),
          ],
      )
    );
  }

  void _goToHome(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeRoute()),
    );
  }
}

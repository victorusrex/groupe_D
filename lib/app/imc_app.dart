import 'package:flutter/material.dart';
import '../routes/accueil/accueil_route.dart';

class ImcApp extends StatelessWidget {
  const ImcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'F1',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.blueAccent
        )
      ),
      home: const AccueilRoute(),
    );
  }
}

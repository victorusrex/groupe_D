import 'package:demo6/routes/home/home_route.dart';
import 'package:demo6/routes/menu/menu_route.dart';
import 'package:flutter/material.dart';

class ImcApp extends StatelessWidget {
  const ImcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC Calculator Ultra Pro Max+',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.blueAccent
        )
      ),
      home: const MenuRoute(),
    );
  }
}

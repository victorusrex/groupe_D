import 'package:demo6/routes/home/home_route_body.dart';
import 'package:flutter/material.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IMC Calculator Ultra Pro Max+")
      ),
      body: const HomeRouteBody(),
    );
  }
}
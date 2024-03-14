import 'package:flutter/material.dart';

import '../calendar/calendar_route_body.dart';
import 'drivers_route_body.dart';

class DriversRoute extends StatelessWidget {
  const DriversRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drivers")
      ),
      body: const DriversRouteBody(),
    );
  }
}


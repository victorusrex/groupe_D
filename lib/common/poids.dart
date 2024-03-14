import 'package:flutter/material.dart';

class Poids extends StatelessWidget {
  final double value;
  const Poids(this.value , {super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Poids : ${value.toStringAsFixed(1)}kg",
        style: const TextStyle(fontSize: 24)
    );
  }
}

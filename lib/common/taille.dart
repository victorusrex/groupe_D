import 'dart:math';

import 'package:flutter/material.dart';

class Taille extends StatelessWidget {
  final double value;
  const Taille(this.value , {super.key});

  @override
  Widget build(BuildContext context) {

    return Text("Taille : ${value.toStringAsFixed(2)} cm",
      style: const TextStyle(fontSize: 24)
    );
  }
}

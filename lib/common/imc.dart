import 'dart:math';

import 'package:flutter/material.dart';

class Imc extends StatelessWidget {

  final double poidsKg;
  final double tailleCm;
  const Imc({super.key, this.poidsKg = 0, this.tailleCm = 0});

  @override
  Widget build(BuildContext context) {

    if (tailleCm == 0){
      throw Exception("taille cannot be zero");
    }

    final num taille2 = pow(tailleCm/100.0, 2);
    final double imc = poidsKg / taille2 ;

    return Text(
      imc.toStringAsFixed(1),
      style : const TextStyle(fontSize: 64),
    );
  }
}

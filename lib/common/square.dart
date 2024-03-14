import 'dart:math';

import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  final Color color;
  final double hauteur;
  final double largueur;
  final bool applyRadius;

  const Square(this.color, {super.key, this.hauteur = 128, this.largueur = 128, this.applyRadius = true});

  @override
  Widget build(BuildContext context) {

    double r = 0 ;
    if(applyRadius) {
      r = 0.2 + max(largueur, hauteur?? 128);
    }

    return AnimatedContainer(
      width: largueur,
      height: hauteur,
      curve: Curves.elasticOut,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: color,
        border: Border.all(
          color: Colors.black,
          width: 2
        ),
        borderRadius: BorderRadius.circular(r)
      ), duration: Duration (milliseconds: 1750),
    );
  }
}

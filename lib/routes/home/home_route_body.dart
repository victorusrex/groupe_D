import 'dart:math';

import 'package:demo6/common/square.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/imc.dart';
import '../../common/poids.dart';
import '../../common/taille.dart';

class HomeRouteBody extends StatefulWidget {
  const HomeRouteBody({Key? key}) : super(key: key);

  @override
  State<HomeRouteBody> createState() => _HomeRouteBodyState();
}

class _HomeRouteBodyState extends State<HomeRouteBody> {

  double poids = 3.0;
  double taille = 50.0;

  bool initialized = false ;
  bool hasChange = false ;
  bool applyRadius = false;

  @override
  Widget build(BuildContext context) {

    // Initialisation des valeurs fron SharedPerferences

    if (!initialized) {
      SharedPreferences.getInstance().then((prefs) {
        var poids = prefs.getDouble('poids');
        var taille = prefs.getDouble('taille');

        setState(() {
          this.poids = poids ?? 3.0;
          this.taille = taille ?? 50.0;
          this.initialized = true;
        });
      });
    }


    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height* 0.4,
          child: Row(
            children: [
              RotatedBox(
                  quarterTurns: -1,
                  child: Slider(
                      value: taille, onChanged: onChanged2, min: 50, max: 200)),
              Expanded(
                child: Center(
                  child: Square(calculateColor(), hauteur: calculeHeight(), applyRadius: applyRadius,
                      largueur: calculeWidth()),
                ),
              ),
            ],
          ),
        ),

        Slider(value: poids, onChanged: onChanged, min: 3, max: 200),


        Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Taille(taille),
              Poids(poids),
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
        Imc(tailleCm: taille, poidsKg: poids),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Radius ?"),
            Checkbox(value: applyRadius, onChanged: onRadiusChanged),
          ],
        ),
        ElevatedButton(
            onPressed: hasChange ? onSave : null,
            child: const Text('Save', style: TextStyle(fontSize: 32, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        )

      ],
    );
  }

  void onChanged(double value) {
    setState(() {
      poids = value;
      hasChange = true ;
    });
  }

  void onChanged2(double value) {
    setState(() {
      taille = value;
      hasChange = true ;
    });
  }

  double calculeWidth() {
    return _calc(context, poids, 3.0, 200.0);
  }

  double calculeHeight() {
    return _calc(context, taille, 3, 200);
  }

  double _calc(BuildContext context, double value, double min, double max) {
    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final double ratio = (value - min) / (max - min);
    final double percent = (45.0 * ratio) + 5.0;
    return screenWidth * (percent / 100.0);
  }

  Color calculateColor() {
    final num taille2 = pow(taille/100.0, 2);
    final double imc = poids / taille2;

    if (imc < 10.5) {
      return Colors.blueAccent;
    } else if (imc < 24.9) {
      return Colors.greenAccent;
    } else if (imc < 29.9) {
      return Colors.yellow;
    } else if (imc < 34.9) {
      return Colors.orange;
    } else if (imc < 39.9) {
      return Colors.deepOrange;
    } else {
      return Colors.black;
    }
  }

  void onSave() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setDouble('poids', poids);
    prefs.setDouble('taille', taille);
    setState(() {
      hasChange = false ;
    });
  }

  void onRadiusChanged(bool? value) {
    setState(() {
      applyRadius = value == null || value;
    });
  }
}

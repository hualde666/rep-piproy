import 'dart:async';

import 'package:flutter/material.dart';
import 'package:piproy/scr/models/reloj_modelo.dart';
import 'package:piproy/widgets/clima.dart';
import 'package:piproy/widgets/pila.dart';
import 'package:piproy/widgets/reloj.dart';

class Pila_Timpo_Clima extends StatefulWidget {
  @override
  _Pila_Timpo_ClimaState createState() => _Pila_Timpo_ClimaState();
}

class _Pila_Timpo_ClimaState extends State<Pila_Timpo_Clima> {
  Timer startTimeout([int milliseconds]) {
    final timeout = Duration(seconds: 60);
    final ms = Duration(milliseconds: 1);
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    return Timer(duration, _actualizaHora);
  }

  @override
  void initState() {
    super.initState();

    // Set the initial values.
    startTimeout(1);
  }

  void _actualizaHora() {
    setState(() {
      startTimeout(null);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Clima(),
        Reloj(),
        NivelPila(),
      ]),
    );
  }
}

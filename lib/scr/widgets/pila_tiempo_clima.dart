import 'dart:async';

import 'package:flutter/material.dart';
import 'package:piproy/scr/providers/estado_celular.dart';

import 'package:piproy/scr/widgets/reloj.dart';
import 'package:provider/provider.dart';

class PilaTimpoClima extends StatefulWidget {
  @override
  _PilaTimpoClimaState createState() => _PilaTimpoClimaState();
}

class _PilaTimpoClimaState extends State<PilaTimpoClima> {
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
      startTimeout(10000);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final celProvider = Provider.of<EstadoProvider>(context);
    celProvider.actulizarDatos();
    return
        // Clima(),
        Reloj();
    //  NivelPila(),
  }
}

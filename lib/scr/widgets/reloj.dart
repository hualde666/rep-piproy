import 'dart:async';

import 'package:flutter/material.dart';
import 'package:piproy/scr/models/reloj_modelo.dart';
import 'package:piproy/scr/providers/estado_celular.dart';

import 'package:provider/provider.dart';

class HoraFecha extends StatefulWidget {
  @override
  _HoraFechaState createState() => _HoraFechaState();
}

class _HoraFechaState extends State<HoraFecha> {
  Timer startTimeout([int milliseconds]) {
    final timeout = Duration(seconds: 2);
    //final ms = Duration(milliseconds: 1000);
    //var duration = milliseconds == null ? timeout : ms * milliseconds;
    return Timer(timeout, _actualizaHora);
  }

  @override
  void initState() {
    super.initState();

    // Set the initial values.
    startTimeout(1);
  }

  void _actualizaHora() {
    if (mounted) {
      setState(() {
        startTimeout();
      });
    }
  }

  // @override
  // void dispose() {
  //   Timer(Duration(microseconds: 1), () {});
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final celProvider = Provider.of<EstadoProvider>(context);
    celProvider.actulizarDatos();
    return Reloj();
  }
}

class Reloj extends StatelessWidget {
//************************** */

  @override
  Widget build(BuildContext context) {
    final RelojModel reloj = RelojModel();

    return Container(
      // color: Colors.red,
      height: 130,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('${reloj.dias[reloj.diaweek - 1]}',
              style:
                  TextStyle(fontSize: 30, color: Theme.of(context).primaryColor
                      //fontWeight: FontWeight.bold,
                      )),
          Text('${reloj.shora}:${reloj.sminutos}',
              style:
                  TextStyle(fontSize: 50, color: Theme.of(context).primaryColor
                      // fontWeight: FontWeight.bold,
                      )),
          Text(
            '${reloj.dia} ${reloj.meses[reloj.mes - 1]} ',
            style:
                TextStyle(fontSize: 25, color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}

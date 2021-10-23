import 'package:flutter/material.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/db_provider.dart';
import 'package:provider/provider.dart';

Widget elementos(BuildContext context, Widget widget, double altura,
    String ruta, String tipo) {
  return GestureDetector(
    child: Container(
      height: altura,
      margin: EdgeInsets.symmetric(vertical: 1.5, horizontal: 3.0),
      alignment: Alignment.center,
      child: widget,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.white)),
    ),
    onTap: () {
      if (ruta != '') {
        if (tipo.contains('MPC')) {
          Provider.of<AplicacionesProvider>(context, listen: false)
              .tipoSeleccion = ruta;
          Navigator.pushNamed(context, 'grupo');
        } else {
          Navigator.pushNamed(context, ruta);
        }
      }
    },
    onLongPress: () {
      /// preguntar??
      if (tipo.contains('MPC')) {
        final String categoria = tipo.substring(3);
        Provider.of<AplicacionesProvider>(context, listen: false)
            .eliminarTipoMPC(categoria);
        DbTiposAplicaciones.db.eliminarTipoMPC(categoria);
      }
    },
  );
}

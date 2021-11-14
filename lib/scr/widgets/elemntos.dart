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
        Provider.of<AplicacionesProvider>(context, listen: false)
            .tipoSeleccion = ruta;
        if (tipo.contains('MPC')) {
          Navigator.pushNamed(context, 'grupo');
        } else {
          if (tipo.contains('MPG')) {
            Navigator.pushNamed(context, 'grupocontacto');
          } else {
            Navigator.pushNamed(context, ruta);
          }
        }
      }
    },
    onLongPress: () {
      /// preguntar??
      eliminarApi(context, tipo);
      // if (tipo.contains('MPC')) {
      //   final String categoria = tipo.substring(3);
      //   Provider.of<AplicacionesProvider>(context, listen: false)
      //       .eliminarTipoMPC(tipo);
      //   DbTiposAplicaciones.db.eliminarTipoMPC(categoria);
      // }
    },
  );
}

class ContactsPorGrupoPage {}

Future<dynamic> eliminarApi(BuildContext context, String tipo) {
  final String titulo = tipo.substring(3);
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text('¿Desea eliminar $titulo  del menú ?'),
      // shape: CircleBorder(),
      elevation: 14.0,
      actionsPadding: EdgeInsets.symmetric(horizontal: 30.0),
      actions: [
        TextButton(
            onPressed: () {
              /// elina api de pantalla
              Provider.of<AplicacionesProvider>(context, listen: false)
                  .eliminarTipoMP(tipo);

              DbTiposAplicaciones.db
                  .deleteApi(tipo.substring(0, 3), tipo.substring(3));

              //elimina api de BD

              Navigator.pop(context);
            },
            child: Text('Si', style: TextStyle(fontSize: 20.0))),
        TextButton(
            autofocus: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('No', style: TextStyle(fontSize: 20.0))),
      ],
    ),
  );
}

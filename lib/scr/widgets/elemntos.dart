import 'package:flutter/material.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/db_provider.dart';
import 'package:provider/provider.dart';

Widget elementos(BuildContext context, Widget widget, double altura,
    String ruta, String tipo) {
  bool eliminable = tipo != '' ? true : false;
  return GestureDetector(
    child: Container(
      height: altura,
      margin: EdgeInsets.symmetric(horizontal: 5),
      alignment: Alignment.center,
      child: eliminable
          ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                width: 30,
                height: 30,
              ),
              widget,
              GestureDetector(
                  onTap: () {
                    eliminarApi(context, tipo);
                  },
                  child: Container(
                      width: 30,
                      height: 30,
                      child: Center(
                        child: Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.red,
                        ),
                      ))),
            ])
          : widget,
      decoration: BoxDecoration(
          color: ruta == 'contactos' || tipo.contains('MPC')
              /** es un contacto o grupo de contacto */
              ? Colors.green
              : Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.white)),
    ),
    onTap: () {
      if (ruta != '') {
        Provider.of<AplicacionesProvider>(context, listen: false)
            .tipoSeleccion = ruta;
        if (tipo.contains('MPD')) {
          Navigator.pushNamed(context, 'grupo');
        } else {
          if (tipo.contains('MPC')) {
            Navigator.pushNamed(context, 'grupocontacto');
          } else {
            Navigator.pushNamed(context, ruta);
          }
        }
      }
    },
    // onLongPress: () {
    //   eliminarApi(context, tipo);
    // },
  );
}

Future<dynamic> eliminarApi(BuildContext context, String tipo) {
  final String titulo = tipo.substring(3);
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text('¿Desea eliminar $titulo  del menú principa?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
          )),
      // shape: CircleBorder(),
      elevation: 14.0,
      actionsPadding: EdgeInsets.symmetric(horizontal: 30.0),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        ElevatedButton(
            onPressed: () {
              /// elina api de pantalla
              Provider.of<AplicacionesProvider>(context, listen: false)
                  .eliminarTipoMP(tipo);

              DbTiposAplicaciones.db
                  .deleteApi(tipo.substring(0, 3), tipo.substring(3));

              //elimina api de BD

              Navigator.pop(context);
            },
            child: Text(
              'Si',
            )),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'NO',
            )),
        // TextButton(
        //     onPressed: () {
        //       /// elina api de pantalla
        //       Provider.of<AplicacionesProvider>(context, listen: false)
        //           .eliminarTipoMP(tipo);

        //       DbTiposAplicaciones.db
        //           .deleteApi(tipo.substring(0, 3), tipo.substring(3));

        //       //elimina api de BD

        //       Navigator.pop(context);
        //     },
        //     child: Text('Si', style: TextStyle(fontSize: 20.0))),
        // TextButton(
        //     autofocus: true,
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     child: Text('No', style: TextStyle(fontSize: 20.0))),
      ],
    ),
  );
}

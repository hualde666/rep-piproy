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
    onLongPress: () {
      if (tipo.contains('MPC') || tipo.contains('MPD')) {
        editarTipo(context, tipo);
      }
    },
  );
}
//******************** EDITA NOMBRE DEL GRUPO*****************************/

Future editarTipo(BuildContext context, String tipo) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return editarGrupoForm(context, tipo);
      });
}

AlertDialog editarGrupoForm(BuildContext context, String tipo) {
  final grupo = tipo.substring(3);
  final clase = tipo.substring(0, 3);
  final apiProvider = Provider.of<AplicacionesProvider>(context);
  final TextEditingController _tipoControle =
      TextEditingController(text: grupo);
  return AlertDialog(
    content: Form(
      child: Container(
        height: 170,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Editar nombre de grupo ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                )),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              // initialValue: grupo,
              textCapitalization: TextCapitalization.words,
              style: TextStyle(
                fontSize: 30,
              ),
              controller: _tipoControle,
              validator: (valor) {
                // validar que no exite ya

                return valor.isNotEmpty ? null : "dato invalido";
              },
              decoration: InputDecoration(hintText: "nombre del grupo"),
            )
          ],
        ),
      ),
    ),
    actionsAlignment: MainAxisAlignment.spaceAround,
    actions: [
      ElevatedButton(
          onPressed: () {
            // no puede estar en blanco ni ya definido
            if (_tipoControle.value.text != "" &&
                !apiProvider.contactgrupos.contains(_tipoControle.value.text)) {
              // agregar a BD
              String grupoNuevo = _tipoControle.value.text[0].toUpperCase();
              if (_tipoControle.value.text.length > 1) {
                grupoNuevo = _tipoControle.value.text[0].toUpperCase() +
                    _tipoControle.value.text.substring(1);
              }
              if (clase == 'MPC') {
                apiProvider.cambiarGrupoContact(grupo, grupoNuevo);
              } else {
                apiProvider.cambiarGrupoApi(grupo, grupoNuevo);
              }

              if (apiProvider.listaMenu.contains(clase + grupo)) {
                Provider.of<AplicacionesProvider>(context, listen: false)
                    .agregarMenu(clase + grupoNuevo);
                Provider.of<AplicacionesProvider>(context, listen: false)
                    .eliminarTipoMP(clase + grupo);
                DbTiposAplicaciones.db.modificarGrupo(grupo, grupoNuevo);
                DbTiposAplicaciones.db
                    .modificarNombre(grupo, grupoNuevo, clase);
              }
            }

            Navigator.of(context).pop();
          },
          style:
              ElevatedButton.styleFrom(primary: Color.fromRGBO(249, 75, 11, 1)),
          child: Text(
            'Si',
            style: TextStyle(fontSize: 25, color: Colors.white),
          )),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style:
              ElevatedButton.styleFrom(primary: Color.fromRGBO(249, 75, 11, 1)),
          child: Text(
            'No',
            style: TextStyle(fontSize: 25, color: Colors.white),
          )),
    ],
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

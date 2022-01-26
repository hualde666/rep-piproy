import 'package:flutter/material.dart';

import 'package:piproy/scr/models/api_tipos.dart';
import 'package:piproy/scr/models/contactos_modelo.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';
import 'package:piproy/scr/providers/db_provider.dart';
import 'package:piproy/scr/widgets/icon_conteiner.dart';
import 'package:provider/provider.dart';

class TarjetaContacto2 extends StatefulWidget {
  TarjetaContacto2(this.context, this.contacto, this.envio, this.eliminar);
  final BuildContext context;
  final ContactoDatos contacto;
  //**** boleana envio true el contacto tiene la opcion de enviar al menu principal */
  final bool envio;
  final bool eliminar;

  @override
  _TarjetaContacto2 createState() => _TarjetaContacto2();
}

class _TarjetaContacto2 extends State<TarjetaContacto2> {
  bool oneTap;

  @override
  void initState() {
    super.initState();
    oneTap = false;
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);

    final grupo = apiProvider.tipoSeleccion;

    return oneTap
        ? GestureDetector(
            child: Container(
              height: 225,
              margin: EdgeInsets.symmetric(horizontal: 4, vertical: 2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //_avatar(contacto),
                  SizedBox(
                    height: 10,
                  ),
                  _nombreContacto(context, widget.contacto, grupo, widget.envio,
                      widget.eliminar),

                  _botonesContactos(context, widget.contacto),
                ],
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.white38, width: 1.0)),
            ),
            onTap: () {
              oneTap = !oneTap;
              setState(() {});
              // Navigator.pushNamed(context, 'editarContacto', arguments: contacto);
            },
          )
        : GestureDetector(
            child: Container(
              height: 60,

              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2.0),
              child:
                  //_avatar(contacto),
                  _nombreContacto(context, widget.contacto, grupo, widget.envio,
                      widget.eliminar),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.white38)),
              // borderRadius: BorderRadius.circular(35.0),
            ),
            onTap: () {
              oneTap = !oneTap;
              setState(() {});
              // Navigator.pushNamed(context, 'editarContacto', arguments: contacto);
            },
          );
  }
}

_eliminarContacto(ContactoDatos contacto) async {
  // final resp = await Permission.contacts.request();

  // if (resp == PermissionStatus.granted) {
  //   await ContactsService.deleteContact(contacto);
  // }

  return;
}

Widget _botonesContactos(BuildContext context, ContactoDatos contacto) {
  final List<Widget> _listaWidget = [
    Column(
      children: [
        Container(
          height: 75,
          width: 75,
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            //color: Colors.black,
          ),
          child: conteinerIcon(
              context,
              Icon(
                Icons.call,
                size: 50.0,
                // color: Colors.white,
              ),
              'whatsapp',
              contacto),
        ),
        //  Divider(),
        Text(
          'Whatsapp',
          style: TextStyle(fontSize: 15),
        )
      ],
    ),
    SizedBox(
      width: 10,
    ),
    Column(
      children: [
        Container(
          height: 75,
          width: 75,
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            //    color: Colors.black,
          ),
          child: conteinerIcon(
              context,
              Icon(
                Icons.call,
                size: 50.0,
              ),
              'llamada',
              contacto),
        ),
        Text(
          'Llamar',
          style: TextStyle(fontSize: 15),
        )
      ],
    ),
    SizedBox(
      width: 10,
    ),

    Column(
      children: [
        Container(
          height: 75,
          width: 75,
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            // color: Colors.black,
          ),
          child: conteinerIcon(context, Icon(Icons.message_rounded, size: 50.0),
              'mensajeC', contacto),
        ),
        Text(
          'Mensajes',
          style: TextStyle(fontSize: 15),
        )
      ],
    ),
    SizedBox(
      width: 10,
    ),
    Column(
      children: [
        Container(
          height: 75,
          width: 75,
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            // color: Colors.black,
          ),
          child: conteinerIcon(
              context,
              Icon(
                Icons.search,
                size: 50.0,
              ),
              'editar',
              contacto),
        ),
        Text(
          'Datos',
          style: TextStyle(fontSize: 15),
        )
      ],
    ),
    // SizedBox(
    //   width: 10,
    // ),
    // Column(
    //   children: [
    //     Container(
    //       height: 75,
    //       width: 75,
    //       margin: EdgeInsets.only(top: 10),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(80),
    //         color: Colors.black,
    //       ),
    //       child: conteinerIcon(
    //           context,
    //           Icon(Icons.video_call, size: 50.0),
    //           'video',
    //           null),
    //     ),
    //     Text(
    //       ' Video',
    //       style: TextStyle(fontSize: 15),
    //     )
    //   ],
    // ),
  ];

  return Container(
    height: 115.0,
    width: 330,
    child: ListView.builder(
      // controller: PageController(viewportFraction: 0.1),
      scrollDirection: Axis.horizontal,
      itemCount: _listaWidget.length,
      itemBuilder: (context, i) => _listaWidget[i],
    ),
  );
}

Widget _nombreContacto(BuildContext context, ContactoDatos contacto,
    String grupo, bool envio, bool eliminar) {
  Future<dynamic> eliminarContactoGrupo(
          BuildContext context, String grupo, ContactoDatos contacto) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(contacto.nombre,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
              )),
          content: grupo == 'Todos'
              ? Text('¿Desea eliminar este contacto  del CELULAR ?')
              : Text('¿Desea eliminar este contacto del grupo $grupo ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                  )),
          //                 style: TextStyle(
          //                   fontSize: 25,
          //                 )),
          // shape: CircleBorder(),

          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            ElevatedButton(
                onPressed: () {
                  DbTiposAplicaciones.db
                      .deleteApi(grupo, contacto.nombre); //elimina api de BD
                  /// elina contacto de pantalla
                  Provider.of<AplicacionesProvider>(context, listen: false)
                      .eliminarContacto(grupo, contacto);

                  // elimino contacto del celular
                  if (grupo == 'Todos') {
                    _eliminarContacto(contacto);
                    final contactosProvider = new ContactosProvider();
                    contactosProvider.borrarDeListaContacto(contacto);
                  } else {}

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
          ],
        ),
      );
  Future<dynamic> agregarMPA(
      BuildContext context, ContactoDatos contacto) async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(contacto.nombre,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                  )),
              content: Text('¿Desea agregar este contacto al menu principal ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                  )),
              //                 style: TextStyle(
              //                   fontSize: 25,
              //                 )),
              // shape: CircleBorder(),
              elevation: 14.0,
              actionsPadding: EdgeInsets.symmetric(horizontal: 30.0),
              actionsAlignment: MainAxisAlignment.spaceAround,
              actions: [
                ElevatedButton(
                    onPressed: () {
                      final nuevo =
                          new ApiTipos(grupo: 'MPA', nombre: contacto.nombre);

                      /// actualizar lista MENU
                      ///
                      Provider.of<AplicacionesProvider>(context, listen: false)
                          .agregarMenu('MPA' + contacto.nombre);

                      DbTiposAplicaciones.db.nuevoTipo(nuevo);

                      Navigator.of(context).pop();
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
              ],
            ));
  }

  Future<dynamic> eliminarContactoMP(BuildContext context, String tipo) {
    final String titulo = tipo.substring(3);
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('¿Desea eliminar $titulo  del menú principal?',
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
              child: Text('Si')),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('NO')),
        ],
      ),
    );
  }

  return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor, //Colors.green[700],
        borderRadius: BorderRadius.circular(20.0),
      ),
      //border: Border.all()),
      //.fromRGBO(55, 57, 84, 1.0),
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 2),
      child:
          // _avatar(context, contacto),

          Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          envio
              ? GestureDetector(
                  onTap: () {
                    agregarMPA(context, contacto);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ))
              : Container(
                  height: 30,
                  width: 30,
                ),
          Container(
            width: MediaQuery.of(context).size.width - 80,
            child: Text(
              contacto.nombre,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 45.0,
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                if (envio) {
                  if (grupo != 'Todos') {
                    eliminarContactoGrupo(context, grupo, contacto);
                  }
                  // eliminar contacto del grupo

                } else {
                  // eliminar contacto menu principal
                  eliminarContactoMP(context, 'MPA' + contacto.nombre);
                }
              },
              child: eliminar
                  ? Container(
                      width: 30,
                      height: 30,
                      child: Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.red,
                      ),
                    )
                  : Container(
                      height: 30,
                      width: 30,
                    ))
        ],
      ));
}

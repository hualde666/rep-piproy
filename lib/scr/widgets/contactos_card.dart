import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:piproy/scr/models/api_tipos.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';
import 'package:piproy/scr/providers/db_provider.dart';
import 'package:piproy/scr/widgets/icon_conteiner.dart';
import 'package:provider/provider.dart';

class TarjetaContacto2 extends StatefulWidget {
  TarjetaContacto2(this.context, this.contacto, this.envio);
  final BuildContext context;
  final Contact contacto;
  //**** boleana envio true el contacto tiene la opcion de enviar al menu principal */
  final bool envio;

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
                  _nombreContacto(
                      context, widget.contacto, grupo, widget.envio),

                  _botonesContactos(context, widget.contacto),
                ],
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.white, width: 1.0)),
            ),
            onTap: () {
              oneTap = !oneTap;
              setState(() {});
              // Navigator.pushNamed(context, 'editarContacto', arguments: contacto);
            },
          )
        : GestureDetector(
            child: Container(
              height: 100,

              margin: EdgeInsets.symmetric(horizontal: 4, vertical: 2.0),
              child:
                  //_avatar(contacto),
                  _nombreContacto(
                      context, widget.contacto, grupo, widget.envio),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.white)),
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

_eliminarContacto(Contact contacto) async {
  final resp = await Permission.contacts.request();

  if (resp == PermissionStatus.granted) {
    await ContactsService.deleteContact(contacto);
  }

  return;
}

Widget _botonesContactos(BuildContext context, Contact contacto) {
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

Widget _nombreContacto(
    BuildContext context, Contact contacto, String grupo, bool envio) {
  Future<dynamic> eliminarContactoGrupo(
          BuildContext context, String grupo, Contact contacto) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(contacto.displayName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
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
                  DbTiposAplicaciones.db.deleteApi(
                      grupo, contacto.displayName); //elimina api de BD
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
  Future<dynamic> agregarMPA(BuildContext context, Contact contacto) async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(contacto.displayName,
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
                      final nuevo = new ApiTipos(
                          grupo: 'MPA', nombre: contacto.displayName);

                      /// actualizar lista MENU
                      ///
                      Provider.of<AplicacionesProvider>(context, listen: false)
                          .agregarMenu('MPA' + contacto.displayName);

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
              contacto.displayName,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 35.0,
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                if (envio) {
                  // eliminar contacto del grupo
                  eliminarContactoGrupo(context, grupo, contacto);
                } else {
                  // eliminar contacto menu principal
                  eliminarContactoMP(context, 'MPA' + contacto.displayName);
                }
              },
              child: Container(
                width: 30,
                height: 30,
                child: Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.red,
                ),
              )),
        ],
      ));
}

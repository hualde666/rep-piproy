import 'package:flutter/material.dart';

import 'package:piproy/scr/models/api_tipos.dart';

import 'package:piproy/scr/pages/contacts_por_grupo.dart';

import 'package:piproy/scr/providers/db_provider.dart';
import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';

import 'package:piproy/scr/providers/aplicaciones_provider.dart';

class ContactsGruposPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    final List<String> listaGrupos = apiProvider.contactgrupos;
    return SafeArea(
        child: Scaffold(
      appBar: headerApp(context, 'Grupos de Contactos', Text(''), 0.0, true,
          'ContactoGrupos'),
      resizeToAvoidBottomInset: false,
      // backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: EdgeInsets.only(bottom: 40),
        child: ListView.builder(
            padding: EdgeInsets.only(bottom: 100),
            itemCount: listaGrupos.length,
            itemBuilder: (context, i) {
              return grupo(context, listaGrupos[i]);
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
          heroTag: "agregar",
          icon: Icon(
            Icons.add,
          ),
          label: Text(
            'agregar',
          ),
          onPressed: () {
            //Definir nuevo grupo
            crearTipo(context);
          }),
    ));
  }

  Widget grupo(
    BuildContext context,
    String grupo,
  ) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    double ancho = 280;

    if (width <= 320) {
      ancho = 200;
    }
    return GestureDetector(
        //   onTap: () {
        //     Provider.of<AplicacionesProvider>(context, listen: false)
        //         .tipoSeleccion = grupo;
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => ContactsPorGrupoPage()),
        //     );
        //   },
        onLongPress: () {
          if (grupo != 'Todos') {
            editarTipo(context, grupo);
          }
        },
        //   onDoubleTap: () => agregaMPG(context, grupo),
        //   child:
        // return
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 3, horizontal: 4.0),
            height: 70,
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Theme.of(context).primaryColor)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (grupo != 'Todos') {
                        //**  agrega grupo de contacto al menu principal */
                        agregaMPC(context, grupo);
                      }
                    },
                    child: grupo != 'Todos'
                        ? Container(
                            width: 30,
                            height: 30,
                            child: Center(
                              child: Icon(
                                Icons.arrow_back,
                                size: 30,
                                color: Colors.blue,
                              ),
                            ),
                          )
                        : Container(
                            width: 30,
                            height: 30,
                          ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<AplicacionesProvider>(context, listen: false)
                          .tipoSeleccion = grupo;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactsPorGrupoPage()),
                      );
                    },
                    child: Container(
                      width: ancho,
                      child: Center(
                        child: Text(
                          grupo,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (grupo != 'Todos') {
                        eliminarTipo(context, grupo);
                      }
                    },
                    child: (grupo != 'Todos' && grupo != 'Emergencia')
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
                          ),
                  ),
                ])));
  }

  ///
  ///************** CREA  CATEGORIA ************/
  ///

  Future crearTipo(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return crearGrupoForm(context);
        });
  }

  AlertDialog crearGrupoForm(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    final TextEditingController _tipoControle = TextEditingController();
    double height = (MediaQuery.of(context).size.height);
    return AlertDialog(
      content: Form(
        child: Container(
          height: height <= 500 ? 70 : 140,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height <= 500 ? 10 : 90,
                child: Text('Crear grupo de Contacto',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: height <= 500 ? 10 : 30,
                    )),
              ),
              SizedBox(
                height: height <= 500 ? 2 : 10,
              ),
              Container(
                height: height <= 500 ? 24 : 30,
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  style: TextStyle(
                    fontSize: height <= 500 ? 15 : 25,
                  ),
                  controller: _tipoControle,
                  validator: (valor) {
                    // validar que no exite ya

                    return valor.isNotEmpty ? null : "dato invalido";
                  },
                  decoration: InputDecoration(hintText: "nombre del grupo"),
                ),
              )
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        Container(
          height: height <= 500 ? 20 : 30,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  //change width and height on your need width = 200 and height = 50
                  minimumSize: Size(30, 20),
                  primary: Color.fromRGBO(249, 75, 11, 1)),
              onPressed: () {
                String grupo = '';
                if (_tipoControle.value.text.isNotEmpty) {
                  grupo = _tipoControle.value.text[0].toUpperCase() +
                      _tipoControle.value.text.substring(1);

                  // no puede estar en blanco ni ya definido
                  if (!apiProvider.contactgrupos.contains(grupo)) {
                    // agregar a BD

                    apiProvider.agregarGrupoContact(grupo);
                    final nuevo =
                        new ApiTipos(grupo: grupo, nombre: "", tipo: "2");
                    DbTiposAplicaciones.db.nuevoTipo(nuevo);
                  }

                  Navigator.of(context).pop();
                }
              },
              child: Text(
                'Si',
                style: TextStyle(
                    fontSize: height <= 500 ? 15 : 25, color: Colors.white),
              )),
        ),
        Container(
          height: height <= 500 ? 20 : 30,
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                  //change width and height on your need width = 200 and height = 50
                  minimumSize: Size(30, 20),
                  primary: Color.fromRGBO(249, 75, 11, 1)),
              child: Text(
                'No',
                style: TextStyle(
                    fontSize: height <= 500 ? 15 : 25, color: Colors.white),
              )),
        ),
      ],
    );
  }

  ///
  ///************** ELIMINA CATEGORIA ************/
  ///
  Future eliminarTipo(BuildContext context, String grupo) async {
    if (grupo == 'Todos') {
      return;
    }
    if (grupo == 'Emergencia') {
      return;
    }
    return await showDialog(
        context: context,
        builder: (context) {
          return eliminarGrupoForm(context, grupo);
        });
  }

  AlertDialog eliminarGrupoForm(BuildContext context, String grupo) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    return AlertDialog(
      title: Text(
        ' Eliminar Grupo',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
        ),
      ),
      content: Text('¿Desea ELIMINAR grupo de contacto $grupo ?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
          )),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        ElevatedButton(
            onPressed: () {
              // Eliminar de categoria

              Provider.of<AplicacionesProvider>(context, listen: false)
                  .eliminarContactTipos(grupo);
              // eliminar  en la  BD
              DbTiposAplicaciones.db.eliminarGrupo(grupo);

              ///
              ///         ELIMNAR DEL MENU PRINCIPAL

              if (apiProvider.listaMenu.contains('MPC' + grupo)) {
                Provider.of<AplicacionesProvider>(context, listen: false)
                    .eliminarTipoMP('MPG' + grupo);
                DbTiposAplicaciones.db.eliminarGrupoMP(grupo);
              }

              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
                //change width and height on your need width = 200 and height = 50
                minimumSize: Size(30, 20),
                primary: Color.fromRGBO(249, 75, 11, 1)),
            child: Text(
              'Si',
              style: TextStyle(fontSize: 25, color: Colors.white),
            )),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
                //change width and height on your need width = 200 and height = 50
                minimumSize: Size(30, 20),
                primary: Color.fromRGBO(249, 75, 11, 1)),
            child: Text(
              'No',
              style: TextStyle(fontSize: 25, color: Colors.white),
            )),
      ],
    );
  }

  Future agregaMPC(BuildContext context, String grupo) async {
    // grupo es el nombre de categoria a agregar al menu principal
    return await showDialog(
        context: context,
        builder: (context) {
          return agregaMpcForm(context, grupo);
        });
  }

  AlertDialog agregaMpcForm(BuildContext context, String grupo) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    return AlertDialog(
      content:
          Text('¿Desea crear  acceso directo de $grupo  en menu principal?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
              )),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        ElevatedButton(
            onPressed: () {
              final nuevo =
                  new ApiTipos(grupo: 'MPC', nombre: grupo, tipo: "3");
              if (!apiProvider.listaMenu.contains('MPC' + grupo)) {
                /// actualizar lista MENU
                ///
                Provider.of<AplicacionesProvider>(context, listen: false)
                    .agregarMenu('MPC' + grupo);

                DbTiposAplicaciones.db.nuevoTipo(nuevo);
              }

              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
                //change width and height on your need width = 200 and height = 50
                minimumSize: Size(30, 20),
                primary: Color.fromRGBO(249, 75, 11, 1)),
            child: Text(
              'Si',
              style: TextStyle(fontSize: 25, color: Colors.white),
            )),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                //change width and height on your need width = 200 and height = 50
                minimumSize: Size(30, 20),
                primary: Color.fromRGBO(249, 75, 11, 1)),
            child: const Text('NO',
                style: TextStyle(fontSize: 25, color: Colors.white))),
      ],
    );
  }
//******************** EDITA NOMBRE DEL GRUPO*****************************/

  Future editarTipo(BuildContext context, String grupo) async {
    if (grupo == 'Todos') {
      return;
    }
    if (grupo == 'Emergencia') {
      return;
    }
    return await showDialog(
        context: context,
        builder: (context) {
          return editarGrupoForm(context, grupo);
        });
  }

  AlertDialog editarGrupoForm(BuildContext context, String grupo) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    final TextEditingController _tipoControle =
        TextEditingController(text: grupo);
    double height = (MediaQuery.of(context).size.height);
    return AlertDialog(
      content: Form(
        child: Container(
          height: height <= 500 ? 80 : 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height <= 500 ? 19 : 60,
                child: Text('Editar nombre de grupo de Contacto',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: height <= 500 ? 10 : 25,
                    )),
              ),
              SizedBox(
                height: height <= 500 ? 2 : 10,
              ),
              Container(
                height: height <= 500 ? 15 : 50,
                child: TextFormField(
                  // initialValue: grupo,
                  textCapitalization: TextCapitalization.words,
                  style: TextStyle(
                    fontSize: height <= 500 ? 15 : 25,
                  ),
                  controller: _tipoControle,
                  validator: (valor) {
                    // validar que no exite ya

                    return valor.isNotEmpty ? null : "dato invalido";
                  },
                  decoration: InputDecoration(hintText: "nombre del grupo"),
                ),
              )
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        Container(
          height: height <= 500 ? 20 : 30,
          child: ElevatedButton(
              onPressed: () {
                String grupoNuevo = "";
                if (_tipoControle.value.text.isNotEmpty) {
                  grupoNuevo = _tipoControle.value.text[0].toUpperCase() +
                      _tipoControle.value.text.substring(1);

                  // no puede estar en blanco ni ya definido
                  if (!apiProvider.contactgrupos.contains(grupoNuevo)) {
                    // agregar a BD

                    apiProvider.cambiarGrupoContact(grupo, grupoNuevo);
                    if (apiProvider.listaMenu.contains('MPC' + grupo)) {
                      Provider.of<AplicacionesProvider>(context, listen: false)
                          .agregarMenu('MPC' + grupoNuevo);
                      Provider.of<AplicacionesProvider>(context, listen: false)
                          .eliminarTipoMP('MPC' + grupo);

                      DbTiposAplicaciones.db
                          .modificarNombre(grupo, grupoNuevo, 'MPC');
                    }
                    DbTiposAplicaciones.db.modificarGrupo(grupo, grupoNuevo);
                  }

                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                  //change width and height on your need width = 200 and height = 50
                  minimumSize: Size(30, 20),
                  primary: Color.fromRGBO(249, 75, 11, 1)),
              child: Text(
                'Si',
                style: TextStyle(
                    fontSize: height <= 500 ? 15 : 25, color: Colors.white),
              )),
        ),
        Container(
          height: height <= 500 ? 20 : 30,
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                  //change width and height on your need width = 200 and height = 50
                  minimumSize: Size(30, 20),
                  primary: Color.fromRGBO(249, 75, 11, 1)),
              child: Text(
                'No',
                style: TextStyle(
                    fontSize: height <= 500 ? 15 : 25, color: Colors.white),
              )),
        ),
      ],
    );
  }
}

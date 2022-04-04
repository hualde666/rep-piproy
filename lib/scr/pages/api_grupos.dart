import 'package:flutter/material.dart';

import 'package:piproy/scr/models/api_tipos.dart';
import 'package:piproy/scr/pages/api_por_grupos.dart';

import 'package:piproy/scr/providers/db_provider.dart';
import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';

import 'package:piproy/scr/providers/aplicaciones_provider.dart';

class ApiGruposPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    final List<String> listaGrupos = apiProvider.apigrupos;
    return SafeArea(
        child: Scaffold(
      appBar: headerApp(
          context, 'Grupos Aplicaciones', Text(''), 0.0, true, 'ApiGrupos'),
      resizeToAvoidBottomInset: false,
      //  backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: EdgeInsets.only(bottom: 55),
        child: ListView.builder(
            padding: EdgeInsets.only(bottom: 65),
            itemCount: listaGrupos.length,
            itemBuilder: (context, i) {
              return grupo(context, listaGrupos[i]);
            }),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          //BotonFlotante(pagina: 'grupoApi'),
          FloatingActionButton.extended(
              heroTag: "agregar",
              icon: Icon(
                Icons.add,
              ),
              label: Text(
                'agregar',
              ),
              onPressed: () {
                // SELECCION DE API POR TIPO
                //_seleccionApi(context, tipo);
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
      onLongPress: () {
        if (grupo != 'Todas') {
          editarTipo(context, grupo);
        }
      },
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 3, horizontal: 4.0),
          height: 60,
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Theme.of(context).primaryColor)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  if (grupo != 'Todas') {
                    agregaMPD(context, grupo);
                  }
                },
                child: grupo != 'Todas'
                    ? Container(
                        width: 30,
                        height: 30,
                        child: Center(
                          child: Icon(
                            Icons.arrow_back,
                            size: 20,
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
                          builder: (context) => ApiPorGrupoPage()));
                },
                child: Container(
                  width: ancho,
                  // color: Theme.of(context),
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
                  if (grupo != 'Todas') {
                    eliminarTipo(context, grupo);
                  }
                },
                child: grupo != 'Todas'
                    ? Container(
                        width: 30,
                        height: 30,
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.red,
                        ),
                      )
                    : Container(
                        height: 30,
                        width: 30,
                      ),
              ),
            ],
          )),
    );
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
      content: SingleChildScrollView(
        child: Form(
          child: Container(
            height: height <= 500 ? 70 : 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: height <= 500 ? 10 : 60,
                  child: Text('Crear grupo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: height <= 500 ? 10 : 30,
                      )),
                ),
                SizedBox(
                  height: height <= 500 ? 2 : 10,
                ),
                Container(
                  height: height <= 500 ? 25 : 30,
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
                String grupo;
                if (_tipoControle.value.text.isNotEmpty) {
                  grupo = _tipoControle.value.text[0].toUpperCase() +
                      _tipoControle.value.text.substring(1);

                  if (!apiProvider.apigrupos.contains(grupo)) {
                    // agregar a BD

                    apiProvider.agregarApiGrupo(grupo);
                    final nuevo =
                        new ApiTipos(grupo: grupo, nombre: "", tipo: "1");
                    DbTiposAplicaciones.db.nuevoTipo(nuevo);
                  }

                  Navigator.of(context).pop();
                }
              },
              child: Text(
                'Si',
                style: TextStyle(fontSize: height <= 500 ? 15 : 25),
              )),
        ),
        Container(
          height: height <= 500 ? 20 : 30,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  //change width and height on your need width = 200 and height = 50
                  minimumSize: Size(30, 20),
                  primary: Color.fromRGBO(249, 75, 11, 1)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'No',
                style: TextStyle(fontSize: height <= 500 ? 15 : 25),
              )),
        ),
      ],
    );
  }

  ///
  ///************** ELIMINA CATEGORIA ************/
  ///
  Future eliminarTipo(BuildContext context, String tipo) async {
    if (tipo == 'Todas') {
      return;
    }
    return await showDialog(
        context: context,
        builder: (context) {
          return eliminarTipoForm(context, tipo);
        });
  }

  AlertDialog eliminarTipoForm(BuildContext context, String grupo) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    return AlertDialog(
      title: Text(
        ' Eliminar Grupo',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
        ),
      ),
      content: Text(
        '¿Desea ELIMINAR el grupo $grupo ?',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                //change width and height on your need width = 200 and height = 50
                minimumSize: Size(30, 20),
                primary: Color.fromRGBO(249, 75, 11, 1)),
            onPressed: () {
              // Eliminar de categoria

              Provider.of<AplicacionesProvider>(context, listen: false)
                  .eliminarTipos(grupo);
              // eliminar  a BD
              DbTiposAplicaciones.db.eliminarGrupo(grupo);

              ///
              ///         ELIMNAR DEL MENU PRINCIPAL

              if (apiProvider.listaMenu.contains('MPD' + grupo)) {
                Provider.of<AplicacionesProvider>(context, listen: false)
                    .eliminarTipoMP('MPD' + grupo);
                DbTiposAplicaciones.db.eliminarGrupoMP(grupo);
              }

              Navigator.of(context).pop();
            },
            child: Text(
              'Si',
            )),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                //change width and height on your need width = 200 and height = 50
                minimumSize: Size(30, 20),
                primary: Color.fromRGBO(249, 75, 11, 1)),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'No',
            )),
      ],
    );
  }

  Future agregaMPD(BuildContext context, String grupo) async {
    // grupo es el nombre de categoria a agregar al menu principal
    return await showDialog(
        context: context,
        builder: (context) {
          return agregaMpdForm(context, grupo);
        });
  }

  AlertDialog agregaMpdForm(BuildContext context, String grupo) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    return AlertDialog(
      title: Text('Copiar grupo al Menu Inicio',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
          )),
      content: Text('¿Desea copiar  $grupo  al  menu principal?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
          )),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                //change width and height on your need width = 200 and height = 50
                minimumSize: Size(30, 20),
                primary: Color.fromRGBO(249, 75, 11, 1)),
            onPressed: () {
              final nuevo = new ApiTipos(grupo: 'MPD', nombre: grupo);
              if (!apiProvider.listaMenu.contains('MPD' + grupo)) {
                /// actualizar lista MENU
                ///
                Provider.of<AplicacionesProvider>(context, listen: false)
                    .agregarMenu('MPD' + grupo);

                DbTiposAplicaciones.db.nuevoTipo(nuevo);
              }

              Navigator.of(context).pop();
            },
            child: Text(
              'Si',
            )),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                //change width and height on your need width = 200 and height = 50
                minimumSize: Size(30, 20),
                primary: Color.fromRGBO(249, 75, 11, 1)),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('NO')),
      ],
    );
  }
  //******************** EDITA NOMBRE DEL GRUPO*****************************/

  Future editarTipo(BuildContext context, String grupo) async {
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
          height: height <= 500 ? 80 : 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height <= 500 ? 19 : 60,
                child: Text('Editar nombre de grupo de Aplicación',
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
                // no puede estar en blanco ni ya definido
                String grupoNuevo;
                if (_tipoControle.value.text.isNotEmpty) {
                  grupoNuevo = _tipoControle.value.text[0].toUpperCase() +
                      _tipoControle.value.text.substring(1);

                  if (!apiProvider.apigrupos.contains(grupoNuevo)) {
                    // agregar a BD

                    apiProvider.cambiarGrupoApi(grupo, grupoNuevo);
                    if (apiProvider.listaMenu.contains('MPD' + grupo)) {
                      Provider.of<AplicacionesProvider>(context, listen: false)
                          .agregarMenu('MPD' + grupoNuevo);
                      Provider.of<AplicacionesProvider>(context, listen: false)
                          .eliminarTipoMP('MPD' + grupo);

                      DbTiposAplicaciones.db
                          .modificarNombre(grupo, grupoNuevo, 'MPD');
                    }
                    DbTiposAplicaciones.db.modificarGrupo(grupo, grupoNuevo);
                  }

                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
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

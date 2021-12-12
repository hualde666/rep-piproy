import 'package:flutter/material.dart';

import 'package:piproy/scr/models/api_tipos.dart';

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
      appBar:
          headerApp(context, 'Grupos app', Text(''), 0.0, true, 'ApiGrupos'),
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
    return
        //  GestureDetector(
        //   onTap: () {
        //     Provider.of<AplicacionesProvider>(context, listen: false)
        //         .tipoSeleccion = grupo;
        //     Navigator.pushNamed(context, 'grupo');
        //   },
        //   onLongPress: () => eliminarTipo(context, grupo),
        //   onDoubleTap: () => agregaMPC(context, grupo),
        Container(
            margin: EdgeInsets.symmetric(vertical: 3, horizontal: 4.0),
            height: 60,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.white)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    if (grupo != 'Todas') {
                      agregaMPC(context, grupo);
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
                    Navigator.pushNamed(context, 'grupo');
                  },
                  child: Container(
                    width: 280,
                    color: Theme.of(context).primaryColor,
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
            ));
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
    return AlertDialog(
      content: Form(
        child: Container(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Crear grupo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                  )),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                style: TextStyle(
                  fontSize: 25,
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
              if (_tipoControle.value.text != "" &&
                  !apiProvider.apigrupos.contains(_tipoControle.value.text)) {
                // agregar a BD
                String grupo = _tipoControle.value.text[0].toUpperCase();
                if (_tipoControle.value.text.length > 1) {
                  grupo = _tipoControle.value.text[0].toUpperCase() +
                      _tipoControle.value.text.substring(1);
                }
                apiProvider.agregarApiGrupo(grupo);
                final nuevo = new ApiTipos(grupo: grupo, nombre: "", tipo: "1");
                DbTiposAplicaciones.db.nuevoTipo(nuevo);
              }

              Navigator.of(context).pop();
            },
            child: Text(
              'Si',
            )),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'No',
            )),
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
            onPressed: () {
              // Eliminar de categoria

              Provider.of<AplicacionesProvider>(context, listen: false)
                  .eliminarTipos(grupo);
              // eliminar  a BD
              DbTiposAplicaciones.db.eliminarGrupo(grupo);

              ///
              ///         ELIMNAR DEL MENU PRINCIPAL

              if (apiProvider.listaMenu.contains('MPC' + grupo)) {
                Provider.of<AplicacionesProvider>(context, listen: false)
                    .eliminarTipoMP('MPC' + grupo);
                DbTiposAplicaciones.db.eliminarGrupoMP(grupo);
              }

              Navigator.of(context).pop();
            },
            child: Text(
              'Si',
            )),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'No',
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
            onPressed: () {
              final nuevo = new ApiTipos(grupo: 'MPC', nombre: grupo);
              if (!apiProvider.listaMenu.contains('MPC' + grupo)) {
                /// actualizar lista MENU
                ///
                Provider.of<AplicacionesProvider>(context, listen: false)
                    .agregarMenu('MPC' + grupo);

                DbTiposAplicaciones.db.nuevoTipo(nuevo);
              }

              Navigator.of(context).pop();
            },
            child: Text(
              'Si',
            )),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('NO')),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';
import 'package:piproy/scr/models/api_tipos.dart';

import 'package:piproy/scr/providers/db_provider.dart';
import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';

import 'package:piproy/scr/providers/aplicaciones_provider.dart';

class ApiGruposPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    return SafeArea(
        child: Scaffold(
            appBar: headerApp(context, 'Categorias Api', Text(''), 0.0),
            resizeToAvoidBottomInset: false,
            backgroundColor: Theme.of(context).primaryColor,
            body: FutureBuilder(
                future: apiProvider.cargarCategorias(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final List<String> listaGrupos = apiProvider.apitipos;

                    // listaGrupos.add(' ');
                    return ListView.builder(
                        padding: EdgeInsets.only(bottom: 65),
                        itemCount: listaGrupos.length,
                        itemBuilder: (context, i) {
                          return grupo(context, listaGrupos[i]);
                        });
                  }
                }),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BotonFlotante(pagina: 'grupoApi'),
                FloatingActionButton.extended(
                    heroTag: "agregar",
                    icon: Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.white,
                    ),
                    label: Text(
                      'agregar',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    backgroundColor: Color.fromRGBO(249, 75, 11, 1),
                    onPressed: () {
                      // SELECCION DE API POR TIPO
                      //_seleccionApi(context, tipo);
                      crearTipo(context);
                    }),
              ],
            )));
  }

  Widget grupo(
    BuildContext context,
    String grupo,
  ) {
    return GestureDetector(
      onTap: () {
        Provider.of<AplicacionesProvider>(context, listen: false)
            .tipoSeleccion = grupo;
        Navigator.pushNamed(context, 'grupo');
      },
      onLongPress: () => eliminarTipo(context, grupo),
      onDoubleTap: () => agregaMPC(context, grupo),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 4.0),
        height: 60,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.white)),
        child: Center(
          child: Text(
            grupo,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
    );
  }

  ///
  ///************** CREA  CATEGORIA ************/
  ///

  Future crearTipo(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return crearTipoForm(context);
        });
  }

  AlertDialog crearTipoForm(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    final TextEditingController _tipoControle = TextEditingController();
    return AlertDialog(
      content: Form(
        child: Container(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Crear categoria'),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                controller: _tipoControle,
                validator: (valor) {
                  // validar que no exite ya

                  return valor.isNotEmpty ? null : "dato invalido";
                },
                decoration: InputDecoration(hintText: "nombre de categoria"),
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Si', style: TextStyle(fontSize: 20.0)),
          onPressed: () {
            // no puede estar en blanco ni ya definido
            if (_tipoControle.value.text != "" &&
                !apiProvider.apitipos.contains(_tipoControle.value.text)) {
              // agregar a BD
              String categoria = _tipoControle.value.text[0].toUpperCase();
              if (_tipoControle.value.text.length > 1) {
                categoria = _tipoControle.value.text[0].toUpperCase() +
                    _tipoControle.value.text.substring(1);
              }
              apiProvider.agregarApiTipos(categoria);
              final nuevo = new ApiTipos(tipo: categoria, nombreApi: "");
              DbTiposAplicaciones.db.nuevoTipo(nuevo);
            }

            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('No', style: TextStyle(fontSize: 20.0)),
          onPressed: () {
            Navigator.of(context).pop();
          },
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

  AlertDialog eliminarTipoForm(BuildContext context, String tipo) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    return AlertDialog(
      //title: Text('¿Desea ELIMINAR la categoria $tipo ?'),
      content: Text('¿Desea ELIMINAR la categoria $tipo ?'),
      actions: [
        TextButton(
          child: Text('Si', style: TextStyle(fontSize: 20)),
          onPressed: () {
            // Eliminar de categoria

            Provider.of<AplicacionesProvider>(context, listen: false)
                .eliminarTipos(tipo);
            // eliminar  a BD
            DbTiposAplicaciones.db.eliminarTipo(tipo);

            ///
            ///         ELIMNAR DEL MENU PRINCIPAL

            if (apiProvider.listaMenu.contains('MPC' + tipo)) {
              Provider.of<AplicacionesProvider>(context, listen: false)
                  .eliminarTipoMPC('MPC' + tipo);
              DbTiposAplicaciones.db.eliminarTipoMPC(tipo);
            }

            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            'No',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
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
          Text('¿Desea crear  acceso directo de $grupo  en menu principal?'),
      actions: [
        TextButton(
          child: Text('Si', style: TextStyle(fontSize: 20)),
          onPressed: () {
            final nuevo = new ApiTipos(tipo: 'MPC', nombreApi: grupo);
            if (!apiProvider.listaMenu.contains('MPC' + grupo)) {
              /// actualizar lista MENU
              ///
              Provider.of<AplicacionesProvider>(context, listen: false)
                  .agregarMenu('MPC' + grupo);

              DbTiposAplicaciones.db.nuevoTipo(nuevo);
            }

            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('No', style: TextStyle(fontSize: 20)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

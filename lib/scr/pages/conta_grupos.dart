import 'package:flutter/material.dart';
import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';
import 'package:piproy/scr/models/api_tipos.dart';
import 'package:piproy/scr/pages/contact_seleccion.dart';
import 'package:piproy/scr/pages/contacts_por_grupo.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';

import 'package:piproy/scr/providers/db_provider.dart';
import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';

import 'package:piproy/scr/providers/aplicaciones_provider.dart';

class ContactsGruposPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);

    return SafeArea(
        child: Scaffold(
            appBar: headerApp(context, 'Grupos Contactos', Text(''), 0.0),
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
                    final List<String> listaGrupos = apiProvider.contactgrupos;

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
                BotonFlotante(pagina: 'grupoCont'),
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
                      //Definir nuevo grupo
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ContactsPorGrupoPage()),
        );
      },
      onLongPress: () => eliminarTipo(context, grupo),
      onDoubleTap: () => agregaMPG(context, grupo),
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
              Text('Crear grupo de Contacto'),
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
                decoration: InputDecoration(hintText: "nombre del grupo"),
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
                !apiProvider.contactgrupos.contains(_tipoControle.value.text)) {
              // agregar a BD
              String grupo = _tipoControle.value.text[0].toUpperCase();
              if (_tipoControle.value.text.length > 1) {
                grupo = _tipoControle.value.text[0].toUpperCase() +
                    _tipoControle.value.text.substring(1);
              }
              apiProvider.agregarContactGrupo(grupo);
              final nuevo = new ApiTipos(grupo: grupo, nombre: "", tipo: "2");
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
  Future eliminarTipo(BuildContext context, String grupo) async {
    if (grupo == 'Todos') {
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
      //title: Text('¿Desea ELIMINAR la categoria $tipo ?'),
      content: Text('¿Desea ELIMINAR grupo de contacto $grupo ?'),
      actions: [
        TextButton(
          child: Text('Si', style: TextStyle(fontSize: 20)),
          onPressed: () {
            // Eliminar de categoria

            Provider.of<AplicacionesProvider>(context, listen: false)
                .eliminarContactTipos(grupo);
            // eliminar  en la  BD
            DbTiposAplicaciones.db.eliminarGrupo(grupo);

            ///
            ///         ELIMNAR DEL MENU PRINCIPAL

            if (apiProvider.listaMenu.contains('MPG' + grupo)) {
              Provider.of<AplicacionesProvider>(context, listen: false)
                  .eliminarTipoMP('MPG' + grupo);
              DbTiposAplicaciones.db.eliminarGrupoMP(grupo);
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

  Future agregaMPG(BuildContext context, String grupo) async {
    // grupo es el nombre de categoria a agregar al menu principal
    return await showDialog(
        context: context,
        builder: (context) {
          return agregaMpgForm(context, grupo);
        });
  }

  AlertDialog agregaMpgForm(BuildContext context, String grupo) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    return AlertDialog(
      content:
          Text('¿Desea crear  acceso directo de $grupo  en menu principal?'),
      actions: [
        TextButton(
          child: Text('Si', style: TextStyle(fontSize: 20)),
          onPressed: () {
            final nuevo = new ApiTipos(grupo: 'MPG', nombre: grupo, tipo: "3");
            if (!apiProvider.listaMenu.contains('MPG' + grupo)) {
              /// actualizar lista MENU
              ///
              Provider.of<AplicacionesProvider>(context, listen: false)
                  .agregarMenu('MPG' + grupo);

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
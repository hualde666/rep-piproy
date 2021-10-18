import 'package:flutter/material.dart';

import 'package:device_apps/device_apps.dart';
import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';
import 'package:piproy/scr/models/api_tipos.dart';
import 'package:piproy/scr/pages/api_seleccion.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/db_provider.dart';
import 'package:piproy/scr/widgets/tres_botones_header.dart';
import 'package:provider/provider.dart';

class ApiLista3Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);

    return SafeArea(
        child: Scaffold(
      appBar: headerApi(context),
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
              final List<Application> lista = snapshot.data;
              return Container(
                  height: 600,
                  child: Column(
                    children: [
                      SelecionTipo(),
                      Container(
                          height: 500, child: ListaApiSelec(lista: lista)),
                    ],
                  ));
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: apiProvider.tipoSeleccion != 'todas'
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BotonFlotante(pagina: 'tipoApi'),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ApiSeleecionPage(
                                tipo: apiProvider.tipoSeleccion,
                                lista: apiProvider.categoryApi['todas'])));
                  },
                ),
              ],
            )
          : Container(),
    ));
  }
}

Widget headerApi(BuildContext context) {
  return PreferredSize(
      preferredSize: Size.fromHeight(120.0),
      // here the desired height
      child: AppBar(
        backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          margin: EdgeInsets.only(
            top: 10,
          ),
          // height: 240.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              tresBotonesHeader(context),
              Divider(
                height: 5,
              ),
              //   SelecionTipo()
            ],
          ),
        ),
      ));
}

class ListaApiSelec extends StatelessWidget {
  ListaApiSelec({@required this.lista});
  final List<Application> lista;
  @override
  Widget build(BuildContext context) {
    List<Widget> listaApi =
        List.generate(lista.length, (i) => ElementoApi(api: lista[i]));
    return GridView.count(
      children: listaApi,
      crossAxisCount: 2,
      // mainAxisSpacing: 2.0,
    );
  }
}

class SelecionTipo extends StatelessWidget {
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);

    final categoria = apiProvider.apitipos;
    return Container(
      height: 60,
      // color:,
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoria.length,
          itemBuilder: (BuildContext context, int i) {
            return BotonTipoApi(categoria: categoria[i]);
          }),
    );
  }
}

class BotonTipoApi extends StatelessWidget {
  const BotonTipoApi({
    @required this.categoria,
  });

  final String categoria;
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
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Ok'),
          onPressed: () {
            // no puede estar en blanco ni ya definido
            if (_tipoControle.value.text != "" &&
                !apiProvider.apitipos.contains(_tipoControle.value.text)) {
              apiProvider.agregarApiTipos(_tipoControle.value.text);
              // agregar a BD
//
//
              final nuevo =
                  new ApiTipos(tipo: _tipoControle.value.text, nombreApi: "");
              DbTiposAplicaciones.db.nuevoTipo(nuevo);
            }

            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  Future eliminarTipo(BuildContext context, String tipo) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return eliminarTipoForm(context, tipo);
        });
  }

  AlertDialog eliminarTipoForm(BuildContext context, String tipo) {
    return AlertDialog(
      title: Text('¿Desea elminar la categoria $tipo ?'),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Ok'),
          onPressed: () {
            // Eliminar de categoria

            Provider.of<AplicacionesProvider>(context, listen: false)
                .eliminarTipos(tipo);
            // eliminar  a BD
//
//
            DbTiposAplicaciones.db.eliminarTipo(tipo);

            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    return GestureDetector(
      onLongPress: () {
        /// borrar categoria y sus api
        if (categoria != '+' && categoria != 'todas') {
          eliminarTipo(context, categoria);
          if (categoria == apiProvider.tipoSeleccion) {
            Navigator.pop(context);
          }
        }
      },
      onTap: () {
        if (categoria != '+') {
          final apiProvider =
              Provider.of<AplicacionesProvider>(context, listen: false);
          apiProvider.tipoSeleccion = categoria;
        } else {
          // crear categoria
          // ver como voy a esa categoria un avez creada
          crearTipo(context);
        }
      },
      child: categoria != '+'
          ? Container(
              child: Padding(
                  padding: EdgeInsets.all(3),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            color: apiProvider.tipoSeleccion == categoria
                                ? Color.fromRGBO(249, 75, 11, 1)
                                : null,
                            borderRadius: BorderRadius.circular(25),
                            border:
                                Border.all(color: Colors.white, width: 1.0)),
                        child: Center(
                          child: Text(
                            categoria,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )),
            )
          : Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.white, width: 1.0)),
              child: Center(
                  child: Text(
                '+',
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
            ),
    );
  }
}

class ElementoApi extends StatelessWidget {
  const ElementoApi({@required this.api});
  final Application api;
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    final tipo = apiProvider.tipoSeleccion;
    return GestureDetector(
      onTap: () {
        if (api.appName != "") {
          api.openApp();
        }
      },
      onLongPress: () {
        // eliminar api?
        if (tipo != 'todas') {
          eliminarApi(context, tipo);
        }
      },
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Image.memory(
              (api as ApplicationWithIcon).icon,
              width: 100,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              api.appName,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> eliminarApi(BuildContext context, String tipo) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(' ${api.appName}',
              style: TextStyle(
                fontSize: 20,
              )),
          content: Text('¿Desea eliminar este aplicación de categoría $tipo ?'),
          // shape: CircleBorder(),
          elevation: 14.0,
          actionsPadding: EdgeInsets.symmetric(horizontal: 30.0),
          actions: [
            TextButton(
                onPressed: () {
                  /// elina api de pantalla
                  Provider.of<AplicacionesProvider>(context, listen: false)
                      .eliminar(api);
                  DbTiposAplicaciones.db
                      .deleteApi(tipo, api.appName); //elimina api de BD

                  Navigator.pop(context);
                },
                child: Text('Si', style: TextStyle(fontSize: 20.0))),
            TextButton(
                autofocus: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('No', style: TextStyle(fontSize: 20.0)))
          ],
        ),
      );
}

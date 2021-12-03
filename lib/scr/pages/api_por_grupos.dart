import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';
import 'package:piproy/scr/models/api_tipos.dart';
import 'package:piproy/scr/pages/api_seleccion.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/db_provider.dart';
import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';

class ApiPorGrupoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    final grupo = apiProvider.tipoSeleccion;
    final lista = apiProvider.categoryApi[grupo];
    List<Widget> listaApi =
        List.generate(lista.length, (i) => ElementoApi(api: lista[i]));
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      //****** editar nombre del grupo */
      appBar: headerApp(context, '$grupo', Text(''), 0.0),
      body: GridView.count(
        padding: EdgeInsets.only(bottom: 70, left: 1, right: 1),
        children: listaApi,
        crossAxisCount: 2,
      ),
      floatingActionButton: grupo != 'Todas'
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
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  backgroundColor: Color.fromRGBO(249, 75, 11, 1),
                  onPressed: () {
                    // SELECCION DE API POR TIPO
                    //_seleccionApi(context, tipo);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ApiSeleccionPage(
                                context: context,
                                listaVieja: apiProvider
                                    .categoryApi[apiProvider.tipoSeleccion])));
                  },
                ),
              ],
            )
          : null,
    ));
  }
}

class ElementoApi extends StatelessWidget {
  const ElementoApi({@required this.api});
  final Application api;
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    final grupo = apiProvider.tipoSeleccion;
    return GestureDetector(
      onTap: () {
        if (api.appName != "") {
          api.openApp();
        }
      },
      onLongPress: () {
        // eliminar api?
        if (grupo != 'Todas') {
          eliminarApi(context, grupo);
        }
      },
      onDoubleTap: () => agregaMPA(context, api),
      child: Container(
        // height: 200,
        margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Colors.white, width: 1.0)),
        // color: Theme.of(context).primaryColor,
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
              width: 30,
            ),
            // Container(
            //   height: 60,
            //   width: 150,
            //   child: Text(
            //     api.appName,
            //     textAlign: TextAlign.center,
            //     style: TextStyle(fontSize: 25, color: Colors.white),
            //   ),
            // ),
            Container(
              height: 60,
              width: 150,
              child: Text(
                api.packageName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
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
                fontSize: 30,
              )),
          content: Text('¿Desea eliminar esta aplicación del grupo $tipo ?',
              style: TextStyle(
                fontSize: 25,
              )),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            ElevatedButton(
                onPressed: () {
                  //  / elina api de pantalla
                  Provider.of<AplicacionesProvider>(context, listen: false)
                      .eliminar(api);
                  DbTiposAplicaciones.db
                      .deleteApi(tipo, api.appName); //elimina api de BD

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
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
                    primary: Color.fromRGBO(249, 75, 11, 1)),
                child: const Text('NO',
                    style: TextStyle(fontSize: 25, color: Colors.white))),
          ],
        ),
      );
  Future agregaMPA(BuildContext context, Application api) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return agregaMpaForm(context, api);
        });
  }

  AlertDialog agregaMpaForm(BuildContext context, Application api) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    return AlertDialog(
      // title: Text('¿Desea crear acceso directo a ${api.appName}?'),
      content: Text('¿Desea crear acceso directo a ${api.appName}?'),
      actions: [
        TextButton(
          child: Text('Si', style: TextStyle(fontSize: 20.0)),
          onPressed: () {
            final nuevo = new ApiTipos(grupo: 'MPA', nombre: api.appName);
            if (!apiProvider.listaMenu.contains(api.appName)) {
              /// actualizar lista MENU
              ///
              Provider.of<AplicacionesProvider>(context, listen: false)
                  .agregarMenu('MPA' + api.appName);

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
}

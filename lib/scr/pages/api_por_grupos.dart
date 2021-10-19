import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';
import 'package:piproy/scr/pages/api_seleccion.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/db_provider.dart';
import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';

class ApiPorGrupoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    final tipo = apiProvider.tipoSeleccion;
    final lista = apiProvider.categoryApi[tipo];
    List<Widget> listaApi =
        List.generate(lista.length, (i) => ElementoApi(api: lista[i]));
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: headerApp(context, '$tipo', Text(''), 0.0),
      body: GridView.count(
        children: listaApi,
        crossAxisCount: 2,
      ),
      floatingActionButton: tipo != 'todas'
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

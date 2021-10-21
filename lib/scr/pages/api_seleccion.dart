import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';

import 'package:piproy/scr/models/api_tipos.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/db_provider.dart';
import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';

class ApiSeleccionPage extends StatelessWidget {
  final BuildContext context;
  ApiSeleccionPage({this.context, this.listaVieja});
  final List<Application> listaVieja;

  final List<Application> listaNueva = [];

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    final tipo = apiProvider.tipoSeleccion;
    final listaTodas = apiProvider.categoryApi['todas'];
    listaNueva.addAll(listaVieja);
    List<Widget> listaApi = List.generate(
        listaTodas.length,
        (i) => WidgetApi(
            listaNueva: listaNueva, context: context, api: listaTodas[i]));
    return SafeArea(
      child: Scaffold(
          appBar: headerApp(
              context,
              'Seleccion Apps para: ',
              Text(
                '$tipo',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              35.0),
          resizeToAvoidBottomInset: false,
          body: ListView(
            children: listaApi,
          ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BotonFlotante(pagina: 'selecApi'),
              FloatingActionButton.extended(
                heroTag: "guardar",
                icon: Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.white,
                ),
                label: Text(
                  'guardar',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                backgroundColor: Color.fromRGBO(249, 75, 11, 1),
                onPressed: () {
                  for (var i = 0; i < listaVieja.length; i++) {
                    if (!listaNueva.contains(listaVieja[i])) {
                      // eliminar
                      Provider.of<AplicacionesProvider>(context, listen: false)
                          .modiApiListaPorTipo(listaVieja[i]);
                      DbTiposAplicaciones.db
                          .deleteApi(tipo, listaVieja[i].appName);
                    }
                  }
                  for (var i = 0; i < listaNueva.length; i++) {
                    if (!listaVieja.contains(listaNueva[i])) {
                      // agregar
                      Provider.of<AplicacionesProvider>(context, listen: false)
                          .modiApiListaPorTipo(listaNueva[i]);
                      final nuevo = new ApiTipos(
                          tipo: tipo, nombreApi: listaNueva[i].appName);
                      DbTiposAplicaciones.db.nuevoTipo(nuevo);
                    }
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          )),
    );
  }

  cambiarListas() {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    final tipo = apiProvider.tipoSeleccion;
    //final listaVieja = apiProvider.categoryApi[tipo];
    for (var i = 0; i < listaVieja.length; i++) {
      if (!listaNueva.contains(listaVieja[i])) {
        // eliminar
        Provider.of<AplicacionesProvider>(context, listen: true)
            .modiApiListaPorTipo(listaVieja[i]);
        DbTiposAplicaciones.db.deleteApi(tipo, listaVieja[i].appName);
      }
    }
    for (var i = 0; i < listaNueva.length; i++) {
      if (!listaVieja.contains(listaNueva[i])) {
        // agregar
        Provider.of<AplicacionesProvider>(context, listen: true)
            .modiApiListaPorTipo(listaNueva[i]);
        final nuevo =
            new ApiTipos(tipo: tipo, nombreApi: listaNueva[i].appName);
        DbTiposAplicaciones.db.nuevoTipo(nuevo);
      }
    }
  }
}

class WidgetApi extends StatefulWidget {
  const WidgetApi({
    Key key,
    @required this.listaNueva,
    @required this.context,
    @required this.api,
  }) : super(key: key);

  final List<Application> listaNueva;
  final BuildContext context;
  final Application api;

  @override
  State<WidgetApi> createState() => _WidgetApiState();
}

class _WidgetApiState extends State<WidgetApi> {
  @override
  Widget build(BuildContext context) {
    final selecionada = widget.listaNueva.contains(widget.api);
    Color color = selecionada
        ? Theme.of(context).primaryColor
        : Color.fromRGBO(55, 57, 84, 0.6);
    return GestureDetector(
      onTap: () {
        if (widget.api.appName != "") {
          /// agregar o eliminar api
          ///
          // Provider.of<AplicacionesProvider>(context, listen: false)
          //    .modiApiListaPorTipo(api);

          if (widget.listaNueva.contains(widget.api)) {
            // agrego bd
            widget.listaNueva.remove(widget.api);
          } else {
            widget.listaNueva.add(widget.api);
          }
          setState(() {});
        }
      },
      child: Container(
        color: color,
        child: Column(
          children: [
            SizedBox(
              width: 10,
            ),
            Image.memory(
              (widget.api as ApplicationWithIcon).icon,
              width: 100,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              widget.api.appName,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Divider(
              height: 2,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

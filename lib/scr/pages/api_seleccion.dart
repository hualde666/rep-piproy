import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

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
    final grupo = apiProvider.tipoSeleccion;
    final listaTodas = apiProvider.categoryApi['Todas'];
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
              '$grupo',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            40.0,
            true,
            'ApiSeleccion'),
        resizeToAvoidBottomInset: false,
        body: Container(
          // padding: EdgeInsets.only(bottom: 70),
          padding: EdgeInsets.only(bottom: 60, left: 1, right: 1),
          child: GridView.count(
            crossAxisCount: 2,
            children: listaApi,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:
            //BotonFlotante(pagina: 'selecApi'),
            FloatingActionButton.extended(
          heroTag: "guardar",
          icon: Icon(
            Icons.save,
          ),
          label: Text(
            'guardar',
          ),
          onPressed: () {
            for (var i = 0; i < listaVieja.length; i++) {
              if (!listaNueva.contains(listaVieja[i])) {
                // eliminar
                Provider.of<AplicacionesProvider>(context, listen: false)
                    .modiApiListaPorTipo(listaVieja[i]);
                DbTiposAplicaciones.db.deleteApi(grupo, listaVieja[i].appName);
              }
            }
            for (var i = 0; i < listaNueva.length; i++) {
              if (!listaVieja.contains(listaNueva[i])) {
                // agregar
                Provider.of<AplicacionesProvider>(context, listen: false)
                    .modiApiListaPorTipo(listaNueva[i]);
                final nuevo = new ApiTipos(
                    grupo: grupo, nombre: listaNueva[i].appName, tipo: "1");
                DbTiposAplicaciones.db.nuevoTipo(nuevo);
              }
            }
            Navigator.pop(context);
          },
        ),
      ),
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
        final nuevo = new ApiTipos(grupo: tipo, nombre: listaNueva[i].appName);
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
        // width: 120,
        // height: 50,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.white)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.memory(
              (widget.api as ApplicationWithIcon).icon,
              width: 100,
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 50,
              width: 150,
              child: Text(
                widget.api.appName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

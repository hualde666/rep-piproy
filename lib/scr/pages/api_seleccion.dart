import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';
import 'package:piproy/scr/models/api_tipos.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/db_provider.dart';
import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';

class ApiSeleecionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    final lista = apiProvider.categoryApi['todas'];
    final tipo = apiProvider.tipoSeleccion;

    List<Widget> listaApi = List.generate(
        lista.length,
        (i) => ElementoApi2(
              api: lista[i],
              tipo: tipo,
            ));
    return SafeArea(
      child: Scaffold(
        appBar:
            headerApp(context, 'Selección de Apps para $tipo', Text(''), 0.0),
        body: ListView.builder(
            itemCount: lista.length,
            itemBuilder: (BuildContext context, int i) {
              return listaApi[i];
            }),
        floatingActionButton: BotonFlotante(pagina: 'selecApi'),
      ),
    );
  }
}

class ElementoApi2 extends StatefulWidget {
  const ElementoApi2({
    @required this.api,
    @required this.tipo,
  });

  final Application api;
  final String tipo;

  @override
  State<ElementoApi2> createState() => _ElementoApi2State();
}

class _ElementoApi2State extends State<ElementoApi2> {
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    final String tipo = apiProvider.tipoSeleccion;
    final selecionada = apiProvider.categoryApi[tipo].contains(widget.api);
    final color = selecionada
        ? Theme.of(context).primaryColor
        : Color.fromRGBO(55, 57, 84, 0.6);
    return GestureDetector(
      onTap: () {
        if (widget.api.appName != "") {
          /// agregar o eliminar api
          Provider.of<AplicacionesProvider>(context, listen: false)
              .modiApiListaPorTipo(widget.api);

          if (apiProvider.categoryApi[tipo].contains(widget.api)) {
            // agrego bd
            final nuevo =
                new ApiTipos(tipo: tipo, nombreApi: widget.api.appName);
            DbTiposAplicaciones.db.nuevoTipo(nuevo);
          } else {
            // elimino bd

            // DbTiposAplicaciones.db.deleteApi(tipo: tipo, nombreApi:widget.api.appName);
          }
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

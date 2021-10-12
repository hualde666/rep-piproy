import 'package:flutter/material.dart';

import 'package:device_apps/device_apps.dart';
import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';
import 'package:piproy/scr/models/api_tipos.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/db_provider.dart';
import 'package:piproy/scr/widgets/tres_botones_header.dart';
import 'package:provider/provider.dart';

class ApiLista3Page extends StatefulWidget {
  @override
  State<ApiLista3Page> createState() => _ApiLista3PageState();
}

class _ApiLista3PageState extends State<ApiLista3Page> {
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    final categoria = apiProvider.apitipos;
    final tipo = apiProvider.tipoSeleccion;
    final lista = apiProvider.categoryApi[tipo];
    return SafeArea(
        child: Scaffold(
      appBar: headerApi(context, categoria),
      backgroundColor: Theme.of(context).primaryColor,
      body: ListaApiSelec(lista: lista),
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
                    _seleccionApi(context, tipo);
                  },
                ),
              ],
            )
          : Container(),
    ));
  }

  void _seleccionApi(BuildContext context, String tipo) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return listaTodasApi(context);
        });
  }

  AlertDialog listaTodasApi(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    final lista = apiProvider.categoryApi['todas'];
    final tipo = apiProvider.tipoSeleccion;
    List<Widget> listaApi = List.generate(
        lista.length, (i) => ElementoApi2(api: lista[i], tipo: tipo));
    return AlertDialog(
      backgroundColor: Colors.white60,
      content: Container(
        height: 400,
        child: ListView.builder(
            itemCount: lista.length,
            itemBuilder: (BuildContext context, int i) {
              return listaApi[i];
            }),
      ),
      actions: [
        TextButton(
          child: Text(
            'Ok',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}

Widget headerApi(BuildContext context, List<String> categoria) {
  return PreferredSize(
      preferredSize: Size.fromHeight(180.0), // here the desired height
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
              SelecionTipo(
                categoria: categoria,
              )
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

class SelecionTipo extends StatefulWidget {
  const SelecionTipo({
    Key key,
    @required this.categoria,
  }) : super(key: key);

  final List<String> categoria;

  @override
  State<SelecionTipo> createState() => _SelecionTipoState();
}

class _SelecionTipoState extends State<SelecionTipo> {
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);

    return Container(
      height: 65,
      margin: EdgeInsets.only(left: 3),
      width: double.infinity,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          //controller: _controller,
          scrollDirection: Axis.horizontal,
          itemCount: widget.categoria.length,
          itemBuilder: (BuildContext context, int i) {
            return BotonTipoApi(categoria: widget.categoria[i]);
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

              // guarda datos
            }

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
      onTap: () {
        if (categoria != '+') {
          final apiProvider =
              Provider.of<AplicacionesProvider>(context, listen: false);
          apiProvider.tipoSeleccion = categoria;
        } else {
          // crear categoria
          crearTipo(context);
        }
      },
      child: Container(
        child: Padding(
            padding: EdgeInsets.all(3),
            child: Column(
              children: [
                Container(
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                        color: apiProvider.tipoSeleccion == categoria
                            ? Color.fromRGBO(249, 75, 11, 1)
                            : null,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.white, width: 1.0)),
                    child: Center(
                      child: Text(
                        categoria,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )),
              ],
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
    return GestureDetector(
      onTap: () {
        if (api.appName != "") {
          api.openApp();
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
}

class ElementoApi2 extends StatelessWidget {
  const ElementoApi2({@required this.api, @required this.tipo});
  final Application api;
  final String tipo;
  @override
  Widget build(BuildContext context) {
    DbTiposAplicaciones.db.database;
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    final selecionada = apiProvider.categoryApi[tipo].contains(api);
    final color = selecionada
        ? Theme.of(context).primaryColor
        : Color.fromRGBO(55, 57, 84, 0.6);
    return GestureDetector(
      onTap: () {
        if (api.appName != "") {
          final apiProvider =
              Provider.of<AplicacionesProvider>(context, listen: false);
          apiProvider.modiApiListaPorTipo(tipo, api);
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

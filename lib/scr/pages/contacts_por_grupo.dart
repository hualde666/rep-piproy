import 'package:flutter/material.dart';
import 'package:piproy/scr/models/contactos_modelo.dart';

import 'package:piproy/scr/pages/contact_seleccion.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';

import 'package:piproy/scr/widgets/contactos_card.dart';

import 'package:piproy/scr/widgets/tres_botones_header.dart';

import 'package:provider/provider.dart';

class ContactsPorGrupoPage extends StatefulWidget {
  @override
  State<ContactsPorGrupoPage> createState() => _ContactsPorGrupoPageState();
}

class _ContactsPorGrupoPageState extends State<ContactsPorGrupoPage> {
  List<ContactoDatos> listaGrupo = [];
  bool hayBusqueda = false;

  TextEditingController _searchController = TextEditingController();

  List<ContactoDatos> listaContactosFiltro;
  @override
  void initState() {
    super.initState();

    _searchController.addListener(filtrarContactos);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  filtrarContactos() {
    List<ContactoDatos> _contactos = [];
    _contactos.addAll(listaGrupo);
    if (_searchController.text.isNotEmpty) {
      _contactos.retainWhere((contacto) {
        String busquedaMinuscula = _searchController.text.toLowerCase();
        String nombreMinuscula = contacto.nombre.toLowerCase();
        return nombreMinuscula.contains(busquedaMinuscula);
      });
      setState(() {
        listaContactosFiltro = _contactos;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);

    final grupo = apiProvider.tipoSeleccion;

    Future<List<Widget>> obtenerListaGrupo(String grupo) async {
      if (_searchController.text.isNotEmpty) {
        return List.generate(
            listaContactosFiltro.length,
            (i) => TarjetaContacto2(
                context, listaContactosFiltro[i], true, false));
      } else {
        List<ContactoDatos> lista =
            await apiProvider.obtenerListaContactosGrupo(context, grupo);
        listaGrupo = [];
        if (lista.isNotEmpty) {
          listaGrupo.addAll(lista);

          return List.generate(
              lista.length,
              (i) => (grupo != 'Todos')
                  ? TarjetaContacto2(context, lista[i], true, true)
                  : TarjetaContacto2(context, lista[i], true, false));
        }
      }
      return [];
    }

    return SafeArea(
        child: Scaffold(
      appBar: busqueda(context),
      body: FutureBuilder(
          future: obtenerListaGrupo(grupo),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                // snapshot contiene lista de displayname de los contactos por grupo

                return Container(
                  padding: EdgeInsets.only(bottom: 50),
                  child: ListView(
                    padding: EdgeInsets.only(bottom: 200),
                    children: snapshot.data,
                  ),
                );
              } else {
                return Container();
              }
            }
          }),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: grupo != 'Todos'
          ?
          // BotonFlotante(pagina: 'grupoContact'),
          FloatingActionButton.extended(
              heroTag: "agregar",
              icon: Icon(
                Icons.add,
              ),
              label: Text(
                'agregar',
              ),
              onPressed: () {
                // SELECCION DE contactos POR TIPO
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectContactsPage()));
              },
            )
          : null,
    ));
  }

  Widget busqueda(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);

    final grupo = apiProvider.tipoSeleccion;
    final alto = grupo == 'Todos' ? 255.0 : 190.0;

    return PreferredSize(
        preferredSize: Size.fromHeight(200.0 + alto),

        // here the desired height
        child: Container(
          height: alto,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: 5,
              // ),
              tresBotonesHeader(context, true, 'ContactosporGrupo'),
              Text(
                'Contactos: ' + grupo,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 30),
              ),
              grupo == 'Todos'
                  ? Container(
                      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Theme.of(context).primaryColor,
                            height: 1.0),
                        keyboardType: TextInputType.text,
                        controller: _searchController,
                        // autofocus: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.amber,
                                  style: BorderStyle.solid),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0))),
                          labelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20),
                          labelText: 'Buscar Contacto :',
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _searchController.clear();
                                    });
                                  },
                                  icon: Icon(
                                    Icons.clear,
                                    size: 30,
                                  ))
                              : Icon(
                                  Icons.search,
                                  color: Theme.of(context).primaryColor,
                                  size: 30,
                                ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          // ),
        ));
  }
}

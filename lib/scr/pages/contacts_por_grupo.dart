import 'package:contacts_service/contacts_service.dart';

import 'package:flutter/material.dart';

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
  List<Contact> listaGrupo = [];
  bool hayBusqueda = false;

  TextEditingController _searchController = TextEditingController();

  List<Contact> listaContactosFiltro;
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
    List<Contact> _contactos = [];
    _contactos.addAll(listaGrupo);
    if (_searchController.text.isNotEmpty) {
      _contactos.retainWhere((contacto) {
        String busquedaMinuscula = _searchController.text.toLowerCase();
        String nombreMinuscula = contacto.displayName.toLowerCase();
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
            (i) =>
                TarjetaContacto2(context, listaContactosFiltro[i], true, true));
      } else {
        List<Contact> lista =
            await apiProvider.obtenerListaContactosGrupo(grupo);
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
                    padding: EdgeInsets.only(bottom: 68),
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
    final alto = grupo == 'Todos' ? 240.0 : 175.0;
    // return AppBar(
    //   //backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
    //   automaticallyImplyLeading: false,
    //   flexibleSpace:
    return PreferredSize(
        preferredSize: Size.fromHeight(200.0 + alto),

        // here the desired height
        child: Container(
          height: alto,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
              ),
              tresBotonesHeader(context, true, 'ContactosporGrupo'),
              Text(
                grupo,
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              grupo == 'Todos'
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25.0, color: Colors.white54, height: 1.0),
                        keyboardType: TextInputType.text,
                        controller: _searchController,
                        // autofocus: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(

                              //borderSide: BorderSide(color: Colors.amber),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0))),
                          labelStyle:
                              TextStyle(color: Colors.white38, fontSize: 20),
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
                                    color: Colors.white,
                                    size: 30,
                                  ))
                              : Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 30,
                                ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0))),
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

import 'package:contacts_service/contacts_service.dart';

import 'package:flutter/material.dart';

import 'package:piproy/scr/pages/contact_seleccion.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';

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
  bool buscar = false;
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

  generarLista(List<String> listaNombre, List<Contact> listaContactos) {
    listaGrupo = [];
    if (listaNombre.isNotEmpty) {
      for (int i = 0; i < listaNombre.length; i++) {
        final contacto = listaContactos.firstWhere(
            (element) => element.displayName == listaNombre[i],
            orElse: () => null);
        if (contacto != null) {
          listaGrupo.add(contacto);
        }
      }
    }

    return listaGrupo;
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
    bool hayBusqueda = _searchController.text.isNotEmpty;

    final apiProvider = Provider.of<AplicacionesProvider>(context);

    final grupo = apiProvider.tipoSeleccion;

    Future<List<Contact>> obtenerListaGrupo() async {
      if (hayBusqueda) {
        return listaContactosFiltro;
      } else {
        List<Contact> lista =
            await apiProvider.obtenerListaContactosGrupo(grupo);
        listaGrupo.addAll(lista);
        return lista;
      }
    }

    return SafeArea(
        child: Scaffold(
      appBar: busqueda(context),
      body: FutureBuilder(
          future: obtenerListaGrupo(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                // snapshot contiene lista de displayname de los contactos por grupo

                List<Widget> listaContact = List.generate(snapshot.data.length,
                    (i) => TarjetaContacto2(context, snapshot.data[i], true));
                return Container(
                  padding: EdgeInsets.only(bottom: 50),
                  child: ListView(
                    padding: EdgeInsets.only(bottom: 68),
                    children: listaContact,
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
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                Theme.of(context).primaryColor,

                Colors.white,
                Theme.of(context).scaffoldBackgroundColor,
                // Colors.white,
                // Colors.orange,
                // Color.fromRGBO(55, 57, 84, 1.0)
              ],
                  stops: [
                0.2,
                0.4,
                0.7
              ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter)),
          // margin: EdgeInsets.only(top: 10, left: 5.0, right: 5.0),
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
                  ? TextField(
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
                                    buscar = true;
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
                    )
                  : SizedBox(),
            ],
          ),
          // ),
        ));
  }
}

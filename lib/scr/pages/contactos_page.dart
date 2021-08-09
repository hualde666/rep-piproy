import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

import 'package:piproy/scr/providers/contactos_provider.dart';
import 'package:piproy/scr/widgets/contactos_card.dart';
import 'package:piproy/scr/widgets/icon_conteiner.dart';
import 'package:provider/provider.dart';

class ContactosPage extends StatefulWidget {
  @override
  _ContactosPageState createState() => _ContactosPageState();
}

class _ContactosPageState extends State<ContactosPage> {
  List<Contact> listaContactos = [];
  List<Contact> listaContactosFiltro = [];
  TextEditingController _searchController = TextEditingController();
  bool cargando = true;
  bool hayBusqueda = false;
  int tituloApp = 1;
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
    _contactos.addAll(listaContactos);
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
    final contactProvider = Provider.of<ContactosProvider>(context);
    //contactProvider.obtenerlistaContactos();
    listaContactos = contactProvider.listaContactos;
    bool hayBusqueda = _searchController.text.isNotEmpty;
    final List<Widget> listaTarjetas = List.generate(
        hayBusqueda ? listaContactosFiltro.length : listaContactos.length,
        (i) => tarjetaContacto2(context,
            hayBusqueda ? listaContactosFiltro[i] : listaContactos[i]));

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white60,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(90.0), // here the desired height
              child: (tituloApp == 2) ? busqueda() : titulo(),
            ),
            body: ListView.builder(
                itemCount: listaTarjetas.length,
                itemBuilder: (context, index) {
                  Widget contacto = listaTarjetas[index];
                  return contacto;
                })));

    // CustomScrollView(slivers: <Widget>[
    // encabezadoContactos(),
    //  SliverList(delegate: SliverChildListDelegate(listaTarjetas))
    // ]
  }

  Widget encabezadoContactos() {
    return SliverAppBar(
      elevation: 2.0,
      // backgroundColor: Colors.teal[600],
      //expandedHeight: 100.0,

      floating: true,
      pinned: true,
      title: Text('C O N T A C T O S'),
      flexibleSpace: busqueda(),
    );
  }

  titulo() {
    return AppBar(
        title: Container(
      height: 90,
      width: 400,
      margin: EdgeInsets.only(top: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Contactos'),
          IconButton(
              // padding: EdgeInsets.only(right: 10.0),
              icon: Icon(
                Icons.search,
                size: 30.0,
              ),
              tooltip: 'Busqueda',
              onPressed: () {
                setState(() {
                  tituloApp = 2;
                });
              }),
        ],
      ),
    ));
  }

  Widget busqueda() {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Center(
        child: Container(
          margin: EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
          height: 100.0,
          child: Column(
            children: [
              TextField(
                style: TextStyle(
                    fontSize: 25.0, color: Colors.white54, height: 1.0),
                keyboardType: TextInputType.text,
                controller: _searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      //borderSide: BorderSide(color: Colors.amber),
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  labelStyle: TextStyle(color: Colors.white38, fontSize: 20),
                  labelText: 'Busqueda:',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        tituloApp = 1;
                        _searchController.clear();
                      });
                    },
                    icon: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

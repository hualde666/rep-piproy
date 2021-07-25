import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:piproy/scr/widgets/contactos_card.dart';

import 'package:piproy/scr/widgets/tarjeta_contactos.dart';

class ContactosPage extends StatefulWidget {
  @override
  _ContactosPageState createState() => _ContactosPageState();
}

class _ContactosPageState extends State<ContactosPage> {
  List<Contact> listaContactos = [];
  List<Contact> listaContactosFiltro = [];
  TextEditingController _searchController = TextEditingController();
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    getAllContactos();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  getAllContactos() async {
    final resp = await Permission.contacts.request();
    print('resp: $resp');
    if (resp == PermissionStatus.granted) {
      List<Contact> _contactos = (await ContactsService.getContacts()).toList();

      setState(() {
        cargando = false;
        listaContactos = _contactos
            .where((contac) => contac.phones.isEmpty == false)
            .toList();
        _searchController.addListener(() {
          filtrarContactos();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hayBusqueda = _searchController.text.isNotEmpty;
    final List<Widget> listaTarjetas = List.generate(
        hayBusqueda ? listaContactosFiltro.length : listaContactos.length,
        (i) => tarjetaContacto2(context,
            hayBusqueda ? listaContactosFiltro[i] : listaContactos[i]));

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white60,
        body: cargando
            ? Center(
                child: Container(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                ),
              )
            : CustomScrollView(slivers: <Widget>[
                encabezadoContactos(),
                SliverList(delegate: SliverChildListDelegate(listaTarjetas))
              ]),
        // bottomNavigationBar: BottomNavigationBar(
        //   // backgroundColor: Theme.of(context).primaryColor,
        //   // selectedItemColor: Colors.pink,
        //   // unselectedItemColor: Color.fromRGBO(166, 117, 152, 1.0),
        //   showSelectedLabels: false,
        //   showUnselectedLabels: false,
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.home_outlined,
        //         color: Colors.green,
        //       ),
        //       label: 'Inicio',
        //     ),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.add), label: 'agregar contacto'),
        //     BottomNavigationBarItem(
        //         icon: Icon(
        //           Icons.search,
        //         ),
        //         label: 'buscar contacto'),
        //   ],
        // ),
      ),
    );
  }

  Widget encabezadoContactos() {
    return SliverAppBar(
      elevation: 2.0,
      // backgroundColor: Colors.teal[600],
      expandedHeight: 150.0,

      floating: true,
      pinned: true,
      title: Text('C O N T A C T O S'),
      flexibleSpace: busqueda(),
    );
  }

  void filtrarContactos() {
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

  Widget busqueda() {
    return FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
      background: Container(
        margin: EdgeInsets.only(top: 55.0, left: 5.0, right: 5.0),
        height: 150.0,
        child: TextField(
          style: TextStyle(fontSize: 25.0, color: Colors.white54, height: 1.0),
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
      ),
      //Icon(Icons.delete),
    );
  }
}

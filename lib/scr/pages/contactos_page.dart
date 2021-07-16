import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:piproy/scr/widgets/tarjeta_contactos.dart';

class ContactosPage extends StatefulWidget {
  @override
  _ContactosPageState createState() => _ContactosPageState();
}

class _ContactosPageState extends State<ContactosPage> {
  List<Contact> listaContactos = [];
  List<Contact> listaContactosFiltro = [];
  TextEditingController searchController = TextEditingController();
  bool cargando = true;
  @override
  void initState() {
    super.initState();
    getAllContactos();
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
        searchController.addListener(() {
          filtrarContactos();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hayBusqueda = searchController.text.isNotEmpty;
    final List<Widget> listaTarjetas = List.generate(
        hayBusqueda ? listaContactosFiltro.length : listaContactos.length,
        (i) => tarjetaContacto(context,
            hayBusqueda ? listaContactosFiltro[i] : listaContactos[i]));

    return SafeArea(
      child: Scaffold(
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
        bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Theme.of(context).primaryColor,
          // selectedItemColor: Colors.pink,
          // unselectedItemColor: Color.fromRGBO(166, 117, 152, 1.0),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.green,
              ),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add), label: 'agregar contacto'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: 'buscar contacto'),
          ],
        ),
      ),
    );
  }

  Widget encabezadoContactos() {
    return SliverAppBar(
      elevation: 2.0,
      // backgroundColor: Colors.teal[600],
      expandedHeight: 130.0,
      floating: true,
      pinned: true,
      title: Text('C O N T A C T O S'),
    );
  }

  void filtrarContactos() {
    List<Contact> _contactos = [];
    _contactos.addAll(listaContactos);
    if (searchController.text.isNotEmpty) {
      _contactos.retainWhere((contacto) {
        String busquedaMinuscula = searchController.text.toLowerCase();
        String nombreMinuscula = contacto.displayName.toLowerCase();
        return nombreMinuscula.contains(busquedaMinuscula);
      });

      setState(() {
        listaContactosFiltro = _contactos;
      });
    }
  }
}

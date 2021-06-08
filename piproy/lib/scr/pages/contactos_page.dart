import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

import 'package:piproy/scr/widgets/botton_bar.dart';
import 'package:piproy/scr/widgets/encabezado.dart';
import 'package:piproy/scr/widgets/encabezado_icon.dart';
import 'package:piproy/scr/widgets/tarjeta_contactos.dart';

class ContactosPage extends StatefulWidget {
  @override
  _ContactosPageState createState() => _ContactosPageState();
}

class _ContactosPageState extends State<ContactosPage> {
  List<Contact> listaContactos = [];
  List<Contact> listaContactosFiltro = [];
  TextEditingController searchController = TextEditingController();
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
        listaContactos = _contactos
            .where((contac) => contac.phones.isEmpty == false)
            .toList();
        searchController.addListener(() {
          filtrarContactos();
        });
        print(listaContactos.length);
        print(listaContactos[5].displayName);
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
        body: CustomScrollView(slivers: <Widget>[
          encabezadoContactos(),
          SliverList(delegate: SliverChildListDelegate(listaTarjetas))
        ]),
        bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
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
        flexibleSpace: Container(
            margin: EdgeInsets.only(top: 60.0, left: 10.0, right: 10.0),
            height: 60.0,
            width: double.infinity,
            child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  // labelStyle: TextStyle(fontSize: 20.0, color: Colors.green),
                  labelText: 'Buscar contacto:',
                  //prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color(152364522)),
                  ),
                ))));
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

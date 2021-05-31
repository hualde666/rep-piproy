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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllContactos();
  }

  getAllContactos() async {
    Permission permiso;
    final resp = await Permission.contacts.request();
    print('resp: $resp');
    if (resp == PermissionStatus.granted) {
      List<Contact> _contactos = (await ContactsService.getContacts()).toList();

      setState(() {
        listaContactos = _contactos
            .where((contac) => contac.phones.isEmpty == false)
            .toList();
        print(listaContactos.length);
        print(listaContactos[5].displayName);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(125.0),
          child: AppBar(
              title: Text('Contactos'),
              automaticallyImplyLeading: true, // hides leading widget
              flexibleSpace: encabezadoIcon()),
        ),
        body: _detalleContacto(context),
        bottomNavigationBar: bottonBarNavegador(context),
      ),
    );
  }

  Widget _detalleContacto(BuildContext context) {
    return ListView.builder(
      // shrinkWrap: true,
      controller: PageController(viewportFraction: 0.1),
      scrollDirection: Axis.vertical,
      itemCount: listaContactos.length,
      itemBuilder: (context, i) => tarjetaContacto(context, listaContactos[i]),
    );
  }
}

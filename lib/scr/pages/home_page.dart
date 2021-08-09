import 'package:flutter/material.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';
import 'package:piproy/scr/widgets/config_menu.dart';

import 'package:piproy/scr/widgets/elemntos.dart';
import 'package:piproy/scr/widgets/encabezado.dart';

import 'package:piproy/scr/widgets/pila_tiempo_clima.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactosProvider>(context);
    // contactProvider.obtenerlistaContactos();
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: AppBar(
              title: Center(child: Text('Proyecto PI')),
              // automaticallyImplyLeading: false, // hides leading widget
              flexibleSpace: encabezadoApp(context, 'Proyecto PI')),
        ),
        //drawer: ConfigMenu(),
        backgroundColor: Colors.white70,
        body: CustomScrollView(
          slivers: _detalle(context),
        ),
        //   bottomNavigationBar: bottonBarNavegador(context),
      ),
    );
  }

  List<Widget> _detalle(BuildContext context) {
    return <Widget>[
      //encabezadoApp(context, 'Proyecto PI'),
      SliverList(
        delegate: SliverChildListDelegate([
          SizedBox(height: 5.0),
          elementos(
              context, PilaTimpoClima(), Theme.of(context).primaryColor, ''),
          elementos(
              context,
              Text('EMERGENCIA',
                  style: TextStyle(color: Colors.white, fontSize: 35.0)),
              Color.fromRGBO(150, 0, 0, 1.0),
              'botonRojo'),
          elementos(
              context,
              Text('Contactos',
                  style: TextStyle(color: Colors.white, fontSize: 35.0)),
              Theme.of(context).primaryColor,
              'contactos'),
          elementos(
              context,
              Container(
                height: 50.0,
                width: 50.0,
                color: Colors.amber,
              ),
              Theme.of(context).primaryColor,
              ''),
          elementos(
              context,
              Text('ELEMENTO',
                  style: TextStyle(color: Colors.white, fontSize: 35.0)),
              Theme.of(context).primaryColor,
              ''),
          elementos(
              context,
              Text('ELEMENTO',
                  style: TextStyle(color: Colors.white, fontSize: 35.0)),
              Theme.of(context).primaryColor,
              ''),
        ]),
      )
    ];
  }

  Drawer _crearMenu(BuildContext context) {
    return Drawer(
      semanticLabel: 'config',
      child: ListView(
        children: [
          DrawerHeader(
            child: Container(
              height: 30.0,
              alignment: Alignment.center,
              child: Text(
                'Configuración',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
              leading: Icon(Icons.contact_phone,
                  size: 35.0, color: Theme.of(context).primaryColor),
              title: Text('Contactos de emergencia'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'emergiContactos');
              }),
          ListTile(
            leading: Icon(
              Icons.message,
              size: 40.0,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Mensaje de emergencia'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

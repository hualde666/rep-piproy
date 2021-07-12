import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/config_menu.dart';

import 'package:piproy/scr/widgets/elemntos.dart';
import 'package:piproy/scr/widgets/encabezado.dart';
import 'package:piproy/scr/widgets/icon_conteiner.dart';

import 'package:piproy/scr/widgets/pila_tiempo_clima.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(125.0),
        //   child: AppBar(
        //       title: Text('Proyecto PI'),
        //       // automaticallyImplyLeading: false, // hides leading widget
        //       flexibleSpace: encabezadoIcon()),
        // ),
        drawer: ConfigMenu(),
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
      encabezadoApp('Proyecto PI'),
      SliverList(
        delegate: SliverChildListDelegate([
          SizedBox(height: 5.0),
          elementos(
              context, Pila_Timpo_Clima(), Color.fromRGBO(55, 57, 84, 1.0), ''),
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
              Color.fromRGBO(55, 57, 84, 1.0),
              'contactos'),
          elementos(
              context,
              Container(
                height: 50.0,
                width: 50.0,
                color: Colors.amber,
              ),
              Color.fromRGBO(55, 57, 84, 1.0),
              ''),
          elementos(
              context,
              Text('ELEMENTO',
                  style: TextStyle(color: Colors.white, fontSize: 35.0)),
              Color.fromRGBO(55, 57, 84, 1.0),
              ''),
          elementos(
              context,
              Text('ELEMENTO',
                  style: TextStyle(color: Colors.white, fontSize: 35.0)),
              Color.fromRGBO(55, 57, 84, 1.0),
              ''),
        ]),
      )
    ];
  }

  Drawer _crearMenu(BuildContext context) {
    return Drawer(
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
              color: Color.fromRGBO(55, 57, 84, 1.0),
            ),
          ),
          ListTile(
              leading: Icon(Icons.contact_phone,
                  size: 35.0, color: Color.fromRGBO(55, 57, 84, 1.0)),
              title: Text('Contactos de emergencia'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'emergiContactos');
              }),
          ListTile(
            leading: Icon(
              Icons.message,
              size: 40.0,
              color: Color.fromRGBO(55, 57, 84, 1.0),
            ),
            title: Text('Mensaje de emergencia'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:piproy/scr/widgets/elemntos.dart';
import 'package:piproy/scr/widgets/encabezado.dart';

import 'package:piproy/scr/widgets/pila_tiempo_clima.dart';

class Home2Page extends StatelessWidget {
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
          elementos(context, Pila_Timpo_Clima(), Colors.black, ''),
          elementos(
              context,
              Text('EMERGENCIA',
                  style: TextStyle(color: Colors.white, fontSize: 35.0)),
              Colors.red,
              'botonRojo'),
          elementos(
              context,
              Text('Contactos',
                  style: TextStyle(color: Colors.white, fontSize: 35.0)),
              Colors.black,
              'contactos'),
          elementos(
              context,
              Container(
                height: 50.0,
                width: 50.0,
                color: Colors.amber,
              ),
              Colors.black,
              ''),
          elementos(
              context,
              Text('ELEMENTO',
                  style: TextStyle(color: Colors.white, fontSize: 35.0)),
              Colors.black,
              ''),
          elementos(
              context,
              Text('ELEMENTO',
                  style: TextStyle(color: Colors.white, fontSize: 35.0)),
              Colors.black,
              ''),
        ]),
      )
    ];
  }
}

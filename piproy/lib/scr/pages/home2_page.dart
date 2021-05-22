import 'package:flutter/material.dart';
import 'package:piproy/widgets/botton_bar.dart';
import 'package:piproy/widgets/elemntos.dart';
import 'package:piproy/widgets/encabezado.dart';
import 'package:piproy/widgets/encabezado_icon.dart';

import 'package:piproy/widgets/pila_tiempo_clima.dart';

class Home2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(200.0), // here the desired height
      //   child: _encabezadoApp(),
      // ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: _detalle(context),
        ),
      ),
      bottomNavigationBar: bottonBarNavegador(context),
    );
  }

  List<Widget> _detalle(BuildContext context) {
    return <Widget>[
      encabezadoApp(),
      SliverList(
        delegate: SliverChildListDelegate([
          encabezadoIcon(),
          elementos(context, Pila_Timpo_Clima(), Colors.black, ''),
          SizedBox(height: 3.0),
          elementos(
              context,
              Center(
                child: Text('EMERGENCIA',
                    style: TextStyle(color: Colors.white, fontSize: 35.0)),
              ),
              Colors.red,
              'botonRojo'),
          SizedBox(height: 3.0),
          elementos(
              context,
              Center(
                  child: Text('Contactos',
                      style: TextStyle(color: Colors.white, fontSize: 35.0))),
              Colors.black,
              'contactos'),
          SizedBox(height: 3.0),
          elementos(
              context,
              Center(
                  child: Text('Aplicaciones',
                      style: TextStyle(color: Colors.white, fontSize: 35.0))),
              Colors.black,
              ''),
          SizedBox(height: 3.0),
          elementos(
              context,
              Center(
                  child: Text('ELEMENTO',
                      style: TextStyle(color: Colors.white, fontSize: 35.0))),
              Colors.black,
              ''),
          SizedBox(height: 3.0),
          elementos(
              context,
              Center(
                  child: Text('ELEMENTO',
                      style: TextStyle(color: Colors.white, fontSize: 35.0))),
              Colors.black,
              ''),
        ]),
      )
    ];
  }
}

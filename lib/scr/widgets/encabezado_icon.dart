import 'package:flutter/material.dart';

import 'package:piproy/scr/widgets/icon_conteiner.dart';

Widget encabezadoIcon(BuildContext context) {
  //final bool isOn = false;
  final List<Widget> _listaWidget = [
    Column(
      children: [
        Container(
          height: 75,
          margin: EdgeInsets.only(left: 10, right: 10),
          child: conteinerIcon(
              context,
              Icon(Icons.engineering, size: 40.0, color: Colors.white),
              'configurar',
              ''),
        ),
        Text(
          'configurar',
          style: TextStyle(color: Colors.white60),
        )
      ],
    ),
// linterna
    Column(
      children: [
        Container(
          height: 75,
          margin: EdgeInsets.only(right: 10),
          child: conteinerIcon(
              context,
              Icon(Icons.filter_alt, size: 40.0, color: Colors.white),
              'linterna',
              ''),
        ),
        Text(
          'linterna',
          style: TextStyle(color: Colors.white60),
        )
      ],
    ),
    Column(
      children: [
        Container(
          height: 75,
          margin: EdgeInsets.only(right: 10),
          child: conteinerIcon(
              context,
              Icon(Icons.battery_std, size: 40.0, color: Colors.white),
              'bateria',
              ''),
        ),
        Text(
          'pila',
          style: TextStyle(color: Colors.white60),
        )
      ],
    ),
    Column(
      children: [
        Container(
          height: 75,
          margin: EdgeInsets.only(right: 10),
          child: conteinerIcon(context,
              Icon(Icons.wifi, size: 40.0, color: Colors.white), 'wifi', ''),
        ),
        Text(
          'wifi',
          style: TextStyle(color: Colors.white60),
        )
      ],
    ),
    Column(
      children: [
        Container(
          height: 75,
          margin: EdgeInsets.only(right: 10),
          child: conteinerIcon(
              context,
              Icon(Icons.access_alarms, size: 40.0, color: Colors.white),
              'alarma',
              ''),
        ),
        Text(
          'alarma',
          style: TextStyle(color: Colors.white60),
        )
      ],
    ),
    Column(
      children: [
        Container(
          height: 75,
          margin: EdgeInsets.only(right: 10),
          child: conteinerIcon(context,
              Icon(Icons.chat, size: 40.0, color: Colors.white), 'chat', ''),
        ),
        Text(
          'mensaje',
          style: TextStyle(color: Colors.white60),
        )
      ],
    ),
    Column(
      children: [
        Container(
          height: 75,
          margin: EdgeInsets.only(right: 10),
          child: conteinerIcon(
              context,
              Icon(Icons.add_call, size: 40.0, color: Colors.white),
              'llamada',
              ''),
        ),
        Text(
          'telefono',
          style: TextStyle(color: Colors.white60),
        )
      ],
    ),
  ];
  return Container(
    height: 100,

    width: double.infinity,
    //margin: //EdgeInsets.only(top: 55.0),
    child: ListView.builder(
      controller: PageController(viewportFraction: 0.1),
      scrollDirection: Axis.horizontal,
      itemCount: _listaWidget.length,
      itemBuilder: (context, i) => _listaWidget[i],
    ),
  );
}

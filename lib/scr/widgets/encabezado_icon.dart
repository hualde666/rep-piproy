import 'package:flutter/material.dart';

import 'package:piproy/scr/widgets/icon_conteiner.dart';

Widget encabezadoIcon(BuildContext context) {
  //final bool isOn = false;
  final List<Widget> _listaWidget = [
    Column(
      children: [
        Container(
          height: 75,
          child: conteinerIcon(
              context,
              Icon(Icons.engineering, size: 40.0, color: Colors.white),
              'configurar',
              null),
        ),
        Text(
          'configurar',
          style: TextStyle(color: Colors.white60),
        )
      ],
    ),
// lintern
    SizedBox(
      width: 10,
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 75,
          child: conteinerIcon(
              context,
              Icon(Icons.call, size: 40.0, color: Colors.white),
              'discado',
              null),
        ),
        Text(
          'telefono',
          style: TextStyle(color: Colors.white60),
        )
      ],
    ),
    SizedBox(
      width: 10,
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 75,
          child: conteinerIcon(
              context,
              Icon(Icons.battery_std, size: 40.0, color: Colors.white),
              'bateria',
              null),
        ),
        Center(
          child: Text(
            'pila',
            style: TextStyle(color: Colors.white60),
          ),
        )
      ],
    ),
    SizedBox(
      width: 10,
    ),

    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 75,
          child: conteinerIcon(context,
              Icon(Icons.wifi, size: 40.0, color: Colors.white), 'wifi', null),
        ),
        Text(
          'wifi',
          style: TextStyle(color: Colors.white60),
        )
      ],
    ),
    SizedBox(
      width: 10,
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 75,
          child: conteinerIcon(
              context,
              Icon(Icons.signal_cellular_alt_rounded,
                  size: 40.0, color: Colors.white),
              'señal',
              null),
        ),
        Text(
          'linea',
          style: TextStyle(color: Colors.white60),
        )
      ],
    ),
    SizedBox(
      width: 10,
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 75,
          child: conteinerIcon(
              context,
              Icon(Icons.gps_fixed_rounded, size: 40.0, color: Colors.white),
              'gps',
              null),
        ),
        Text(
          'gps',
          style: TextStyle(color: Colors.white60),
        )
      ],
    ),
    SizedBox(
      width: 10,
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 75,
          child: conteinerIcon(
              context,
              Icon(Icons.filter_alt, size: 40.0, color: Colors.white),
              'linterna',
              null),
        ),
        Text(
          'linterna',
          style: TextStyle(color: Colors.white60),
        )
      ],
    ),
    SizedBox(
      width: 10,
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 75,
          child: conteinerIcon(
              context,
              Icon(Icons.chat, size: 40.0, color: Colors.white),
              'mensaje',
              null),
        ),
        Text(
          'mensaje',
          style: TextStyle(color: Colors.white60),
        )
      ],
    ),
    SizedBox(
      width: 10,
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 75,
          child: conteinerIcon(
              context,
              Icon(Icons.access_alarms, size: 40.0, color: Colors.white),
              'alarma',
              null),
        ),
        Text(
          'alarma',
          style: TextStyle(color: Colors.white60),
        )
      ],
    ),
  ];
  return Container(
    height: 100,
    margin: EdgeInsets.only(top: 2),
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

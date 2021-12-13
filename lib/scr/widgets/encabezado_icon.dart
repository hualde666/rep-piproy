import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:piproy/scr/widgets/icon_conteiner.dart';

Widget encabezadoIcon(BuildContext context) {
  //final bool isOn = false;
  final List<Widget> _listaWidget = [
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 75,
          child: conteinerIcon(
              context,
              Icon(
                Icons.engineering,
                size: 40.0,
              ),
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
              Icon(
                Icons.call,
                size: 40.0,
              ),
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
              Icon(
                Icons.battery_std,
                size: 40.0,
              ),
              'bateria',
              null),
        ),
        Center(
          child: Text(
            'batería',
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
          child: conteinerIcon(
              context,
              Icon(
                Icons.wifi,
                size: 40.0,
              ),
              'wifi',
              null),
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
              Icon(
                Icons.signal_cellular_alt_rounded,
                size: 40.0,
              ),
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
              Icon(
                Icons.gps_fixed_rounded,
                size: 40.0,
              ),
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
              Icon(
                Icons.filter_alt,
                size: 40.0,
              ),
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
              Icon(
                Icons.chat,
                size: 40.0,
              ),
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
              Icon(
                Icons.access_alarms,
                size: 40.0,
              ),
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
    margin: EdgeInsets.only(
      top: 2,
      right: 5,
    ),

    //width: MediaQuery.of(context).w,
    //margin: //EdgeInsets.only(top: 55.0),
    child: ListView.builder(
      padding: EdgeInsets.only(left: 5),
      // controller: PageController(initialPage: 1, viewportFraction: 0.5),
      scrollDirection: Axis.horizontal,
      itemCount: _listaWidget.length,
      itemBuilder: (context, i) => _listaWidget[i],
    ),
  );
}

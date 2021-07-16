import 'package:flutter/material.dart';

import 'package:piproy/scr/widgets/icon_conteiner.dart';

Widget encabezadoIcon(BuildContext context) {
  //final bool isOn = false;
  final List<Widget> _listaWidget = [
    conteinerIcon(
        context,
        Icon(Icons.filter_alt,
            size: 40.0, color: Colors.white, semanticLabel: 'linterna'),
        'linterna',
        ''), // linterna
    conteinerIcon(
        context,
        Icon(Icons.battery_std, size: 40.0, color: Colors.white),
        'bateria',
        ''),
    conteinerIcon(
        context, Icon(Icons.wifi, size: 40.0, color: Colors.white), 'wifi', ''),
    conteinerIcon(
        context,
        Icon(Icons.access_alarms, size: 40.0, color: Colors.white),
        'alarma',
        ''),
    conteinerIcon(
        context, Icon(Icons.chat, size: 40.0, color: Colors.white), 'chat', ''),
    conteinerIcon(context,
        Icon(Icons.add_call, size: 40.0, color: Colors.white), 'llamada', ''),
  ];
  return Container(
    height: 100.0,
    width: double.infinity,
    margin: EdgeInsets.only(top: 30.0),
    child: ListView.builder(
        controller: PageController(viewportFraction: 0.1),
        scrollDirection: Axis.horizontal,
        itemCount: _listaWidget.length,
        itemBuilder: (context, i) => _listaWidget[i]),
  );
}

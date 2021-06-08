import 'package:flutter/material.dart';

import 'package:piproy/scr/widgets/icon_conteiner.dart';

Widget encabezadoIcon() {
  final bool isOn = false;
  final List<Widget> _listaWidget = [
    conteinerIcon(
        Icon(
          Icons.filter_alt,
          size: 40.0,
          color: Colors.green,
          semanticLabel: 'linterna',
        ),
        'linterna'), // linterna
    conteinerIcon(
        Icon(Icons.battery_std, size: 40.0, color: Colors.green), 'bateria'),
    conteinerIcon(Icon(Icons.wifi, size: 40.0, color: Colors.green), 'wifi'),
    conteinerIcon(
        Icon(Icons.access_alarms, size: 40.0, color: Colors.green), 'alarma'),
    conteinerIcon(Icon(Icons.chat, size: 40.0, color: Colors.green), 'chat'),
    conteinerIcon(
        Icon(Icons.add_call, size: 40.0, color: Colors.green), 'llamada'),
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

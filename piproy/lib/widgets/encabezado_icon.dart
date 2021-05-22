import 'package:flutter/material.dart';

Widget encabezadoIcon() {
  final List<Widget> _listaWidget = [
    _conteinerIcon(Icon(Icons.filter_alt, size: 40.0, color: Colors.green)),
    _conteinerIcon(Icon(Icons.battery_std, size: 40.0, color: Colors.green)),
    _conteinerIcon(Icon(Icons.wifi, size: 40.0, color: Colors.green)),
    _conteinerIcon(Icon(Icons.access_alarms, size: 40.0, color: Colors.green)),
    _conteinerIcon(Icon(Icons.chat, size: 40.0, color: Colors.green)),
    _conteinerIcon(Icon(Icons.add_call, size: 40.0, color: Colors.green)),
  ];
  return Container(
    height: 70.0,
    width: 70.0,
    margin: EdgeInsets.all(10.0),
    child: ListView.builder(
        controller: PageController(viewportFraction: 0.2),
        scrollDirection: Axis.horizontal,
        itemCount: _listaWidget.length,
        itemBuilder: (context, i) => _listaWidget[i]),
  );
}

Widget _conteinerIcon(Icon icon) {
  return Container(
    width: 70.0,
    height: 70.0,
    decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.green)),
    margin: EdgeInsets.only(left: 15.0),
    child: icon, // Icon(icon, size: 40.0, color: Colors.green),
  );
}

import 'package:flutter/material.dart';
import 'package:piproy/scr/models/linterna_model.dart';
//import 'package:lamp/lamp.dart';

Widget encabezadoIcon() {
  final bool isOn = false;
  final List<Widget> _listaWidget = [
    _conteinerIcon(Icon(Icons.filter_alt, size: 40.0, color: Colors.green),
        'linterna'), // linterna
    _conteinerIcon(
        Icon(Icons.battery_std, size: 40.0, color: Colors.green), 'bateria'),
    _conteinerIcon(Icon(Icons.wifi, size: 40.0, color: Colors.green), 'wifi'),
    _conteinerIcon(
        Icon(Icons.access_alarms, size: 40.0, color: Colors.green), 'alarm'),
    _conteinerIcon(Icon(Icons.chat, size: 40.0, color: Colors.green), 'chat'),
    _conteinerIcon(
        Icon(Icons.add_call, size: 40.0, color: Colors.green), 'llamada'),
  ];
  return Container(
    height: 100.0,
    width: double.infinity,
    margin: EdgeInsets.only(left: 10.0, top: 20.0),
    child: ListView.builder(
        controller: PageController(viewportFraction: 0.2),
        scrollDirection: Axis.horizontal,
        itemCount: _listaWidget.length,
        itemBuilder: (context, i) => _listaWidget[i]),
  );
}

Widget _conteinerIcon(Icon icon, String tarea) {
  return GestureDetector(
    child: Container(
      width: 70.0,
      height: 70.0,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.green)),
      margin: EdgeInsets.only(left: 15.0, top: 30.0),
      child: icon, // Icon(icon, size: 40.0, color: Colors.green),
    ),
    onTap: () => {funcionIcon(tarea)},
  );
}

funcionIcon(String tarea) {
  print(tarea);
  if (tarea == 'linterna') {
    // Lamp.turnOn(intensity: 1.0);
  }
}

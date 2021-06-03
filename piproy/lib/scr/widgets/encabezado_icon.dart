import 'package:flutter/material.dart';
import 'package:piproy/scr/models/linterna_model.dart';
import 'package:flashlight/flashlight.dart';

Widget encabezadoIcon() {
  final bool isOn = false;
  final List<Widget> _listaWidget = [
    _conteinerIcon(
        Icon(
          Icons.filter_alt,
          size: 40.0,
          color: Colors.green,
          semanticLabel: 'linterna',
        ),
        'linterna'), // linterna
    _conteinerIcon(
        Icon(Icons.battery_std, size: 40.0, color: Colors.green), 'bateria'),
    _conteinerIcon(Icon(Icons.wifi, size: 40.0, color: Colors.green), 'wifi'),
    _conteinerIcon(
        Icon(Icons.access_alarms, size: 40.0, color: Colors.green), 'alarma'),
    _conteinerIcon(Icon(Icons.chat, size: 40.0, color: Colors.green), 'chat'),
    _conteinerIcon(
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

Widget _conteinerIcon(Icon icon, String tarea) {
  return GestureDetector(
    child: Tooltip(
      message: tarea,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient:
            const LinearGradient(colors: <Color>[Colors.amber, Colors.green]),
      ),
      height: 50,
      padding: const EdgeInsets.all(4.0),
      preferBelow: false,
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 24,
      ),
      showDuration: const Duration(seconds: 2),
      waitDuration: const Duration(seconds: 1),
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
    ),
    onTap: () => {funcionIcon(tarea)},
  );
}

funcionIcon(String tarea) {
  print(tarea);
  if (tarea == 'linterna') {
    Flashlight.lightOn();
  }
}

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:piproy/scr/funciones/abrir_whatsapp.dart';
import 'package:piproy/scr/pages/linterna_page.dart';

import 'package:piproy/scr/providers/estado_celular.dart';
import 'package:provider/provider.dart';

Widget conteinerIcon(
    BuildContext context, Icon icon, String tarea, Contact contacto) {
  String phone;
  Widget widget;

  if (phone != null) {
    phone = contacto.phones.elementAt(0).value;
  }

  if (tarea == 'bateria') {
    widget = Pila(icon);
  } else {
    if (tarea == 'wifi') {
      widget = Wifi();
    } else {
      widget = Center(
          child: Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
            color: (tarea == 'whatsapp')
                ? Colors.green
                : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(80),
            border: Border.all(color: Colors.white, width: 2.0)),
        child: icon,
      ));
    }
  }
  return GestureDetector(
      child: widget, onTap: () => funcionIcon(context, tarea, contacto));
}

funcionIcon(BuildContext context, String tarea, Contact contacto) {
  String phone;
  if (contacto != null) {
    phone = contacto.phones.elementAt(0).value;
  }
  print(tarea);
  switch (tarea) {
    case 'discado':
      llamar("");
      break;
    case 'llamada':
      llamar(phone);
      break;
    case 'bateria':
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => PilaPage()),
      // );
      break;
    case 'wifi':
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => WifiPage()),
      // );
      break;
    case 'linterna':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LinternaPage()),
      );
      break;
    case 'whatsapp':
      abrirWhatsapp(phone, '');
      break;
    case 'configurar':
      Navigator.pushNamed(context, 'configurar');
      break;
    case 'editar':
      Navigator.pushNamed(context, 'mostrarContacto', arguments: contacto);
      break;
  }
}

class Wifi extends StatefulWidget {
  @override
  State<Wifi> createState() => _WifiState();
}

class _WifiState extends State<Wifi> {
  Color color;

  @override
  Widget build(BuildContext context) {
    final celProvider = Provider.of<EstadoProvider>(context);

    color = celProvider.wifiColor;

    return Center(
        child: Container(
      width: 70.0,
      height: 70.0,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(80),
          border: Border.all(color: Colors.white, width: 2.0)),
      child: Center(child: Icon(Icons.wifi, size: 40.0, color: Colors.white)),
    ));
  }
}

class Pila extends StatefulWidget {
  Pila(Icon icon);
  @override
  _PilaState createState() => _PilaState();
}

class _PilaState extends State<Pila> {
  Color color;
  int nivelBateria;
  bool cargando;
  Icon icon;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final celProvider = Provider.of<EstadoProvider>(context);
    nivelBateria = celProvider.nivelBateria;
    color = celProvider.bateriaColor;
    cargando = celProvider.cargandoBateria;

    return Center(
        child: Container(
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
                color: cargando ? Colors.blue[900] : color,
                borderRadius: BorderRadius.circular(80),
                border: Border.all(color: Colors.white, width: 2.0)),
            child: Center(
              child: Text(
                '$nivelBateria%',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ) // Icon(Icons.battery_std, size: 40.0, color: Colors.white),
            ));
  }
}

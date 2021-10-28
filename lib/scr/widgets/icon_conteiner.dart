import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import 'package:piproy/scr/funciones/abrir_whatsapp.dart';
import 'package:piproy/scr/pages/linterna_page.dart';
import 'package:piproy/scr/pages/pila_page.dart';
import 'package:piproy/scr/pages/wifi_page.dart';

Widget conteinerIcon(
    BuildContext context, Icon icon, String tarea, Contact contacto) {
  String phone;
  if (phone != null) {
    phone = contacto.phones.elementAt(0).value;
  }
  return GestureDetector(
      child: Center(
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
        ),
      ),

      //icon, // Icon(icon, size: 40.0, color: Colors.green),
      onTap: () => {funcionIcon(context, tarea, contacto)});
}

funcionIcon(BuildContext context, String tarea, Contact contacto) {
  String phone;
  if (contacto != null) {
    phone = contacto.phones.elementAt(0).value;
  }
  print(tarea);
  switch (tarea) {
    case 'llamada':
      llamar(phone);
      break;
    case 'bateria':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PilaPage()),
      );
      break;
    case 'wifi':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WifiPage()),
      );
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

llamar(String phone) async {
  // bool res = await FlutterPhoneDirectCaller.callNumber(phone);
}

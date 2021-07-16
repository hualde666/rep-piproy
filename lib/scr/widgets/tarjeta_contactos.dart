import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/icon_conteiner.dart';

Widget tarjetaContacto(BuildContext context, Contact contacto) {
  final String _nombre =
      contacto.displayName != null ? contacto.displayName : 'Sin Nombre';
  // final String _telefono = contacto.phones.elementAt(0).value;
  return GestureDetector(
    child: Container(
      height: 400.0,
      //color: Colors.white38,
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // _avatar(contacto),
          _nombreContacto(context, _nombre),
          SizedBox(
            height: 150.0,
          ),

          _botonesContactos(context, contacto),
        ],
      ),
      decoration: BoxDecoration(
          image: contacto.avatar.isEmpty
              ? null
              : DecorationImage(
                  image: MemoryImage(contacto.avatar), fit: BoxFit.cover),
          color: Colors.white38,
          borderRadius: BorderRadius.circular(20.0),
          border:
              Border.all(color: Theme.of(context).primaryColor, width: 5.0)),
    ),
    onTap: () {
      Navigator.pop(context);
      // Navigator.pushNamed(context, '');
    },
  );
}

Widget _botonesContactos(BuildContext context, Contact contacto) {
  return Container(
    height: 100.0,
    margin: EdgeInsets.only(bottom: 10.0, right: 15.0),
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        conteinerIcon(
            context,
            Icon(Icons.message, size: 40.0, color: Colors.white),
            'mensaje',
            ''),
        conteinerIcon(
            context,
            Icon(Icons.video_call, size: 40.0, color: Colors.white),
            'video llamada',
            ''),
        conteinerIcon(
            context,
            Icon(Icons.call, size: 40.0, color: Colors.white),
            'llamada',
            contacto.phones.elementAt(0).value),
      ],
    ),
  );
}

Widget _nombreContacto(BuildContext context, String nombre) {
  return Container(
      height: 100,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.green)),
      child: Center(
          child: Text(nombre,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
              ))));
}

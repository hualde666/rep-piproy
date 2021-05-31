import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

Widget tarjetaContacto(BuildContext context, Contact contacto) {
  final x = 0;
  final String _nombre =
      contacto.displayName != null ? contacto.displayName : 'Sin Nombre';
  final String _telefono = contacto.phones.elementAt(0).value;
  return GestureDetector(
    child: Container(
      height: 300.0,
      // padding: EdgeInsets.symmetric(vertical: 5.0),
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _avatar(contacto),
          Center(
              child: Text(_nombre,
                  style: TextStyle(color: Colors.white, fontSize: 30.0))),
          Center(
            child: Container(
              height: 70.0,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _accionIcon(
                      Icon(Icons.message, size: 40.0, color: Colors.green), ''),
                  _accionIcon(
                      Icon(Icons.video_call, size: 40.0, color: Colors.green),
                      ''),
                  _accionIcon(
                      Icon(Icons.call, size: 40.0, color: Colors.green), ''),
                ],
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.green)),
    ),
    onTap: () {
      Navigator.pop(context);
      // Navigator.pushNamed(context, '');
    },
  );
}

_accionIcon(Icon icon, String s) {
  return Expanded(
    child: GestureDetector(
      child: Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.green)),
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: icon, // Icon(icon, size: 40.0, color: Colors.green),
      ),
      onTap: () => {},
    ),
  );
}

Widget _avatar(Contact contacto) {
  if (contacto.avatar.isEmpty) {
    return CircleAvatar(
      child: Text(
        contacto.initials(),
        style: TextStyle(fontSize: 30.0),
      ),
      foregroundColor: Colors.black,
      backgroundColor: Colors.green,
      maxRadius: 50.0,
    );
  } else {
    return CircleAvatar(
      maxRadius: 50.0,
      backgroundImage: MemoryImage(contacto.avatar),
    );
  }
}

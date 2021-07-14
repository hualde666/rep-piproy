import 'package:flutter/material.dart';

class ConfigMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Container(
              height: 30.0,
              alignment: Alignment.center,
              child: Text(
                'Configuración',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              color: Color.fromRGBO(55, 57, 84, 1.0),
            ),
          ),
          ListTile(
              leading: Icon(Icons.contact_phone,
                  size: 35.0, color: Color.fromRGBO(55, 57, 84, 1.0)),
              title: Text('Contactos de emergencia'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'emergiContactos');
              }),
          ListTile(
            leading: Icon(
              Icons.message,
              size: 40.0,
              color: Color.fromRGBO(55, 57, 84, 1.0),
            ),
            title: Text('Mensaje de emergencia'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'emergiMensaje');
            },
          ),
        ],
      ),
    );
  }
}

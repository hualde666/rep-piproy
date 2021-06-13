import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

class EmergenciaContactos extends StatefulWidget {
  @override
  _EmergenciaContactos createState() => _EmergenciaContactos();
}

class _EmergenciaContactos extends State<EmergenciaContactos> {
  List<Contact> ContactosEmergencia = [];
  List<Contact> listaSelect = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contactos de Emergencía'),
      ),
      body: Center(child: Text('Listado de Contactos')),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pushNamed(context, 'selecContactos',
              arguments: listaSelect);
          print(listaSelect.length);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class EditarContacto extends StatelessWidget {
  //final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Contact _contact = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('Datos Contacto'),
        ),
        body: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Id: ${_contact.identifier}'),
                Text('Identificador: ${_contact.displayName}'),
                Text('Iniciales: ${_contact.initials()}'),
                Text('Nombre: ${_contact.givenName}'),
                Text('Apellido: ${_contact.familyName}'),
                Text('Compañia: ${_contact.company}'),
                Text(
                    'Telefono: ${_contact.phones.elementAt(0).value} ${_contact.phones.elementAt(0).label}, '),
              ],
            ),
          ),
        ));
  }
}

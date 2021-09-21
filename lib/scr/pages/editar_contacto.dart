import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:piproy/scr/widgets/header_app.dart';

class EditarContacto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Contact _contact = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: headerApp(context, 'Contacto', Text(''), 0.0),
      backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
      body: FormContacto(_contact),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.save,
          size: 40,
          color: Colors.white,
        ),
        label: Text(
          'guardar',
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(249, 75, 11, 1),
        onPressed: () {},
      ),
    );
  }
}

class FormContacto extends StatelessWidget {
  FormContacto(this.contact);
  final Contact contact;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
        'editar',
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
      )),
    );
  }
}

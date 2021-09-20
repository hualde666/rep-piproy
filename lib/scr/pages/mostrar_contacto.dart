import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:piproy/scr/widgets/header_app.dart';

class MostrarContacto extends StatelessWidget {
  //final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Contact _contact = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: headerApp(context, 'Contacto', Text(''), 0.0),
      backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
      body: fichaContacto(_contact),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.edit,
          size: 40,
          color: Colors.white,
        ),
        label: Text(
          'editar',
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(249, 75, 11, 1),
        onPressed: () {},
      ),
    );
  }

  Widget _avatar(Contact contacto) {
    if (contacto.avatar.isEmpty) {
      return Container(
        height: 80.0,
        child: CircleAvatar(
          child: Text(
            contacto.initials(),
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w900,
                color: Colors.green),
          ),
          foregroundColor: Colors.green,
          backgroundColor: Colors.white,
          maxRadius: 50.0,
        ),
      );
    } else {
      return Container(
        height: 80.0,
        child: CircleAvatar(
          maxRadius: 50.0,
          backgroundImage: MemoryImage(contacto.avatar),
        ),
      );
    }
  }

  Widget fichaContacto(Contact _contact) {
    List<Widget> listaPhone = creaListaDatos(_contact);

    return ListView.builder(
        itemCount: listaPhone.length,
        itemBuilder: (contest, i) {
          print('$i');
          return listaPhone[i];
        });

    //_contact.phones.
  }

  List<Widget> creaListaDatos(Contact _contact) {
    List<Widget> lista = [
      Container(
        height: 170,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: Color.fromRGBO(55, 57, 84, 1.0),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.white)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: _avatar(_contact)),
            //    Text('Id: ${_contact.identifier}',
            //      style: TextStyle(color: Colors.white, fontSize: 20)),
            Center(
              child: _contact.displayName != null
                  ? Text(' ${_contact.displayName}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 30))
                  : Text('',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 10,
      ),
      dato('Primer Nombre:', _contact.givenName),
      dato('Segundo Nombre:', _contact.middleName),
      dato('Apellido:', _contact.familyName),
      dato('Compañia:', _contact.company),
    ];

    for (var i = 0; i < _contact.phones.length; i++) {
      if (i == 0) {
        lista.add(dato('Teléfonos:', _contact.phones.elementAt(i).value));
      } else {
        lista.add(dato(' ', _contact.phones.elementAt(i).value));
      }
    }
    lista.add(SizedBox(
      height: 70,
    ));
    return lista;
  }

  Widget dato(String titulo, String campo) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 70,
      color: Color.fromRGBO(55, 57, 84, 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$titulo  ',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 15)),
          campo != null
              ? Center(
                  child: Text(' $campo',
                      style: TextStyle(color: Colors.white, fontSize: 28)),
                )
              : Text(''),
          Divider(
            height: 10,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

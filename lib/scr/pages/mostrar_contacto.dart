import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';

import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';
import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';

class MostrarContacto extends StatefulWidget {
  @override
  State<MostrarContacto> createState() => _MostrarContactoState();
}

class _MostrarContactoState extends State<MostrarContacto> {
  @override
  Widget build(BuildContext context) {
    final contactosProvider = Provider.of<ContactosProvider>(context);
    final contacto = contactosProvider.contacto;
    return SafeArea(
      child: Scaffold(
        appBar: headerApp(context, '', Text(''), 0.0, true),
        body: fichaContacto(contacto),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BotonFlotante(pagina: 'mostrarContacto'),
            FloatingActionButton.extended(
              heroTag: "editar",
              icon: Icon(
                Icons.edit,
              ),
              label: Text(
                'editar',
              ),
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => EditarContacto()));
                final apiProvider =
                    Provider.of<AplicacionesProvider>(context, listen: false);
                final listaApi = apiProvider.categoryApi['Todas'];
                final Application api = listaApi.firstWhere(
                    (element) =>
                        element.packageName == 'com.google.android.contacts',
                    orElse: null);
                if (api != null) {
                  api.openApp();
                }
              },
            ),
          ],
        ),
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
    if (_contact.phones.isNotEmpty) {
      for (var i = 0; i < _contact.phones.length; i++) {
        String phone = _contact.phones.elementAt(i).value.replaceAll('+', '');
        phone = phone + ' ' + _contact.phones.elementAt(i).label;
        if (i == 0) {
          lista.add(dato('Teléfonos:', phone));
        } else {
          lista.add(dato(' ', phone));
        }
      }
    }

    if (_contact.emails.isNotEmpty) {
      for (var i = 0; i < _contact.emails.length; i++) {
        String correo = _contact.emails.elementAt(i).value;
        if (i == 0) {
          lista.add(dato('Correos:', correo));
        } else {
          lista.add(dato('C', correo));
        }
      }
    }

    lista.add(SizedBox(
      height: 70,
    ));
    return lista;
  }

  Widget dato(String titulo, String campo) {
    double altoLetra = 28.0;
    double altoContainer = 50;
    if (titulo == 'Correos:' || titulo == 'C') {
      altoLetra = 20;
      altoContainer = 100;
      if (titulo == 'C') {
        titulo = '';
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 20,
          color: Color.fromRGBO(55, 57, 84, 1.0),
          child: Text('$titulo  ',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 15)),
        ),
        Container(
          height: altoContainer,
          color: Color.fromRGBO(55, 57, 84, 1.0),
          child: campo != null
              ? Center(
                  child: Text(' $campo',
                      style:
                          TextStyle(color: Colors.white, fontSize: altoLetra)),
                )
              : Text('',
                  style: TextStyle(color: Colors.white, fontSize: altoLetra)),
        ),
        Divider(
          height: 10,
          color: Colors.white,
        ),
      ],
    );
  }
}

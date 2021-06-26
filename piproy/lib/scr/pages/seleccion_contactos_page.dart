import 'package:flutter/material.dart';

import 'package:contacts_service/contacts_service.dart';

import 'package:piproy/scr/providers/contactos_provider.dart';
import 'package:provider/provider.dart';

class SeleccionContacto extends StatefulWidget {
  @override
  _SeleccionContactoState createState() => _SeleccionContactoState();
}

class _SeleccionContactoState extends State<SeleccionContacto> {
  @override
  Widget build(BuildContext context) {
    final listaSelectInfo = Provider.of<ContactosProvider>(context);
    // listaSelectInfo.obtenerlistaContactos();
    final lista = listaSelectInfo.listaContactos;
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccion de Contacto'),
      ),
      body: ListView.builder(
        itemCount: lista.length,
        itemBuilder: (context, i) {
          return contactoWidget(lista[i], i);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _avatar(Contact contacto) {
    if (contacto.avatar.isEmpty) {
      return Container(
        height: 50.0,
        child: CircleAvatar(
          child: Text(
            contacto.initials(),
            style: TextStyle(fontSize: 20.0, color: Colors.green),
          ),
          foregroundColor: Colors.green,
          backgroundColor: Colors.white,
          maxRadius: 50.0,
        ),
      );
    } else {
      return CircleAvatar(
        maxRadius: 50.0,
        backgroundImage: MemoryImage(contacto.avatar),
      );
    }
  }

  Widget contactoWidget(Contact contacto, int i) {
    final listaSelectInfo = Provider.of<ContactosProvider>(context);

    return Container(
      height: 60.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
      decoration: BoxDecoration(
          color: Colors.green[300],
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.green)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _avatar(contacto),
          Container(
            width: 200.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contacto.displayName,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(contacto.phones.elementAt(0).value,
                    style: TextStyle(fontSize: 15.0, color: Colors.white)),
              ],
            ),
          ),
          Checkbox(
              value: listaSelectInfo.listaCheck[i],
              activeColor: Colors.white,
              checkColor: Colors.green,
              onChanged: (value) {
                /// aqui hay problemas
                setState(() {
                  if (value) {
                    listaSelectInfo.sumarContacto(contacto, i);
                  } else {
                    listaSelectInfo.quitarContacto(contacto, i);
                  }
                });
                listaSelectInfo.cambiarCheck(i, value);
              })
        ],
      ),
    );
  }
}

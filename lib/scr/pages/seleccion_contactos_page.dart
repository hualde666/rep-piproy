import 'package:flutter/material.dart';

import 'package:contacts_service/contacts_service.dart';

import 'package:piproy/scr/providers/contactos_provider.dart';
import 'package:provider/provider.dart';

//class SeleccionContacto extends StatelessWidget {
class SeleccionContacto extends StatefulWidget {
  @override
  _SeleccionContactoState createState() => _SeleccionContactoState();
}

class _SeleccionContactoState extends State<SeleccionContacto> {
  bool cargando = true;
  @override
  Widget build(BuildContext context) {
    final listaSelectInfo = Provider.of<ContactosProvider>(context);

    final lista = listaSelectInfo.listaContactos;
    cargando = false;
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccion de Contacto'),
      ),
      body: cargando
          ? Center(
              child: Container(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            )
          : ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, i) {
                return contactoWidget(context, lista[i], i);
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          print(listaSelectInfo.listaCheck.length);
          Navigator.pop(context);
        },
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
          maxRadius: 40.0,
        ),
      );
    } else {
      return Container(
        height: 80.0,
        child: CircleAvatar(
          maxRadius: 40.0,
          backgroundImage: MemoryImage(contacto.avatar),
        ),
      );
    }
  }

  Widget contactoWidget(BuildContext context, Contact contacto, int i) {
    final listaSelectInfo = Provider.of<ContactosProvider>(context);

    return Container(
      height: 150.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
      decoration: BoxDecoration(
          color: Color.fromRGBO(55, 57, 84, 1.0), //Colors.green[300],
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.green)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _avatar(contacto),
          Container(
            width: 200.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  contacto.displayName,
                  style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(contacto.phones.elementAt(0).value,
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
              ],
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: Colors.white,
            ),
            child: Checkbox(
                value: listaSelectInfo.listaCheck[i],
                activeColor: Colors.white,
                checkColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    Provider.of<ContactosProvider>(context, listen: false)
                        .cambiarCheck(i, value);
                    if (value) {
                      Provider.of<ContactosProvider>(context, listen: false)
                          .sumarContacto(contacto, i);
                    } else {
                      Provider.of<ContactosProvider>(context, listen: false)
                          .quitarContacto(i);
                    }
                  });
                }),
          )
        ],
      ),
    );
  }
}

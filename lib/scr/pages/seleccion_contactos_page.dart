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
    double alto = MediaQuery.of(context).size.height * 0.78;
    cargando = false;
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccion Contacto Emergencia',
            style: TextStyle(
              fontSize: 15,
            ),
            textAlign: TextAlign.start),
      ),
      body: cargando
          ? Center(
              child: Container(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              height: alto,
              child: ListView.builder(
                itemCount: lista.length,
                itemBuilder: (context, i) {
                  return contactoWidget(context, lista[i], i);
                },
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.check_circle,
          size: 40,
          color: Colors.white,
        ),
        label: Text(
          'guardar',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        elevation: 10,
        backgroundColor: Color.fromRGBO(249, 75, 11, 1),
        onPressed: () {
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
          color: Theme.of(context).primaryColor, //Colors.green[300],
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.green)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // _avatar(contacto),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 1.5,
                  child: Checkbox(
                      value: listaSelectInfo.listaCheck[i],
                      activeColor: Colors.white,
                      checkColor: Colors.green,
                      onChanged: (value) {
                        setState(() {
                          Provider.of<ContactosProvider>(context, listen: false)
                              .cambiarCheck(i, value);
                          if (value) {
                            Provider.of<ContactosProvider>(context,
                                    listen: false)
                                .sumarContacto(contacto, i);
                            Provider.of<ContactosProvider>(context,
                                    listen: false)
                                .sumarIdContacto(contacto.identifier);
                          } else {
                            Provider.of<ContactosProvider>(context,
                                    listen: false)
                                .quitarContacto(i);
                            Provider.of<ContactosProvider>(context,
                                    listen: false)
                                .quitarIdContacto(contacto.identifier);
                          }
                        });
                      }),
                ),
                listaSelectInfo.listaCheck[i]
                    ? Text(
                        'quitar',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    : Text(
                        'agregar',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
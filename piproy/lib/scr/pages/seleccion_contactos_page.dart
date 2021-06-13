import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SeleccionContacto extends StatefulWidget {
  List<Contact> listaSelect = [];
  SeleccionContacto(listaSelect);
  @override
  _SeleccionContactoState createState() => _SeleccionContactoState(listaSelect);
}

class _SeleccionContactoState extends State<SeleccionContacto> {
  List<Contact> listaSelect = [];
  List<Contact> listaContactos = [];
  _SeleccionContactoState(listaSelect);

  @override
  void initState() {
    super.initState();
    getAllContactos();
  }

  getAllContactos() async {
    final resp = await Permission.contacts.request();
    print('resp: $resp');
    if (resp == PermissionStatus.granted) {
      List<Contact> _contactos = (await ContactsService.getContacts()).toList();

      setState(() {
        listaContactos = _contactos
            .where((contac) => contac.phones.isEmpty == false)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _Contactos = List.generate(listaContactos.length,
        (i) => selectContacWidget(context, listaContactos[i], listaSelect));

    return Scaffold(
        appBar: AppBar(
          title: Text('Seleccion de Contacto'),
        ),
        body: ListView.builder(
            itemCount: _Contactos.length,
            itemBuilder: (context, i) {
              return _Contactos[i];
            }));
  }

  Widget selectContacWidget(
      BuildContext context, Contact contacto, List lista) {
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
          SeleccionLista(contacto, lista)
        ],
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
}

/// This is the stateful widget that the main application instantiates.
class SeleccionLista extends StatefulWidget {
  List<Contact> listado = [];
  Contact contacto;
  SeleccionLista(contacto, listado);
  @override
  State<SeleccionLista> createState() => _SeleccionLista(contacto, listado);
}

/// This is the private State class that goes with MyStatefulWidget.
class _SeleccionLista extends State<SeleccionLista> {
  bool isChecked = false;
  Contact contacto;
  List<Contact> listado;
  _SeleccionLista(contacto, listado);
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.green;
      }
      return Colors.white;
    }

    return Checkbox(
      checkColor: Colors.green,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (value) {
        setState(() {
          isChecked = value;
          if (value) {
            listado.add(contacto);
          } else {}
        });
      },
    );
  }
}

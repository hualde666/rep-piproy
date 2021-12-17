import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactosProvider with ChangeNotifier {
  static final ContactosProvider _contactosProvider =
      ContactosProvider._internal();

  factory ContactosProvider() {
    return _contactosProvider;
  }
  ContactosProvider._internal() {
    _listaContactos = [];
    // getcontactos();
    // notifyListeners();
  }
  List<Contact> _listaContactos;
  Contact _contacto;
  get contacto {
    return _contacto;
  }

  set contacto(Contact nuevoContacto) {
    this._contacto = nuevoContacto;

    notifyListeners();
  }

  get listaContactos {
    return _listaContactos;
  }

  obtenerContacto(String nombre) async {
    List<Contact> listaContacto =
        await ContactsService.getContacts(query: nombre);
    return listaContacto;
  }

  borrarDeListaContacto(Contact contacto) {
    _listaContactos.remove(contacto);
  }

// elimina id de la lista de id conctactos

  getcontactos() async {
    // List<Contact> _lista = [];
    final resp = await Permission.contacts.request();

    if (resp == PermissionStatus.granted) {
      List<Contact> _contactos = (await ContactsService.getContacts()).toList();
      _listaContactos.addAll(_contactos
          .where((contac) => contac.phones.isEmpty == false)
          .toList());
    }
  }
}

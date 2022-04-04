import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:piproy/scr/models/contactos_modelo.dart';

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
  ContactoDatos _contacto;
  get contacto {
    return _contacto;
  }

  set contacto(ContactoDatos nuevoContacto) {
    this._contacto = nuevoContacto;

    notifyListeners();
  }

  get listaContactos async {
    if (_listaContactos == []) {
      getcontactos();
    }
    return _listaContactos;
  }

  obtenerContacto(String nombre) async {
    Iterable<Contact> listaContacto =
        await ContactsService.getContacts(query: nombre);
    Contact contact =
        listaContacto.firstWhere((element) => element.displayName == nombre);
    String _nombre = contact.displayName;
    String _telefono = "";
    String _whatsapp = "";
    if (contact.phones.isNotEmpty) {
      _telefono = contact.phones.elementAt(0).value;
      // Item item = contact.phones.firstWhere(
      //     (element) => element.value.substring(0, 1) == '+',
      //     orElse: () => null);
      // if (item != null) {
      //   _whatsapp = item.value;
      // }
    }
    final _contacto = new ContactoDatos(
        nombre: _nombre, telefono: _telefono, whatsapptel: _whatsapp);

    return _contacto;
  }

  borrarDeListaContacto(ContactoDatos contacto) {
    _listaContactos.remove(contacto);
  }

// elimina id de la lista de id conctactos

  getcontactos() async {
    // List<Contact> _lista = [];

    final resp = await Permission.contacts.request();

    if (resp == PermissionStatus.granted) {
      List<Contact> _contactos = (await ContactsService.getContacts()).toList();
      _listaContactos = [];
      _listaContactos.addAll(_contactos
          .where((contac) => contac.phones.isEmpty == false)
          .toList());

      return _listaContactos;
    }
    return [];
  }
}

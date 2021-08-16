import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactosProvider with ChangeNotifier {
  List<ItemListaEmergencia> listaSelect = [];
  List<Contact> _listaContactos = [];

  List<String> _listaIdContacto = [];
  List<bool> listaCheck = [];
  ContactosProvider() {
    obtenerlistaContactos();
    cargarPrefs();
  }

  get listaContactos {
    return _listaContactos;
  }

  get listaIdContacto {
    return _listaIdContacto;
  }

  cargarPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _listaIdContacto = prefs.getStringList('listaE');
  }

  sumarContacto(Contact contacto, int i) {
    ItemListaEmergencia nuevo = ItemListaEmergencia(
        contacto.identifier,
        contacto.displayName,
        contacto.avatar,
        i,
        contacto.initials(),
        contacto.phones.elementAt(0).value);
    listaSelect.add(nuevo);
    listaSelect.sort((a, b) => a.nombre.compareTo(b.nombre));
    notifyListeners();
  }

  quitarContacto(int i) {
    listaSelect.removeWhere((item) => item.iListaContacto == i);
    notifyListeners();
  }

// elimina id de la lista de id conctactos
  quitarIdContacto(String i) {
    _listaIdContacto.removeWhere((item) => item == i);
    notifyListeners();
  }

  sumarIdContacto(String i) {
    _listaIdContacto.add(i);
    notifyListeners();
  }

  cambiarCheck(int i, bool valor) {
    listaCheck[i] = valor;
    notifyListeners();
  }

  obtenerlistaContactos() async {
    if (_listaContactos.isEmpty) {
      _listaContactos = await getcontactos();
      listaCheck = List.generate(_listaContactos.length, (i) => false);
      // notifyListeners();
    }
    return _listaContactos;
  }

  Future<List<Contact>> getcontactos() async {
    // List<Contact> _lista = [];
    final resp = await Permission.contacts.request();
    print('resp: $resp');
    if (resp == PermissionStatus.granted) {
      List<Contact> _contactos = (await ContactsService.getContacts()).toList();

      final _lista =
          _contactos.where((contac) => contac.phones.isEmpty == false).toList();
      return _lista;
    }
    return [];
  }

  generarListaSelect(String id) {
    int i = _listaContactos
        .indexWhere((_listaContactos) => _listaContactos.identifier == id);
    if (i > 0) {
      ItemListaEmergencia nuevo = ItemListaEmergencia(
          _listaContactos[i].identifier,
          _listaContactos[i].displayName,
          _listaContactos[i].avatar,
          i,
          _listaContactos[i].initials(),
          _listaContactos[i].phones.elementAt(0).value);
      listaSelect.add(nuevo);
      listaCheck[i] = true;
    }
    listaSelect.sort((a, b) => a.nombre.compareTo(b.nombre));
    // notifyListeners();
  }
}

class ItemListaEmergencia {
  String idcontacto;
  String nombre;
  Uint8List avatar;
  int iListaContacto;
  String initials;
  String phone;
  ItemListaEmergencia(this.idcontacto, this.nombre, this.avatar,
      this.iListaContacto, this.initials, this.phone);
}

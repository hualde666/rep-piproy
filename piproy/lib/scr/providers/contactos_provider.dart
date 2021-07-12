import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:url_launcher/link.dart';

class ContactosProvider with ChangeNotifier {
  List<ItemListaEmergencia> listaSelect = [];
  List<Contact> listaContactos = [];
  List<bool> listaCheck = [];

  sumarContacto(Contact contacto, int i) {
    ItemListaEmergencia nuevo = ItemListaEmergencia(
        contacto.displayName,
        contacto.avatar,
        i,
        contacto.initials(),
        contacto.phones.elementAt(0).value);
    listaSelect.add(nuevo);
    notifyListeners();
  }

  quitarContacto(int i) {
    listaSelect.removeWhere((item) => item.iListaContacto == i);
    notifyListeners();
  }

  cambiarCheck(int i, bool valor) {
    listaCheck[i] = valor;
    notifyListeners();
  }

  obtenerlistaContactos() async {
    if (listaContactos.length == 0) {
      listaContactos = await getcontactos();
      listaCheck = List.generate(listaContactos.length, (i) => false);
      notifyListeners();
    }
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

  generarListaSelect(String phone) {
    int i = listaContactos.indexWhere(
        (listaContactos) => listaContactos.phones.elementAt(0).value == phone);
    if (i > 0) {
      ItemListaEmergencia nuevo = ItemListaEmergencia(
          listaContactos[i].displayName,
          listaContactos[i].avatar,
          i,
          listaContactos[i].initials(),
          listaContactos[i].phones.elementAt(0).value);
      listaSelect.add(nuevo);
      listaCheck[i] = true;
    }
    notifyListeners();
  }
}

class ItemListaEmergencia {
  String nombre;
  Uint8List avatar;
  int iListaContacto;
  String initials;
  String phone;
  ItemListaEmergencia(
      this.nombre, this.avatar, this.iListaContacto, this.initials, this.phone);
}

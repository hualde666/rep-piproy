import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactosProvider with ChangeNotifier {
  List<ItemListaEmergencia> listaSelect = [];
  List<Contact> listaContactos = [];
  List<bool> listaCheck = [];
  // static final ContactosProvider cp = ContactosProvider._interno();
  // ContactosProvider._interno();

  sumarContacto(Contact contacto, int i) {
    ItemListaEmergencia nuevo = ItemListaEmergencia(contacto, i);
    listaSelect.add(nuevo);
    notifyListeners();
  }

  quitarContacto(Contact contacto, int i) {
    ItemListaEmergencia elemento = ItemListaEmergencia(contacto, i);
    listaSelect.remove(elemento);
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
}

class ItemListaEmergencia {
  Contact contacto;
  int i;
  ItemListaEmergencia(this.contacto, this.i);
}

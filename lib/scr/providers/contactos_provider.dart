import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactosProvider {
  static final ContactosProvider _contactosProvider =
      ContactosProvider._internal();

  factory ContactosProvider() {
    return _contactosProvider;
  }
  ContactosProvider._internal() {
    _listaContactos = getcontactos();
  }
  Future<List<Contact>> _listaContactos;
  get listaContactos {
    return _listaContactos;
  }

// elimina id de la lista de id conctactos

  obtenerlistaContactos() {
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
}

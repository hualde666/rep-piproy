import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactosProvider {
  static final ContactosProvider _contactosProvider =
      ContactosProvider._internal();

  factory ContactosProvider() {
    return _contactosProvider;
  }
  ContactosProvider._internal() {
    _listaContactos = [];
    getcontactos();
  }
  List<Contact> _listaContactos;
  get listaContactos {
    return _listaContactos;
  }

// elimina id de la lista de id conctactos

  obtenerlistaContactos() {
    return _listaContactos;
  }

  getcontactos() async {
    // List<Contact> _lista = [];
    final resp = await Permission.contacts.request();
    print('resp: $resp');
    if (resp == PermissionStatus.granted) {
      List<Contact> _contactos = (await ContactsService.getContacts()).toList();
      _listaContactos.addAll(_contactos
          .where((contac) => contac.phones.isEmpty == false)
          .toList());
    }
  }
}

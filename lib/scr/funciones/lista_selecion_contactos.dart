import 'package:contacts_service/contacts_service.dart';
import 'package:piproy/scr/models/items_lista_contactos.dart';

generaListaE(List<Contact> lista, List<String> listaIdContacto) {
  List<ItemListaEmergencia> listaE = [];
  if (listaIdContacto != null) {
    for (var item in listaIdContacto) {
      Contact contacto = lista.firstWhere((contac) => contac.identifier == item,
          orElse: () => null);
      if (contacto != null) {
        ItemListaEmergencia nuevo = ItemListaEmergencia(
            contacto.identifier,
            contacto.displayName,
            contacto.avatar,
            contacto.initials(),
            contacto.phones.elementAt(0).value,
            true);
        listaE.add(nuevo);
      }
    }
    listaE.sort((a, b) => a.nombre.compareTo(b.nombre));
  }
  return listaE;
}

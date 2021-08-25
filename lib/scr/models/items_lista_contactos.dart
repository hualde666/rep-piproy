import 'dart:typed_data';

class ItemListaEmergencia {
  String idcontacto;
  String nombre;
  Uint8List avatar;
  // int iListaContacto;
  String initials;
  String phone;
  bool check;
  ItemListaEmergencia(this.idcontacto, this.nombre, this.avatar, this.initials,
      this.phone, this.check);
}

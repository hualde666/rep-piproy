import 'package:flutter/material.dart';

class ListaIdProvider with ChangeNotifier {
  List<String> _listaIdContacto = [];

  set listaIdContacto(List<String> nuevaLista) {
    this._listaIdContacto = nuevaLista;
  }

  get listaIdContacto {
    return this._listaIdContacto;
  }

// elimina id de la lista de id conctactos
  quitarIdContacto(String i) {
    _listaIdContacto.removeWhere((item) => item == i);
    notifyListeners();
  }

  sumarIdContacto(String i) {
    if (_listaIdContacto == null) {
      _listaIdContacto = [];
    }
    _listaIdContacto.add(i);
    notifyListeners();
  }
}

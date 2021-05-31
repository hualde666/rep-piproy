import 'package:flutter/material.dart';

class Linterna {
  final bool prendida;
  void  set prendeApaga(prendida) {
    prendida = !prendida;
    return prendida;
  }

  Linterna({this.prendida});
}

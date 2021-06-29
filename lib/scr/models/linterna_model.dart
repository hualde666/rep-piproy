class Linterna {
  final bool prendida;
  set prendeApaga(prendida) {
    prendida = !prendida;
    return prendida;
  }

  Linterna({this.prendida});
}

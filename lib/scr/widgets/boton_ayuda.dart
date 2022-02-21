import 'package:flutter/material.dart';

import 'package:piproy/scr/widgets/boton_ayuda_dibujo.dart';

Widget ayudaBoton(BuildContext context, String pagina) {
  return GestureDetector(
    onTap: () {
      //    if (pagina != 'Ayuda') {
      Navigator.pushNamed(context, 'ayuda', arguments: pagina);
      //  }
    },
    child: BotonAyudaDibujo(),
  );
}

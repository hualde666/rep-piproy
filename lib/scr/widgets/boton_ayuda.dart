import 'package:flutter/material.dart';
import 'package:piproy/scr/pages/ayuda.dart';
import 'package:piproy/scr/widgets/boton_ayuda_dibujo.dart';

class AyudaBoton extends StatelessWidget {
  AyudaBoton({String pagina});
  final String pagina = '';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //    if (pagina != 'Ayuda') {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Ayuda(pagina: pagina)));
        //  }
      },
      child: BotonAyudaDibujo(),
    );
  }
}

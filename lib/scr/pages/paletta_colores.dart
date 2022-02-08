import 'package:flutter/material.dart';

import 'package:piproy/scr/providers/usuario_pref.dart';
import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';

class PaletaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> paleta = [
      colores(context, Colors.grey[700], Color.fromRGBO(55, 57, 84, 1.0),
          Colors.white, 1),
      SizedBox(
        height: 5,
      ),
      colores(context, Color.fromARGB(255, 2, 84, 131),
          Color.fromARGB(255, 3, 51, 90), Colors.white, 2),
      SizedBox(
        height: 5,
      ),
      colores(context, Color.fromARGB(255, 4, 173, 154),
          Color.fromARGB(255, 245, 247, 245), Colors.grey[700], 3),
      SizedBox(
        height: 5,
      ),
      colores(context, Colors.black, Colors.green[300], Colors.white, 4),
      SizedBox(
        height: 5,
      ),
    ];
    return SafeArea(
      child: Scaffold(
        appBar: headerApp(
            context, 'Paleta de Colores', Text(''), 0.0, true, 'paleta'),
        //    backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(bottom: 40),
          child: ListView.builder(
              padding: EdgeInsets.only(bottom: 100),
              itemCount: paleta.length,
              itemBuilder: (context, i) {
                return paleta[i];
              }),
        ),
      ),
    );
  }

  Widget colores(BuildContext context, Color fondo, Color elemento,
      Color letras, int paleta) {
    final usuarioProvider = Provider.of<Preferencias>(context);

    return GestureDetector(
      onTap: () {
        //guardarPreferencia(paleta.toString());
        usuarioProvider.paleta = paleta.toString();
        //celProvider.paleta = paleta.toString();
      },
      child: Container(
        decoration: BoxDecoration(
            color: fondo,
            // borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
                color: usuarioProvider.paleta == paleta.toString()
                    ? Colors.white
                    : Colors.white54,
                width:
                    usuarioProvider.paleta == paleta.toString() ? 3.0 : 1.0)),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        height: 100,
        // color: fondo,
        child: Center(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              decoration: BoxDecoration(
                  color: elemento,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.white, width: 1.0)),
              child: Center(
                  child: Text(
                'ABC',
                style: TextStyle(color: letras, fontSize: 25),
              ))),
        ),
      ),
    );
  }
}

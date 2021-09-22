import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/icon_conteiner.dart';

class AyudaHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _listaAyudaHome(context);
  }

  Widget _listaAyudaHome(BuildContext context) {
    List<Widget> _lista_ayuda = _crearListaAyuda(context);

    return ListView.builder(
        itemCount: _lista_ayuda.length,
        itemBuilder: (contest, i) {
          return _lista_ayuda[i];
        });

    //_contact.phones.
  }

  List<Widget> _crearListaAyuda(BuildContext context) {
    List<Widget> lista = [
      SizedBox(
        height: 10,
      ),
      Container(
        child: Center(
            child: Text('Pantalla Inicial',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
      ),
      Container(
        height: 150,
        margin: EdgeInsets.only(left: 5),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  child: Image(
                      image: AssetImage('assets/boton_exit.png'),
                      fit: BoxFit.cover),
                  height: 70,
                  width: 70,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 70,
                  width: 250,
                  child: Center(
                    child: Text(
                      'Boton de Salida:',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Cierra la aplicación',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      Container(
        height: 150,
        margin: EdgeInsets.only(left: 5),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  child: Image(
                      image: AssetImage('assets/boton_rojo.png'),
                      fit: BoxFit.cover),
                  height: 70,
                  width: 70,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 70,
                  width: 250,
                  child: Center(
                    child: Text(
                      'Boton de Emergencia:',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Lo lleva a la pantalla para el envio de mensaje de emergencia',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        height: 150,
        margin: EdgeInsets.only(left: 5),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  child: Image(
                      image: AssetImage('assets/boton_home.png'),
                      fit: BoxFit.cover),
                  height: 70,
                  width: 70,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 70,
                  width: 250,
                  child: Center(
                    child: Text(
                      'Boton Inicio:',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Muestra el inicio de la lista de contenido',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        height: 150,
        margin: EdgeInsets.only(left: 5),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(80),
                      border: Border.all(color: Colors.white, width: 2.0)),
                  child:
                      Icon(Icons.engineering, size: 40.0, color: Colors.white),
                  height: 70,
                  width: 70,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 70,
                  width: 250,
                  child: Center(
                    child: Text(
                      'Configuración:',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Configura caracteristicas de la aplicación',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 10,
      ),
    ];
    return lista;
  }
}

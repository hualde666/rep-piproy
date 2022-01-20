import 'package:flutter/material.dart';

class AyudaHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _listaAyudaHome(context);
  }

  Widget _listaAyudaHome(BuildContext context) {
    List<Widget> _listaAyuda = _crearListaAyuda(context);

    return ListView.builder(
        itemCount: _listaAyuda.length,
        itemBuilder: (contest, i) {
          return _listaAyuda[i];
        });
  }

  List<Widget> _crearListaAyuda(BuildContext context) {
    List<Widget> lista = [
      SizedBox(
        height: 10,
      ),
      Container(
        child: Center(
            child: Text('Pantalla Inicial',
                style: TextStyle(fontSize: 30, color: Colors.white))),
      ),
      SizedBox(
        height: 10,
      ),
      Divider(
        height: 10,
        color: Colors.black87,
      ),
      Container(
        height: 150,
        margin: EdgeInsets.only(left: 5),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    width: 90,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.white30)),
                    margin: EdgeInsets.only(right: 5),
                    child: Center(
                      child: Text(
                        'SALIDA',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 70,
                  width: 250,
                  child: Center(
                    child: Text(
                      'Boton de Salida:',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20, color: Colors.white),
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
      Divider(
        height: 10,
        color: Colors.black87,
      ),
      Container(
        //height: 150,
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
                'Inicia el proceso de envio de menaje de emergencia (Deberá haber seleccionado sus contactos de emergencia previamente y tener activo el GPS para que funcione el envio de su geolocalización). Se enviará un mensaje genérico a sus contactos advirtiendo que se encuentra en una situación de emergencia y necesita ayuda. También se enviará su geolocalización. El 112 no puede recibir este tipo de mensaje.',
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
      Divider(
        height: 10,
        color: Colors.black87,
      ),
      // Container(
      //   //height: 400,
      //   margin: EdgeInsets.only(left: 5),
      //   child: Column(
      //     children: [
      //       Row(
      //         children: [
      //           Container(
      //             child: Image(
      //                 image: AssetImage('assets/boton_home.png'),
      //                 fit: BoxFit.cover),
      //             height: 70,
      //             width: 70,
      //           ),
      //           Container(
      //             margin: EdgeInsets.only(left: 10),
      //             // height: 300,
      //             width: 250,
      //             child: Center(
      //               child: Text(
      //                 'Boton Inicio:',
      //                 textAlign: TextAlign.left,
      //                 style: TextStyle(fontSize: 20),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //       Container(
      //         width: double.infinity,
      //         margin: EdgeInsets.only(left: 6, right: 6, top: 3),
      //         child: Text(
      //           'Muestra el inicio de la lista de contenido',
      //           textAlign: TextAlign.left,
      //           style: TextStyle(fontSize: 20),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      // SizedBox(
      //   height: 10,
      // ),
      // Divider(
      //   height: 10,
      //   color: Colors.black87,
      // ),
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
                'Configuración de los contactos de emergencia, el mensaje de emergencia y color de Vitalfon.',
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

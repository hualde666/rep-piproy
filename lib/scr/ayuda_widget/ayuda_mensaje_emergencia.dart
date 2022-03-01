import 'package:flutter/material.dart';
import 'package:piproy/scr/ayuda_widget/ayuda_encabezado.dart';

class AyudaMensajeEmergenciaPage extends StatelessWidget {
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
    List<Widget> lista = [];
    lista.addAll(ayudaEncabezado(context, 'Mensaje de Emergencia'));
    List<Widget> lista2 = [
      SizedBox(
        height: 10,
      ),
      Container(
        margin: EdgeInsets.only(left: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // width: 150,
              // margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),

              child: Center(
                child: Text(
                  'Mensaje de Emergencia',
                  style: TextStyle(
                    fontSize: 25,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              //width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Escriba aquí el mesanje de emergencia que desea enviar a sus contacos en caso de una emergencia.  ',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 25, color: Theme.of(context).primaryColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Para cerrar el teclado, toque cualquier espacio fuera del mensaje de emergencia.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 10,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 150,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(192, 57, 43, 1),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Color.fromRGBO(192, 57, 43, 1),
                  )),
              child: Center(
                child: Text(
                  'guardar',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Container(
              //width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Guardará los cambios realizados al mensaje de emergencia.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 25, color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      ),
    ];
    lista.addAll(lista2);
    return lista;
  }
}

import 'package:flutter/material.dart';
import 'package:piproy/scr/ayuda_widget/ayuda_encabezado.dart';

class AyudaPaletaPage extends StatelessWidget {
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
    lista.addAll(ayudaEncabezado(context, 'Color de vitalfon'));
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
            SizedBox(
              height: 10,
            ),
            Container(
              //width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Selección de Color.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 25, color: Theme.of(context).primaryColor),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              //width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Solo tiene que tocar una de las opciones y color cambiará automaticamente.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 25, color: Theme.of(context).primaryColor),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    ];
    lista.addAll(lista2);
    return lista;
  }
}

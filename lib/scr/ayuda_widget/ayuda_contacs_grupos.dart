import 'package:flutter/material.dart';
import 'package:piproy/scr/ayuda_widget/ayuda_encabezado.dart';

class AyudaContacsGrupos extends StatelessWidget {
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
    lista.addAll(ayudaEncabezado(context, 'Grupos de Contactos'));
    List<Widget> lista2 = [
      Container(
        // height: 150,

        margin: EdgeInsets.only(left: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                  color:
                      /** es un contacto o grupo de contacto */
                      Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  )),
              child: Center(
                child: Text(
                  'Todos',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Container(
              //width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Muestra todos los contactos del celular',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 25, color: Theme.of(context).primaryColor),
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
        color: Theme.of(context).primaryColor,
      ),
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
              width: 150,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                  color:
                      /** es un contacto o grupo de contacto */
                      Color.fromRGBO(192, 57, 43, 1),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Color.fromRGBO(192, 57, 43, 1),
                  )),
              child: Center(
                child: Text(
                  '+ agregar',
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
                'Permite definir un nuevo grupo de contactos. Una vez creado, toque sobre el nombre del grupo. Pasara a otra pantalla que le permitira agregar los contactos del grupo.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 25, color: Theme.of(context).primaryColor),
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
        color: Theme.of(context).primaryColor,
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        // height: 150,

        margin: EdgeInsets.only(left: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              child: Icon(
                Icons.arrow_back,
                size: 50,
                color: Colors.blue,
              ),
            ),
            Container(
              //width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Permite copiar el grupo al menu principal, paara un acceso mas directo. Solo grupos creados por el usuario. ',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 25, color: Theme.of(context).primaryColor),
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
        color: Theme.of(context).primaryColor,
      ),
      Container(
        // height: 150,

        margin: EdgeInsets.only(left: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              child: Icon(
                Icons.close,
                size: 50,
                color: Colors.red,
              ),
            ),
            Container(
              //width: double.infinity,
              margin: EdgeInsets.only(left: 6, right: 6, top: 3),
              child: Text(
                'Permite eliminar un grupo',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 25, color: Theme.of(context).primaryColor),
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
        color: Theme.of(context).primaryColor,
      ),
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
                  'Cambiar nombre del grupo',
                  style: TextStyle(
                      fontSize: 25, color: Theme.of(context).primaryColor),
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
                'Presione por unos instantes sobre el nombre del grupo. Se abrirá una pequeña pantalla que le permitirá editarlo.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 25, color: Theme.of(context).primaryColor),
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
        color: Theme.of(context).primaryColor,
      ),
      SizedBox(
        height: 10,
      ),
    ];
    lista.addAll(lista2);
    return lista;
  }
}

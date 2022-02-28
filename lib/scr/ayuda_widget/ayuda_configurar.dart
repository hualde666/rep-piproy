import 'package:flutter/material.dart';
import 'package:piproy/scr/ayuda_widget/ayuda_encabezado.dart';

class AyudaConfigurarPage extends StatelessWidget {
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
    lista.addAll(ayudaEncabezado(context, 'Configuración'));
    List<Widget> lista2 = [
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
                margin: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Icon(
                      Icons.message,
                      size: 60,
                    )),
                    Container(
                      child: Center(
                        child: Text(
                          'Redactar mensaje de emergencia',
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
                        'Redacte/edite el mensaje de emergencia que recibirán los contactos seleccionados al pulsar el botón de emergencia (SOS)',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 25,
                            color: Theme.of(context).primaryColor),
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
                        child: Icon(
                      Icons.contact_phone,
                      size: 60,
                    )),
                    Container(
                      child: Center(
                        child: Text(
                          'Agregar o eliminar contactos de emergencia',
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
                        'Defina aquí cuales son los contactos que recibirán el mensaje de emergencia; deben ser seleccionados de los contactos incluidos en el telefono. Este mensaje solo será enviado a teléfonos móviles. No se envían mensajes al 112 o 911.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 25,
                            color: Theme.of(context).primaryColor),
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
            ]),
      )
    ];

    lista.addAll(lista2);
    return lista;
  }
}

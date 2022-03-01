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
                          textAlign: TextAlign.center,
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
                          textAlign: TextAlign.center,
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
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Icon(
                      Icons.groups,
                      size: 60,
                    )),
                    Container(
                      child: Center(
                        child: Text(
                          'Contactos',
                          textAlign: TextAlign.center,
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
                        'Se listan todos los grupos de contactos disponibles. Seleccione cuales deben mostrarse en la pantalla de inicio. Tambien podrá seleccionar  contactos para mostrar en la pantalla principal.',
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
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Icon(
                      Icons.app_registration,
                      size: 60,
                    )),
                    Container(
                      child: Center(
                        child: Text(
                          'Aplicaciones',
                          textAlign: TextAlign.center,
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
                        'Se listan todos los grupos de aplicaciones disponibles. Seleccione cuales deben mostrarse en la pantalla de inicio. Tambien podrá seleccionar aplicaciones para mostrar en la pantalla principal.',
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
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Icon(
                      Icons.engineering,
                      size: 60,
                    )),
                    Container(
                      child: Center(
                        child: Text(
                          'Habilitar y deshabilitar elementos',
                          textAlign: TextAlign.center,
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
                        'Permite seleccionar que elementos de vitalfon aparezcan en la pantalla principal.',
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
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Icon(
                      Icons.palette,
                      size: 60,
                    )),
                    Container(
                      child: Center(
                        child: Text(
                          'Color de vitalfon',
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
                        'Seleccione aquí el color del app según su preferencia',
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
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Icon(
                      Icons.email,
                      size: 60,
                    )),
                    Container(
                      child: Center(
                        child: Text(
                          'Contactanos',
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
                        'Este es nuestro email, contáctanos!',
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
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Icon(
                      Icons.play_circle,
                      size: 60,
                    )),
                    Container(
                      child: Center(
                        child: Text(
                          'Video',
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
                        'Algo mas sobre el app',
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

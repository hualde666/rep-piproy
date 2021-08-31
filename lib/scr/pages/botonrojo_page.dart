import 'package:flutter/material.dart';
import 'package:piproy/scr/funciones/lista_selecion_contactos.dart';
import 'package:piproy/scr/pages/envio_emergencia.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';
import 'package:piproy/scr/widgets/header_app.dart';
import 'package:sendsms/sendsms.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:contacts_service/contacts_service.dart';

import 'package:piproy/scr/models/items_lista_contactos.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class BotonRojoPage extends StatefulWidget {
  @override
  State<BotonRojoPage> createState() => _BotonRojoPageState();
}

class _BotonRojoPageState extends State<BotonRojoPage> {
  final listaSelectInfo = new ContactosProvider();
  List<String> listaIdContacto = [];

  List<ItemListaEmergencia> listaE = [];
  String mensaje = '';

  List<Contact> listaContactos = [];
  bool hayLista = true;

  @override
  void initState() {
    super.initState();
    cargarPrefs();
  }

  Future cargarPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    listaIdContacto = prefs.getStringList('listaE');
    if (listaIdContacto == null) {
      listaIdContacto = [];
      hayLista = false;
    }
    // Obtengo datos del mensaje y numeros de telefonos

    mensaje = prefs.getString('mensajeE');
    if (mensaje == null) {
      mensaje = "Necesito ayuda !!";
    }
    return;
  }

  Future<List<Contact>> cargarContactos() async {
    return await listaSelectInfo.listaContactos;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: HeaderApp(context, 'Alerta de Emergencia', Text(''), 0.0),
        body: FutureBuilder(
            future: cargarContactos(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (hayLista) {
                  listaE = generaListaE(snapshot.data, listaIdContacto);
                }
                return hayLista
                    ? conListaEmergenia(context, listaE, mensaje)
                    : sinListaEmergenia(context);
              }
            }),
      ),
    );
  }
}

conListaEmergenia(
    BuildContext context, List<ItemListaEmergencia> listaE, String mensaje) {
  return Center(
    child: Container(
      height: 400.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'EMERGENCIA ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 40.0,
            ),
          ),
          Text(
            'Enviar  mensaje de emergencia a familiares',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          ElevatedButton(
            child: Text('Enviar',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Theme.of(context).primaryColor,
                )
                // Theme.of(context).primaryColor),
                ),
            onPressed: () {
              //******************* */

              listaE[0].check = false;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResumenEnvioPage(listaE: listaE)));
            },
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(200, 0, 0, 1.0),
        borderRadius: BorderRadius.circular(20.0),
        // border: Border.all(color: Colors.white, width: 4.0)
      ),
    ),
  );
}

sinListaEmergenia(BuildContext context) {
  return Center(
    child: Container(
      height: 400.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'ADVERTENCIA',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 40.0,
            ),
          ),
          Text(
            'Debe registrar sus contactos de emergencia para poder notificar la emergencia',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ButtonStyle(),
                child: Text('Cancelar',
                    style: TextStyle(
                        fontSize: 25.0, color: Theme.of(context).primaryColor)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(249, 75, 11, 1),
        borderRadius: BorderRadius.circular(20.0),
        // border: Border.all(color: Colors.white, width: 4.0)
      ),
    ),
  );
}

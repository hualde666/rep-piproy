import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:piproy/scr/models/items_lista_contactos.dart';

import 'package:sendsms/sendsms.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

//import 'package:whatsapp_unilink/whatsapp_unilink.dart';
//import 'package:url_launcher/url_launcher.dart';
class BotonRojoPage extends StatefulWidget {
  @override
  State<BotonRojoPage> createState() => _BotonRojoPageState();
}

class _BotonRojoPageState extends State<BotonRojoPage> {
  List<String> listaIdContacto = [];

  List<ItemListaEmergencia> listaE = [];

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
    if (listaIdContacto.isEmpty) {
      listaIdContacto = [];
      hayLista = false;
    }
    return listaIdContacto;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Alerta de Emergencia'),
        backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
      ),
      body: FutureBuilder(
          future: cargarPrefs(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return hayLista
                  ? conListaEmergenia(context)
                  : sinListaEmergenia(context);
            }
          }),
    ));
  }
}

conListaEmergenia(BuildContext context) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                child: Text('Enviar',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Theme.of(context).primaryColor,
                    )
                    // Theme.of(context).primaryColor),
                    ),
                onPressed: () {
                  mandarSMS();

                  Navigator.pop(context);
                },
              ),
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

Future _geoLocal() async {
  bool serviceEnabled;
  LocationPermission permission;
  // Position pos;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  final pos = await Geolocator.getCurrentPosition();

  return pos;
}

Future<String> _getAddressFromLatLng(dynamic _currentPosition) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition.latitude, _currentPosition.longitude);

    Placemark place = placemarks[0];

    return " ${place.thoroughfare}  ${place.locality}   ${place.postalCode}  ${place.country}";
  } catch (e) {
    return "";
  }
}

Future<void> mandarSMS() async {
  final pos = await _geoLocal();
  final dir = await _getAddressFromLatLng(pos); // direcion en texto.

  final lat = pos.latitude;
  final lng = pos.longitude;
  final pos2 = ' https://maps.google.com/?q=$lat,$lng';

  final resp = await Sendsms.onGetPermission();
  if (resp.hashCode != null) {
    print(resp.hashCode);
  }

  // Obtengo datos del mensaje y numeros de telefonos
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _mensaje = prefs.getString('mensajeE');
  if (_mensaje == '') {
    _mensaje = "Necesito ayuda !!";
  }
  final List<String> listaIdContactos = prefs.getStringList('listaE');
// generar lita de telefonos
  final List<String> listaPhone = [];
  for (var phone in listaPhone) {
    if (await Sendsms.hasPermission()) {
      // Envio mensaje a cada telefono de la lista
      //final resp = await Sendsms.onSendSMS(phone, _mensaje);
      //final resp1 = await Sendsms.onSendSMS(phone, dir);
      //final resp2 = await Sendsms.onSendSMS(phone, pos2);
      FlutterOpenWhatsapp.sendSingleMessage(phone, _mensaje);
      //   final link = WhatsAppUnilink(
      //     phoneNumber: phone,
      //     text: _mensaje,
      //   );
      //   await launch('$link');
    }
  }
}

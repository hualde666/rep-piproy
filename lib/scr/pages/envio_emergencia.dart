import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:piproy/scr/models/items_lista_contactos.dart';
import 'package:sendsms/sendsms.dart';

class ResumenEnvioPage extends StatelessWidget {
  final List<ItemListaEmergencia> listaE;
  final String mensaje;
  ResumenEnvioPage({this.listaE, this.mensaje});
  @override
  Widget build(BuildContext context) {
    mandarSMS(listaE, mensaje);
    return Scaffold(
        //  backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            title: Container(
              padding: EdgeInsets.only(top: 15.0),
              alignment: Alignment.center,
              height: 80,
              width: 500,
              child: Column(
                children: [
                  Text(
                    'Resumen Mensajes',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Enviados',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
          ),
        ),
        body: Container(
          height: 500,
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
          child: ListView.builder(
            itemCount: listaE.length,
            itemBuilder: (context, i) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      height: 12,
                    ),
                    listaE[i].check
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                  listaE[i].nombre,
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 30),
                                ),
                                Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Mensaje Enviado',
                                      style: TextStyle(fontSize: 20),
                                    ))
                              ])
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                  listaE[i].nombre,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 30),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Text('Mensaje No Enviado',
                                      style: TextStyle(fontSize: 20)),
                                )
                              ]),
                  ],
                ),
              );
            },
          ),
        ));
  }
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

placemarkFromCoordinates(latitude, longitude) {}

Future<void> mandarSMS(List<ItemListaEmergencia> listaE, String mensaje) async {
  // final pos = await _geoLocal();
  // final dir = await _getAddressFromLatLng(pos); // direcion en texto.

//  final lat = pos.latitude;
//  final lng = pos.longitude;
//  final pos2 = ' https://maps.google.com/?q=$lat,$lng';

  final resp = await Sendsms.onGetPermission();
  if (resp.hashCode != null) {
    print('Permisos: ${resp.hashCode}');

    // generar lita de telefonos

    for (var contacto in listaE) {
      String _phone = contacto.phone;

      /// ENVIAR MENSAJE
      if (await Sendsms.hasPermission()) {
        //Envio mensaje a cada telefono de la lista
        final resp = await Sendsms.onSendSMS(_phone, mensaje);
        // final resp1 = await Sendsms.onSendSMS(_phone, dir);
        // final resp2 = await Sendsms.onSendSMS(_phone, pos2);
        print('Respuesta: $resp  ');
        if (!resp) {
          contacto.check = false;
        }
      }
    }
  }
}

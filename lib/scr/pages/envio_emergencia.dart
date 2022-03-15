import 'package:flutter/material.dart';

//import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:piproy/channel/channel_android.dart';
import 'package:piproy/scr/models/contactos_modelo.dart';

import 'package:piproy/scr/widgets/tres_botones_header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';

class ResumenEnvioPage extends StatelessWidget {
  final List<ContactoDatos> listaE;
  final String mensaje;
  ResumenEnvioPage({this.listaE, this.mensaje});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          //  backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
          appBar: headerResumen(context),
          body: Container(
            height: 500,
            // color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            child: ListView.builder(
              itemCount: listaE.length,
              itemBuilder: (context, i) {
                return Container(
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            listaE[i].nombre,
                            style: TextStyle(fontSize: 35),
                          ),
                          Container(
                              child: Text(
                            'Mensaje Enviado',
                            style: TextStyle(fontSize: 20),
                          )),
                          SizedBox(
                            height: 5,
                          )
                        ]));
              },
            ),
          )),
    );
  }
}

Widget headerResumen(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(200.0),
    // here the desired height
    child: Container(
      padding: EdgeInsets.only(top: 5),
      height: 200,
      child: Column(
        children: [
          tresBotonesHeader(context, true, 'ResumenEnvio'),
          Text('Resumen de Mensaje', style: TextStyle(fontSize: 30)),
        ],
      ),
    ),
  );
}

Future _geoLocal() async {
  // bool serviceEnabled;
  // LocationPermission permission;
  // // Position pos;

  // // Test if location services are enabled.
  // serviceEnabled = await Geolocator.isLocationServiceEnabled();
  // if (!serviceEnabled) {
  //   // Location services are not enabled don't continue
  //   // accessing the position and request users of the
  //   // App to enable the location services.
  //   return Future.error('Location services are disabled.');
  // }

  // permission = await Geolocator.checkPermission();
  // if (permission == LocationPermission.denied) {
  //   permission = await Geolocator.requestPermission();
  //   if (permission == LocationPermission.denied) {
  //     // Permissions are denied, next time you could try
  //     // requesting permissions again (this is also where
  //     // Android's shouldShowRequestPermissionRationale
  //     // returned true. According to Android guidelines
  //     // your App should show an explanatory UI now.
  //     return Future.error('Location permissions are denied');
  //   }
  // }

  // if (permission == LocationPermission.deniedForever) {
  //   // Permissions are denied forever, handle appropriately.
  //   return Future.error(
  //       'Location permissions are permanently denied, we cannot request permissions.');
  // }

  //final pos = await Geolocator.getCurrentPosition();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  Location location = new Location();
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  final pos = await location.getLocation();

  return pos;
}

mandarSMS(List<ContactoDatos> listaE) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String mensaje = prefs.getString('mensajeE');
  String pos2 = "";
  if (mensaje == null) {
    mensaje = "Necesito ayuda !!";
  }
  AndroidChannel _androidChannel = AndroidChannel();

  ///  preguntar si GPS prendido
  bool gpson = await _androidChannel.conectadoGps();
  if (gpson) {
    final pos = await _geoLocal();
    //final dir = await _getAddressFromLatLng(pos); // direcion en texto.

    final lat = pos.latitude;
    final lng = pos.longitude;
    pos2 = ' https://maps.google.com/?q=$lat,$lng';
  }

  for (int i = 0; i < listaE.length; i++) {
    final _phone = listaE[i].telefono;
    final telephony = Telephony.instance;
    telephony.sendSms(to: _phone, message: mensaje + pos2);
    //await _androidChannel.mandarSms(_phone, mensaje + pos2);
  }
}

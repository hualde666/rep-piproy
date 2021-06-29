import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:sendsms/sendsms.dart';

class BotonRojoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Emergencia')),
        body: Center(
          child: Container(
            height: 480.0,
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
                      child: Text(
                        'Enviar',
                        style: TextStyle(fontSize: 25.0, color: Colors.green),
                      ),
                      onPressed: () {
                        mandarSMS();

                        Navigator.pop(context);
                      },
                    ),
                    ElevatedButton(
                      style: ButtonStyle(),
                      child: Text('Cancelar',
                          style:
                              TextStyle(fontSize: 25.0, color: Colors.green)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.white, width: 4.0)),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              tooltip: 'agregar',
              heroTag: 'agregar',
              onPressed: () {
                Navigator.pushNamed(context, 'emergiContactos');
              },
            ),
            SizedBox(
              width: 20.0,
            ),
            FloatingActionButton(
              child: Icon(Icons.check),
              tooltip: 'regresar',
              heroTag: 'regresar',
              onPressed: () {
                // *** actualizar BD ***
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
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
    print(e);
    return "";
  }
}

Future<void> mandarSMS() async {
  String _phone = '+0414-3811785';
  final pos = await _geoLocal();
  final dir = await _getAddressFromLatLng(pos); // direcion en texto.

  String _sms = 'E M E R G E N C I A      MAMÁ Necesita ayuda. Ubicacion:';
  // String sms = _sms + dir;

  final lat = pos.latitude;
  final lng = pos.longitude;
  final pos2 = 'https://maps.google.com/?q=$lat,$lng';

  final resp = await Sendsms.onGetPermission();
  if (resp.hashCode != null) {
    print(resp.hashCode);
  }

  if (await Sendsms.hasPermission()) {
    final resp = await Sendsms.onSendSMS(_phone, _sms);
    final resp1 = await Sendsms.onSendSMS(_phone, dir);
    final resp2 = await Sendsms.onSendSMS(_phone, pos2);
  }
}

//    Scaffold(
//     // appBar: AppBar(
//     //   backgroundColor: Colors.red[900],
//     //   textTheme: TextTheme(
//     //       headline1: TextStyle(color: Colors.white, fontSize: 30.0)),
//     //   title: Text('LLAMADA DE EMERGENCIA'),
//     // ),
//     body: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           BotonRojo('emergencia'),
//           SizedBox(
//             height: 50.0,
//           ),
//           BotonCancelar(),
//         ],
//       ),
//     ),
//     floatingActionButton: Icon(
//       Icons.edit,
//       size: 30.0,
//       color: Colors.red,
//     ),
//   );
// }
// }

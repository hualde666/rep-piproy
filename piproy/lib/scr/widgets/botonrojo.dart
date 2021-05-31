import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sendsms/sendsms.dart';
//import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:geolocator_platform_interface/src/enums/location_accuracy.dart';

class BotonRojo extends StatelessWidget {
  String pagina;

  BotonRojo(String pagina) {
    this.pagina = pagina;
  }

//  RoundedRectangleBorder(
//         side: BorderSide(color: Colors.white, width: 2.0),
//         borderRadius: BorderRadius.circular(20.0),
//       )
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.red),
      ),
      child: Text(
        'EMERGENCIA',
        style: TextStyle(color: Colors.white, fontSize: 35.0),
      ),

      // style: ButtonStyle(backgroundColor: Color.),
      onPressed: () {
        if (pagina == 'home') {
          Navigator.pushNamed(context, 'botonRojo');
        } else {
          // _hacerCorreo();
          // _hacerLLamada();
          mandarSMS();
          // _geoLocal();

          Navigator.pop(context);
        }
      },
    );
  }

  // Future<String> _geoLocal() async {
  //   Location location = new Location();
  //   final String _direccion = '';

  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;
  //   LocationData _locationData;

  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return "";
  //     }
  //   }

  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return "";
  //     }
  //   }

  //   _locationData = await location.getLocation();

  //   final lat = _locationData.latitude;
  //   final lng = _locationData.longitude;
  //   final pos = 'https://maps.google.com/?q=$lat,$lng';
  //   print('Geolocalizacion:   ************ $_locationData ; $pos ****');
  //   return pos;
  // }
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

  Future<void> _hacerLLamada() async {
    String _phone = '+212 372 04 57';
    String url = 'tel:$_phone';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<String> _getAddressFromLatLng(dynamic _currentPosition) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];

      return " ${place.thoroughfare}, ${place.locality},  ${place.postalCode}, ${place.country}";
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
    String _sms2 = pos2;
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

  //***           ENVIAR CORREO DE EMERGENCIA */
  Future<void> _hacerCorreo() async {
    //****   OPCION PRENDE ALARMAS DE SEGURIDAD */
    // String username = 'hualdemirene@gmail.com';
    // String password = '03570357IHs';

    // final smtpServer = gmail(username, password);

    // final message = Message()
    //   ..from = Address(username, 'hualdemirene@gmail.com')
    //   ..recipients.add('irenehualde@hotmail.com')
    //   // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    //   // ..bccRecipients.add(Address('bccAddress@example.com'))
    //   ..subject = 'E M E R G E N C I A :: 😀 :: ${DateTime.now()}'
    //   ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    //   ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";
    // try {
    //   final sendReport = await send(message, smtpServer);
    //   print('Message sent: ' + sendReport.toString());
    // } on MailerException catch (e) {
    //   print('Message not sent.');
    //   for (var p in e.problems) {
    //     print('Problem: ${p.code}: ${p.msg}');
    //   }
    // }
    /// **************************************
    ///         CORREO CON OPCION DE FLUTTER
    // final Email email = Email(
    //   body: 'Prueba proyecto pi',
    //   subject: 'E M E R G E N C I A',
    //   recipients: ['irenehualde@hotmail.com'],
    //   cc: ['airinhualde@gmail.com'],
    //   // bcc: ['bcc@example.com'],
    //   // attachmentPaths: ['/path/to/attachment.zip'],
    //   isHTML: true,
    // );

    // String platformResponse;

    // try {
    //   await FlutterEmailSender.send(email);
    //   platformResponse = 'success';
    //   print('Cprreo enviado');
    // } catch (error) {
    //   print('NO se envio el correo');
    //   platformResponse = error.toString();
    // }

    //    CORREO CON url_launcher FUNCIONA PEROOOO... DEBO DAR SEND AL CORREO
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'irenehualde@hotmail.com',
        queryParameters: {'subject': 'Ejemplo correo de EMERGENCIa'});
    if (await canLaunch(_emailLaunchUri.toString())) {
      print('enviar correo');
      launch(_emailLaunchUri.toString());
    } else {
      print('No envia correo  ${_emailLaunchUri.toString()}');
    }
  }
}

class Position {}

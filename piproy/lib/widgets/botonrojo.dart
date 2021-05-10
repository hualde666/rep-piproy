import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sendsms/sendsms.dart';
import 'package:location/location.dart';

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
    return Container(
      width: double.infinity,
      height: 100.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.red[900],
      //decoration: Colors.red[900],
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.call,
              size: 50.0,
              color: Colors.white,
            ),
            //  SizedBox(width: 20.0),
            Text(
              'EMERGENCIA',
              style: TextStyle(color: Colors.white, fontSize: 35.0),
            ),
          ],
        ),
        // style: ButtonStyle(backgroundColor: Color.),
        onPressed: () {
          if (pagina == 'home') {
            Navigator.pushNamed(context, 'botonRojo');
          } else {
            // _hacerCorreo();
            // _hacerLLamada();
            //_mandarSMS();
            _geoLocal();

            Navigator.pop(context);
          }
        },
      ),
    );
  }

  Future<void> _geoLocal() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

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

    _locationData = await location.getLocation();
    print(_locationData);
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

  Future<void> _mandarSMS() async {
    String _phone = '+0414-3811785';
    String _sms = 'E M E R G E N C I A      MAMÁ Necesita ayuda   ';
    final resp = await Sendsms.onGetPermission();
    if (resp.hashCode != null) {
      print(resp.hashCode);
    }

    if (await Sendsms.hasPermission()) {
      await Sendsms.onSendSMS(_phone, _sms);
    }
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
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

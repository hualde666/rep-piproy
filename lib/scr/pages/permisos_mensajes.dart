import 'package:flutter/material.dart';
import 'package:piproy/channel/channel_android.dart';
import 'package:piproy/scr/pages/permisos_geoloc.dart';

class MensajesPermisos extends StatelessWidget {
  // GpsPage({@required context});
  //BuildContext context;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Container(
                  //  color: Colors.green,
                  width: double.infinity,
                  height: 100,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 40,
                        // top: 32,
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Image(
                              image: AssetImage('assets/icon_otro_blanco.png'),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Positioned(
                        left: 80,
                        top: 10,
                        child: Text(
                          'vitalfon',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 60,
                              color: Color.fromARGB(255, 79, 180, 238),
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Para enviar tu alerta en caso de emergencia, necesitamos nos permitas enviar mensajes de texto (sms). Solo será enviado cuando vitalfon esté en pantalla y se presione el botón de emergencia.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 30,
                      color: Color.fromARGB(255, 4, 135, 211)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Icon(
                    Icons.message,
                    size: 80,
                    color: Color.fromARGB(255, 4, 135, 211),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  AndroidChannel _androidChannel = AndroidChannel();
                  await _androidChannel.permisoSms();

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => GeoPermisos()));
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    // side: BorderSide() ,
                    primary: Color.fromRGBO(249, 75, 11, 1)),
                child: Text(
                  'siguiente ->',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                )),
          ],
        ),
      ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton.extended(
      //     heroTag: "siguiente",
      //     // icon: Icon(
      //     //   Icons.save,
      //     // ),
      //     label: Text(
      //       'siguiente',
      //     ),
      //     onPressed: () async {
      //       AndroidChannel _androidChannel = AndroidChannel();
      //       await _androidChannel.permisoSms();

      //       Navigator.pushReplacement(context,
      //           MaterialPageRoute(builder: (context) => GeoPermisos()));
      //     })
    ));
  }
}

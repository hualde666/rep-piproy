import 'package:flutter/material.dart';

import 'package:piproy/channel/channel_android.dart';
import 'package:piproy/scr/pages/permisos_geoloc.dart';

//import 'package:piproy/channel/channel_android.dart';

class MensajesPermisos extends StatelessWidget {
  // GpsPage({@required context});
  //BuildContext context;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: 100,
                // ),
                Column(
                  children: [
                    Text(
                      'vitalfon',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 60,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      ' Para enviar tu alerta de emergencía, vamos a requerir que nos autorices a enviar mensajes de texto.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 35,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.extended(
            heroTag: "siguiente",
            // icon: Icon(
            //   Icons.save,
            // ),
            label: Text(
              'siguiente',
            ),
            onPressed: () async {
              AndroidChannel _androidChannel = AndroidChannel();
              //await _androidChannel.mandarSms("", "");
              await _androidChannel.permisoSms();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => GeoPermisos()));
            }),
      ),
    );
  }
}

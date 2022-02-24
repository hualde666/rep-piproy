import 'package:flutter/material.dart';
//import 'package:piproy/channel/channel_android.dart';
import 'package:piproy/scr/providers/estado_celular.dart';
import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';
//import 'package:geolocator/geolocator.dart';

class GpsPage extends StatelessWidget {
  // GpsPage({@required context});
  //BuildContext context;
  @override
  Widget build(BuildContext context) {
    final celProvider = Provider.of<EstadoProvider>(context);
    bool conectadoGps = celProvider.conexionGps;
    IconData icon = conectadoGps ? Icons.gps_fixed : Icons.gps_off;
    String titulo = conectadoGps ? 'Gps Conectado' : 'Gps Desconectado';
    String boton = conectadoGps ? 'Apagar' : 'Prender';
    Color color = conectadoGps ? Colors.green[900] : Colors.red[900];
    return SafeArea(
      child: Scaffold(
        appBar: headerApp(context, 'Gps', Text(''), 0.0, true, 'Gps'),
        backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
        body: Center(
          child: Container(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 120,
                  child: Center(
                    child: Text(
                      titulo,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 110.0,
                  height: 110.0,
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(80),
                      border: Border.all(color: Colors.white, width: 2.0)),
                  child: Center(
                      child: Icon(icon, size: 100.0, color: Colors.white)),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(80),
                      border: Border.all(color: Colors.white, width: 2.0)),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        //AndroidChannel _androidChannel = AndroidChannel();
                        // if (conectadoGps) {
                        //   onoffGps(false);
                        // } else {
                        //   onoffGps(true);
                        // }
                      },
                      child: Text(
                        boton,
                      ),
                      style: TextButton.styleFrom(
                          primary: Colors.black,
                          textStyle: TextStyle(
                            fontSize: 40,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future onoffGps(bool onoff) async {
  //await Geolocator.openAppSettings();
}

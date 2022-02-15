import 'package:flutter/material.dart';

import 'package:piproy/channel/channel_android.dart';
import 'package:piproy/scr/pages/permisos_llamadas.dart';

//import 'package:piproy/channel/channel_android.dart';

class GeoPermisos extends StatelessWidget {
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
                  // SizedBox(
                  //   height: 50,
                  // ),
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
                                    image: AssetImage(
                                        'assets/icon_otro_blanco.png'),
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
                        height: 20,
                      ),
                      Text(
                        ' Para enviar tu ubicación en caso de emergencia, necesitamos  nos autorices a acceder a tu geolocalización.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 35,
                            color: Color.fromARGB(255, 4, 135, 211)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton.extended(
                heroTag: "siguiente",
                label: Text(
                  'siguiente',
                ),
                onPressed: () async {
                  AndroidChannel _androidChannel = AndroidChannel();
                  await _androidChannel.permisoGeo();

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LLamadasPermisos()));
                })));
  }
}

import 'package:flutter/material.dart';
import 'package:piproy/channel/channel_android.dart';
import 'package:piproy/scr/pages/permisos_politicas_privasidad_page.dart';

class LLamadasPermisos extends StatefulWidget {
  @override
  State<LLamadasPermisos> createState() => _LLamadasPermisosState();
}

class _LLamadasPermisosState extends State<LLamadasPermisos> {
  bool autorizado = false;
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
                        ' Para facilitar tus llamadas, vamos a requerir que nos autorices a realizar llamadas. vitalfon solo realizará las llamadas que tu solicites.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 30,
                            color: Color.fromARGB(255, 4, 135, 211)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Icon(
                      Icons.phone,
                      size: 80,
                      color: Color.fromARGB(255, 4, 135, 211),
                    ),
                  ),
                  !autorizado
                      ? Container(
                          width: 170,
                          child: ElevatedButton(
                              onPressed: () async {
                                AndroidChannel _androidChannel =
                                    AndroidChannel();
                                // await FlutterPhoneDirectCaller.callNumber('');
                                await _androidChannel.permisoCall();
                                autorizado = true;
                                setState(() {});
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  // side: BorderSide() ,
                                  primary: Color.fromRGBO(249, 75, 11, 1)),
                              child: Text(
                                'autorizar ->',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              )),
                        )
                      : Container(),
                  autorizado
                      ? Container(
                          width: 170,
                          child: ElevatedButton(
                              onPressed: () async {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PolitcasPrivacidad()));
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  // side: BorderSide() ,
                                  primary: Color.fromRGBO(249, 75, 11, 1)),
                              child: Text(
                                'siguiente ->',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              )))
                      : Container(),
                ],
              ),
            )));
  }
}

import 'package:flutter/material.dart';
import 'package:piproy/channel/channel_android.dart';
import 'package:piproy/scr/pages/configuracion_page.dart';
import 'package:provider/provider.dart';
//import 'package:piproy/scr/pages/permisos_politicas_privasidad_page.dart';

import '../providers/usuario_pref.dart';
import '../widgets/logo_header.dart';

class LLamadasPermisos extends StatefulWidget {
  @override
  State<LLamadasPermisos> createState() => _LLamadasPermisosState();
}

class _LLamadasPermisosState extends State<LLamadasPermisos> {
  bool autorizado = false;
  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preferencias>(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          logoHeader(),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            ' Para facilitar tus llamadas, vamos a requerir que nos autorices a realizar llamadas. vitalfon solo realizará las llamadas que tu solicites.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 25,
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
                                          borderRadius:
                                              BorderRadius.circular(25)),
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
                                    pref.instalado = true;
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ConfiguracionPage()
                                            // PolitcasPrivacidad()
                                            ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      // side: BorderSide() ,
                                      primary:
                                          Color.fromARGB(255, 4, 135, 211)),
                                  child: Text(
                                    'siguiente ->',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  )))
                          : Container(),
                    ],
                  ),
                ),
              ),
            )));
  }
}

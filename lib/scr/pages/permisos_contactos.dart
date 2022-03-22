import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:piproy/scr/pages/permisos_mensajes.dart';

class InstalacionPage extends StatefulWidget {
  @override
  State<InstalacionPage> createState() => _InstalacionPageState();
}

class _InstalacionPageState extends State<InstalacionPage> {
  bool autorizado = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Text(
                  'Bienvenidos a:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 40,
                      color: Color.fromARGB(255, 4, 135, 211)),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  // color: Colors.green,
                  width: 250,
                  height: 100,
                  child: Center(
                    child: Stack(
                      children: [
                        Positioned(
                          left: 1,
                          // top: 32,
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Image(
                                image:
                                    AssetImage('assets/icon_otro_blanco.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Positioned(
                          left: 45,
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
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Para organizar tus contactos y registrar a cual notificar tus emergencia, vamos a requerir que nos permitas acceder a tus Contactos. ',
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
            Container(
              child: Icon(
                Icons.groups,
                size: 80,
                color: Color.fromARGB(255, 4, 135, 211),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            !autorizado
                ? Container(
                    width: 170,
                    child: ElevatedButton(
                        onPressed: () async {
                          autorizado = true;
                          await Permission.contacts.request();
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            // side: BorderSide() ,
                            primary: Color.fromRGBO(249, 75, 11, 1)),
                        child: Text(
                          'autorizar ->',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        )),
                  )
                : Container(),
            autorizado
                ? Container(
                    width: 170,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MensajesPermisos()));

                          // Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            primary: autorizado
                                ? Color.fromRGBO(249, 75, 11, 1)
                                : Colors.grey),
                        child: Text(
                          'siguiente ->',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        )),
                  )
                : Container(),
          ],
        ),
      )),
    ));
  }
}

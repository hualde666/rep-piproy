import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:piproy/scr/pages/mensajes_permisos.dart';

class InstalacionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
                child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      Text(
                        'Bienvenidos a:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 40,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
                        height: 10,
                      ),
                      Text(
                        'Para organizar tus contactos y registrar a cual notificar tus emergencia, vamos a requerir que nos permitas acceder a tus Contactos. ',
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
            )),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton.extended(
                heroTag: "siguiente",
                // icon: Icon(
                //   Icons.save,
                // ),
                label: Text(
                  'siguiente',
                ),
                onPressed: () async {
                  await Permission.contacts.request();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MensajesPermisos()));

                  // Navigator.pop(context);
                })));
  }
}

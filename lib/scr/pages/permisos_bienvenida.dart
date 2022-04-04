import 'package:flutter/material.dart';

import 'package:piproy/scr/pages/permisos_contactos.dart';

import '../widgets/logo_header.dart';

class BienvenidaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text(
                    'Bienvenidos a:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 30,
                        color: Color.fromARGB(255, 4, 135, 211)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  logoHeader(),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Text(
                        '    Manten a tus mayores conectados desde su movil. Podrán enviar mensajes de emergencia indicando su localzación.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: Color.fromARGB(255, 4, 135, 211)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '    Este app está pensado para personas con limitación visual, digitales u otras a las que resulte difícil el uso de celulares.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: Color.fromARGB(255, 4, 135, 211)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '    A continuación, se necesita que des algunas autorizaciones para brindar todas las funciones de vitalfon. ',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: Color.fromARGB(255, 4, 135, 211)),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InstalacionPage()));

                    // Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      // side: BorderSide() ,
                      primary: Color.fromARGB(255, 4, 135, 211)),
                  child: Text(
                    'siguiente ->',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
            ],
          ),
        ),
      )),
    ));
  }
}

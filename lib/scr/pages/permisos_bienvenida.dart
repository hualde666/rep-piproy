import 'package:flutter/material.dart';

import 'package:piproy/scr/pages/permisos_contactos.dart';

class BienvenidaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
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
                Column(
                  children: [
                    Text(
                      '    Manten a tus mayores conectados desde su movil. Podrán enviar mensajes de emergencia indicando su localzación.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 22,
                          color: Color.fromARGB(255, 4, 135, 211)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '    Este app está pensado para personas con limitación visual, digitales u otras a las que resulte difícil el uso de celulares.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 22,
                          color: Color.fromARGB(255, 4, 135, 211)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '    A continuación, se necesita que des algunas autorizaciones para brindar todas las funciones de vitalfon. ',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 22,
                          color: Color.fromARGB(255, 4, 135, 211)),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
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
                    primary: Color.fromRGBO(249, 75, 11, 1)),
                child: Text(
                  'siguiente ->',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                )),
          ],
        ),
      )),
    ));
  }
}

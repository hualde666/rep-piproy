import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';

import 'package:piproy/scr/pages/configuracion_page.dart';

import '../providers/usuario_pref.dart';

class PolitcasPrivacidad extends StatefulWidget {
  @override
  State<PolitcasPrivacidad> createState() => _PolitcasPrivacidadState();
}

class _PolitcasPrivacidadState extends State<PolitcasPrivacidad> {
  bool aceptar = false;
  final String politicasUrl =
      'https://sites.google.com/d/1aRiHejmhpBdjwwCNo8ulj3ktFx8Lx29I/p/1t4v-MW1Frd2ABg9yjq4XmngnJASvfLph/edit';
  // GpsPage({@required context});
  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preferencias>(context);

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
                  height: 50,
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        width: 0.5,
                        color: Colors.black,

                        // color: Colors.black,
                      )),
                  child: Column(
                    children: [
                      Text(
                        "Acepto los términos y condiciones de la polítiacas de privacidad:",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        textAlign: TextAlign.justify,
                      ),
                      Link(
                          uri: Uri.parse(politicasUrl),
                          builder: (_, followLink) {
                            return TextButton(
                              onPressed: followLink,
                              child: Text(
                                'Políticas de Privacidad',
                                style: TextStyle(
                                    fontSize: 25,
                                    //color: Colors.black,
                                    color: Color.fromARGB(255, 4, 135, 211),
                                    fontStyle: FontStyle.italic,
                                    decoration: TextDecoration.underline),
                              ),
                            );
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        //color: Colors.red,

                        width: 200,
                        child: CheckboxListTile(
                          title: Text(
                            "Acepto",
                            style: TextStyle(fontSize: 30),
                            textAlign: TextAlign.justify,
                          ),
                          value: aceptar,
                          onChanged: (newValor) {
                            setState(() {
                              aceptar = newValor;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Text(

                SizedBox(
                  height: 10,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 170,
                  child: ElevatedButton(
                      onPressed: () {
                        if (aceptar) {
                          pref.instalado = true;

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfiguracionPage()));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          // side: BorderSide() ,
                          primary: aceptar
                              ? Color.fromRGBO(249, 75, 11, 1)
                              : Colors.grey),
                      child: Text(
                        'comenzar ->',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      )),
                ),
                Container(
                  width: 170,
                  child: ElevatedButton(
                      onPressed: () {
                        if (!aceptar) {
                          SystemNavigator.pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          // side: BorderSide() ,
                          primary: Color.fromRGBO(249, 75, 11, 1)),
                      child: Text(
                        'salir',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

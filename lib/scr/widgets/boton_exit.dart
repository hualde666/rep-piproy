import 'dart:io';

import 'package:flutter/material.dart';

Widget BotonExit(BuildContext context) {
  return GestureDetector(
    onTap: () => {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.red[900],
          title: Container(
            width: 100,
            height: 100,
            child: Center(
              child: Text('¿Desea salir de PiProy ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, color: Colors.white)),
            ),
          ),

          //shape: CircleBorder(),
          elevation: 14.0,
          actionsPadding: EdgeInsets.symmetric(horizontal: 15.0),
          //actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            TextButton(
                onPressed: () {
                  exit(0);
                },
                child: ClipOval(
                  child: Container(
                    height: 80,
                    width: 80,
                    color: Colors.black38,
                    child: Center(
                      child: Text('Si',
                          style:
                              TextStyle(fontSize: 25.0, color: Colors.white)),
                    ),
                  ),
                )),
            TextButton(
                autofocus: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: ClipOval(
                    child: Container(
                        height: 80,
                        width: 80,
                        color: Colors.black38,
                        child: Center(
                            child: Text('No',
                                style: TextStyle(
                                    fontSize: 25.0, color: Colors.white))))))
          ],
        ),
      )
    },
    child: Center(
      child: Container(
        child: Image(
            image: AssetImage('assets/boton_exit.png'), fit: BoxFit.cover),
        height: 100,
        width: 100,
      ),
    ),
  );
}

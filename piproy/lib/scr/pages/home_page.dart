//******* lo necesito para el exit(1) **** */
import 'dart:io';

import 'package:flutter/material.dart';

//**** Propias del Proyecto */
import 'package:piproy/widgets/botonrojo.dart';
import 'package:piproy/widgets/pila_tiempo_clima.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.filter_alt,
              size: 30.0,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.exit_to_app,
                size: 30.0,
              ),
            )
          ],
          //:Icon(Icons.exit_to_app),

          title: Text(
            'Proyecto Pi',
          ),
          backgroundColor: Colors.teal,
        ),
        // backgroundColor: Colors.orange[800],
        body: ListView(children: [Pila_Timpo_Clima(), BotonRojo('home')]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context);
          },
          tooltip: 'Increment',
          child: Icon(Icons.plus_one, size: 30.0),
        ));
  }
}

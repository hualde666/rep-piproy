import 'package:flutter/material.dart';
import 'package:piproy/widgets/botoncancelar.dart';
import 'package:piproy/widgets/botonrojo.dart';

class BotonRojoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.red[900],
      //   textTheme: TextTheme(
      //       headline1: TextStyle(color: Colors.white, fontSize: 30.0)),
      //   title: Text('LLAMADA DE EMERGENCIA'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BotonRojo('emergencia'),
            SizedBox(
              height: 50.0,
            ),
            BotonCancelar(),
          ],
        ),
      ),
      floatingActionButton: Icon(
        Icons.edit,
        size: 30.0,
        color: Colors.red,
      ),
    );
  }
}

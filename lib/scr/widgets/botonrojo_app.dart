import 'package:flutter/material.dart';

Widget BotonRojoHeader(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pushNamed(context, 'botonRojo'),
    child: Center(
      child: ClipOval(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red[900],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
              child: Text(
            'Emergencia',
            style: TextStyle(color: Colors.white),
          )),
          height: 100,
          width: 100,
          //color: Colors.red),
        ),
      ),
    ),
  );
}

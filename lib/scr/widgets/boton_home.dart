import 'package:flutter/material.dart';

Widget BotonHomeHeader(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pop(context, 'home'),
    child: Center(
      child: ClipOval(
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(249, 75, 11, 1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
              child: Text(
            'Inicio',
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

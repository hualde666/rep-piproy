import 'package:flutter/material.dart';

Widget BotonBackHeader(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Center(
      child: ClipOval(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green[800],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
              child: Text(
            'Retorno',
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

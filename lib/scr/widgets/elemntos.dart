import 'package:flutter/material.dart';

Widget elementos(
    BuildContext context, Widget widget, double altura, String ruta) {
  return GestureDetector(
    child: Container(
      height: altura,
      margin: EdgeInsets.symmetric(vertical: 1.5, horizontal: 3.0),
      alignment: Alignment.center,
      child: widget,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.white)),
    ),
    onTap: () {
      if (ruta != '') {
        Navigator.pushNamed(context, ruta);
      }
    },
  );
}

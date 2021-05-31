import 'package:flutter/material.dart';

Widget elementos(
    BuildContext context, Widget widget, Color color, String ruta) {
  return GestureDetector(
    child: Container(
      height: 200.0,
      alignment: Alignment.center,
      child: widget,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.green)),
    ),
    onTap: () {
      Navigator.pushNamed(context, ruta);
    },
  );
}

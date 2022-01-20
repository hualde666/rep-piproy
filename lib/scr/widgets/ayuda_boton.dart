import 'package:flutter/material.dart';

class AyudaBoton extends StatelessWidget {
  AyudaBoton({String pagina});
  final String pagina = '';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'ayuda', arguments: pagina);
      },
      child: Container(
          width: 90,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.white30)),
          margin: EdgeInsets.only(right: 5),
          child: Center(
            child: Text(
              'AYUDA',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          )),
    );
  }
}

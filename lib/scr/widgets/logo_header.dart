import 'package:flutter/material.dart';

Container logoHeader() {
  return Container(
    //  color: Colors.green,
    width: double.infinity,
    height: 90,
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
  );
}

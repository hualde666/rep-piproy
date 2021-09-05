import 'package:flutter/material.dart';

Widget Hora(BuildContext context) {
  return Center(
    child: ClipRRect(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: Color.fromRGBO(55, 57, 84, 1.0),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white, width: 2.0)),
        child: Center(
          child: Column(
            children: [
              Text(
                'Lunes',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              Text(
                '06:25 pm',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              Text(
                'Agosto 16',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ),
        ),
        height: 100,
        width: 100,
        //color: Colors.red),
      ),
    ),
  );
}

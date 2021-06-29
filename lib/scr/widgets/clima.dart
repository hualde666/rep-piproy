import 'package:flutter/material.dart';

class Clima extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0,
      child: Card(
          child: Center(
            child: Text('Nublado 18º C',
                style: TextStyle(color: Colors.white, fontSize: 25.0)),
          ),
          elevation: 10.0,
          color: Colors.teal[600],
          shadowColor: Colors.teal,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(20.0),
          )),
    );
  }
}

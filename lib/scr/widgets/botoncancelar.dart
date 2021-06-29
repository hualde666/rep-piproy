import 'package:flutter/material.dart';

class BotonCancelar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green[900])),
      child: //  SizedBox(width: 20.0),
          Text(
        'CANCELAR',
        style: TextStyle(color: Colors.white, fontSize: 35.0),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}

import 'package:flutter/material.dart';

class BotonCancelar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 10.0,
      color: Colors.teal[600],
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_back,
              size: 50.0,
              color: Colors.white,
            ),
            SizedBox(width: 20.0),
            Text(
              'CANCELAR',
              style: TextStyle(color: Colors.white, fontSize: 35.0),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}

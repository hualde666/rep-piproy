import 'package:flutter/material.dart';

class BotonAyudaDibujo extends StatelessWidget {
  const BotonAyudaDibujo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.black38,
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 1,
              spreadRadius: 0.5,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
          border:
              Border.all(color: Theme.of(context).primaryColor, width: 0.5)),
      //   margin: EdgeInsets.only(right: 5),
      child: Center(
        child: Icon(
          Icons.help_outline_rounded,
          size: 40,
          color: Theme.of(context).primaryColor,
        ),
        // Text(
        //   'AYUDA',
        //   style:
        //       TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
      ),
    );
  }
}

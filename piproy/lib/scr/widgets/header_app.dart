import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/tres_botones_header.dart';

Widget HeaderApp(
    BuildContext context, String titulo, Widget otroWidget, double alto) {
  return PreferredSize(
    preferredSize: Size.fromHeight(200.0 + alto),
    // here the desired height
    child: Container(
      padding: EdgeInsets.only(top: 35),
      color: Color.fromRGBO(55, 57, 84, 1.0),
      height: 170 + alto,
      child: Column(
        children: [
          TresBotonesHeader(context),
          Text(titulo, style: TextStyle(color: Colors.white, fontSize: 20)),
          alto > 0
              ? Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    otroWidget,
                  ],
                )
              : SizedBox(),
        ],
      ),
    ),
  );
}

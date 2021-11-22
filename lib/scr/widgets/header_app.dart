import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/tres_botones_header.dart';

Widget headerApp(
    BuildContext context, String titulo, Widget otroWidget, double alto) {
  return PreferredSize(
    preferredSize: Size.fromHeight(180.0 + alto),

    // here the desired height
    child: Container(
      //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      padding: EdgeInsets.only(top: 5),
      color: Color.fromRGBO(55, 57, 84, 1.0),
      height: 155 + alto,
      width: double.infinity,
      child: Column(
        children: [
          tresBotonesHeader(context),
          SizedBox(
            height: 5,
          ),
          Text(titulo.toUpperCase(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 25)),
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

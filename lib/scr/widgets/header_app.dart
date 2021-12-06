import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/tres_botones_header.dart';

Widget headerApp(
    BuildContext context, String titulo, Widget otroWidget, double alto) {
  return PreferredSize(
    preferredSize: Size.fromHeight(180.0 + alto),

    // here the desired height
    child: Container(
      //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      //padding: EdgeInsets.only(top: 5),
      decoration: new BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Theme.of(context).primaryColor,

            Colors.white,
            Theme.of(context).scaffoldBackgroundColor,
            // Colors.white,
            // Colors.orange,
            // Color.fromRGBO(55, 57, 84, 1.0)
          ],
              stops: [
            0.2,
            0.5,
            0.7
          ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter)),
      //color: Color.fromRGBO(55, 57, 84, 1.0),
      height: 155 + alto,
      width: double.infinity,

      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          tresBotonesHeader(context),
          SizedBox(
            height: 10,
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
